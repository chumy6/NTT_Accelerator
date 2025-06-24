`timescale 1ns / 1ns

module Control_Unit (
    input clk,
    input rst_n,
    input [1:0] op_sel,       // 操作选择: 00=IDLE, 01=NTT, 10=INTT, 11=CWM
    input start,              // 启动信号
    output reg done,          // 操作完成信号
    output reg mem0_we,       // MEM0写使能
    output reg mem1_we,       // MEM1写使能
    output reg [5:0] mem_addr_a, // 存储器地址A
    output reg [5:0] mem_addr_b, // 存储器地址B
    output reg [5:0] twiddle_addr, // 旋转因子地址
    output reg func_sel,      // DBU功能选择: 0=NTT, 1=INTT
    input dbu_valid,          // DBU输出有效信号
    output reg result_valid,  // 结果有效信号
    output reg [6:0] result_addr // 结果地址
);

    // 状态机定义
    localparam IDLE     = 3'd0,
               LOAD     = 3'd1,
               COMPUTE  = 3'd2,
               STORE    = 3'd3,
               DONE     = 3'd4;
    
    reg [2:0] current_state, next_state;
    reg [8:0] cycle_count;    // 用于计数时钟周期
    reg [2:0] stage_count;    // 阶段计数 (0-6)
    reg [6:0] butterfly_count; // 蝶形运算计数 (0-127)
    reg [1:0] cwm_phase;      // CWM阶段 (0-3)
    
    // 状态机时序逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    // 状态转移逻辑
    always @(*) begin
        case (current_state)
            IDLE:
                if (start && op_sel != 2'b00)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            
            LOAD:
                // 根据不同操作确定加载完成条件
                if ((op_sel == 2'b01 || op_sel == 2'b10) && cycle_count == 9'd127)
                    next_state = COMPUTE;
                else if (op_sel == 2'b11 && cycle_count == 9'd255)
                    next_state = COMPUTE;
                else
                    next_state = LOAD;
            
            COMPUTE:
                // 根据不同操作确定计算完成条件
                if ((op_sel == 2'b01 || op_sel == 2'b10) && cycle_count == 9'd458)
                    next_state = STORE;
                else if (op_sel == 2'b11 && cycle_count == 9'd328)
                    next_state = STORE;
                else
                    next_state = COMPUTE;
            
            STORE:
                // 确定何时存储完成
                if (cycle_count == 9'd127)
                    next_state = DONE;
                else
                    next_state = STORE;
            
            DONE:
                if (!start) // 等待start信号释放
                    next_state = IDLE;
                else
                    next_state = DONE;
            
            default:
                next_state = IDLE;
        endcase
    end
    
    // 控制信号生成
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cycle_count <= 9'd0;
            stage_count <= 3'd0;
            butterfly_count <= 7'd0;
            cwm_phase <= 2'd0;
            mem0_we <= 1'b0;
            mem1_we <= 1'b0;
            mem_addr_a <= 6'd0;
            mem_addr_b <= 6'd0;
            twiddle_addr <= 6'd0;
            func_sel <= 1'b0;
            done <= 1'b0;
            result_valid <= 1'b0;
            result_addr <= 7'd0;
        end else begin
            case (current_state)
                IDLE: begin
                    cycle_count <= 9'd0;
                    stage_count <= 3'd0;
                    butterfly_count <= 7'd0;
                    cwm_phase <= 2'd0;
                    done <= 1'b0;
                    result_valid <= 1'b0;
                    
                    // 根据操作选择设置功能选择信号
                    if (start) begin
                        func_sel <= (op_sel == 2'b10) ? 1'b1 : 1'b0; // 10=INTT, 其他=NTT/CWM
                    end
                end
                
                LOAD: begin
                    cycle_count <= cycle_count + 1'b1;
                    
                    if (op_sel == 2'b11) begin // CWM操作
                        // CWM操作需要加载两组数据(a和b)
                        if (cycle_count < 9'd128) begin
                            // 加载a系数
                            mem_addr_a <= cycle_count[5:0]; // Mem0地址 (0-31)
                            mem_addr_b <= cycle_count[5:0]; // Mem1地址 (0-31)
                            mem0_we <= 1'b1;
                            mem1_we <= 1'b1;
                        end else begin
                            // 加载b系数
                            mem_addr_a <= cycle_count[5:0] - 6'd32; // Mem0地址 (33-64)
                            mem_addr_b <= cycle_count[5:0] - 6'd32; // Mem1地址 (33-64)
                            mem0_we <= 1'b1;
                            mem1_we <= 1'b1;
                        end
                    end else begin // NTT/INTT操作
                        // 加载a系数
                        mem_addr_a <= cycle_count[5:0]; // Mem0地址 (0-31)
                        mem_addr_b <= cycle_count[5:0]; // Mem1地址 (0-31)
                        mem0_we <= 1'b1;
                        mem1_we <= 1'b1;
                    end
                end
                
                COMPUTE: begin
                    cycle_count <= cycle_count + 1'b1;
                    
                    if (op_sel == 2'b11) begin // CWM操作
                        // CWM操作处理
                        case (cwm_phase)
                            2'd0: begin // 第一个NTT
                                mem_addr_a <= calculate_mem_addr_ntt(stage_count, butterfly_count);
                                mem_addr_b <= calculate_mem_addr_ntt(stage_count, butterfly_count + 1'b1);
                                twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    if (stage_count < 3'd6) begin
                                        stage_count <= stage_count + 1'b1;
                                    end else begin
                                        stage_count <= 3'd0;
                                        cwm_phase <= 2'd1;
                                    end
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                            
                            2'd1: begin // 第二个NTT (处理b系数)
                                mem_addr_a <= calculate_mem_addr_ntt_b(stage_count, butterfly_count);
                                mem_addr_b <= calculate_mem_addr_ntt_b(stage_count, butterfly_count + 1'b1);
                                twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    if (stage_count < 3'd6) begin
                                        stage_count <= stage_count + 1'b1;
                                    end else begin
                                        stage_count <= 3'd0;
                                        cwm_phase <= 2'd2;
                                    end
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                            
                            2'd2: begin // 系数乘法
                                mem_addr_a <= butterfly_count[6:1]; // Mem0地址 (0-31)
                                mem_addr_b <= butterfly_count[6:1] + 6'd32; // Mem1地址 (33-64)
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    cwm_phase <= 2'd3;
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                            
                            2'd3: begin // INTT
                                func_sel <= 1'b1; // 设置为INTT模式
                                mem_addr_a <= calculate_mem_addr_intt(stage_count, butterfly_count);
                                mem_addr_b <= calculate_mem_addr_intt(stage_count, butterfly_count + 1'b1);
                                twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    if (stage_count < 3'd6) begin
                                        stage_count <= stage_count + 1'b1;
                                    end
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                        endcase
                    end else begin // NTT/INTT操作
                        // 生成适当的地址以执行计算
                        if (op_sel == 2'b01) begin // NTT
                            mem_addr_a <= calculate_mem_addr_ntt(stage_count, butterfly_count);
                            mem_addr_b <= calculate_mem_addr_ntt(stage_count, butterfly_count + 1'b1);
                        end else begin // INTT
                            mem_addr_a <= calculate_mem_addr_intt(stage_count, butterfly_count);
                            mem_addr_b <= calculate_mem_addr_intt(stage_count, butterfly_count + 1'b1);
                        end
                        
                        twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                        
                        // 更新计数
                        if (butterfly_count == 7'd127) begin
                            butterfly_count <= 7'd0;
                            if (stage_count < 3'd6)
                                stage_count <= stage_count + 1'b1;
                        end else begin
                            butterfly_count <= butterfly_count + 1'b1;
                        end
                    end
                    
                    // 当DBU输出有效时，设置结果有效信号并生成结果地址
                    if (dbu_valid) begin
                        result_valid <= 1'b1;
                        result_addr <= butterfly_count;
                    end else begin
                        result_valid <= 1'b0;
                    end
                end
                
                STORE: begin
                    cycle_count <= cycle_count + 1'b1;
                    
                    // 存储计算结果
                    mem0_we <= 1'b1;
                    mem1_we <= 1'b1;
                    
                    // 根据cycle_count计算存储地址
                    mem_addr_a <= cycle_count[5:0]; // Mem0地址 (0-31)
                    mem_addr_b <= cycle_count[5:0] + 6'd32; // Mem1地址 (33-64)
                end
                
                DONE: begin
                    done <= 1'b1;
                    mem0_we <= 1'b0;
                    mem1_we <= 1'b0;
                end
            endcase
        end
    end
    
    // 辅助函数：根据阶段和蝶形运算数计算NTT存储器地址
    function [5:0] calculate_mem_addr_ntt;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] offset;
        begin
            offset = 7'd1 << stage; // 2^stage
            if (butterfly[stage] == 1'b0)
                calculate_mem_addr_ntt = (butterfly & ~offset) >> 1; // 偶数地址
            else
                calculate_mem_addr_ntt = ((butterfly & ~offset) >> 1) + 6'd32; // 奇数地址
        end
    endfunction
    
    // 辅助函数：根据阶段和蝶形运算数计算INTT存储器地址
    function [5:0] calculate_mem_addr_intt;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] reversed_butterfly;
        reg [6:0] offset;
        begin
            // 位逆序
            reversed_butterfly = ((butterfly & 7'b0000001) << 6) |
                                ((butterfly & 7'b0000010) << 4) |
                                ((butterfly & 7'b0000100) << 2) |
                                ((butterfly & 7'b0001000) >> 2) |
                                ((butterfly & 7'b0010000) >> 4) |
                                ((butterfly & 7'b0100000) >> 6) |
                                (butterfly & 7'b1000000);
            
            offset = 7'd1 << stage; // 2^stage
            if (reversed_butterfly[stage] == 1'b0)
                calculate_mem_addr_intt = (reversed_butterfly & ~offset) >> 1; // 偶数地址
            else
                calculate_mem_addr_intt = ((reversed_butterfly & ~offset) >> 1) + 6'd32; // 奇数地址
        end
    endfunction
    
    // 辅助函数：根据阶段和蝶形运算数计算CWM中b系数的NTT存储器地址
    function [5:0] calculate_mem_addr_ntt_b;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] offset;
        begin
            offset = 7'd1 << stage; // 2^stage
            if (butterfly[stage] == 1'b0)
                calculate_mem_addr_ntt_b = ((butterfly & ~offset) >> 1) + 6'd32; // 偶数地址(33-64)
            else
                calculate_mem_addr_ntt_b = ((butterfly & ~offset) >> 1); // 奇数地址(0-31)
        end
    endfunction
    
    // 辅助函数：根据阶段和蝶形运算数计算旋转因子地址
    function [5:0] calculate_twiddle_addr;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] twiddle_index;
        begin
            // 计算旋转因子索引
            twiddle_index = (butterfly << (3'd7 - stage)) & 7'd127;
            calculate_twiddle_addr = twiddle_index[6:1]; // 除以2，因为每两个旋转因子存一行
        end
    endfunction
    
endmodule    
