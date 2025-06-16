`timescale 1ns / 1ns

//Dual butterfly unit (DBU).
module DBU_v2(
    input clk,
    input rst_n,
    input [1:0] func_sel,  // 功能选择，2'b00:NTT, 2'b01:INTT, 2'b10:CWM
    input [11:0] x1, y1, w1,
    input [11:0] x2, y2, w2,
    output reg [11:0] X1, Y1,
    output reg [11:0] X2, Y2
);

    // 状态机定义
    localparam S_IDLE = 3'b000;
    localparam S_NTT_1 = 3'b001;
    localparam S_NTT_2 = 3'b010;
    localparam S_INTT_1 = 3'b011;
    localparam S_INTT_2 = 3'b100;
    localparam S_INTT_3 = 3'b101;
    // CWM操作存疑
    localparam S_CWM_1 = 3'b110;
    localparam S_CWM_2 = 3'b111;
    
    reg [2:0] state, next_state;
    
    // 中间结果寄存器
    reg [11:0] z1, z2;           // 模乘结果
    reg [11:0] t1_madd, t2_madd; // 模加结果
    reg [11:0] t1_msub, t2_msub; // 模减结果
    reg [11:0] Y1_temp, Y2_temp; // INTT临时结果
    
    // 模加模块控制信号
    reg madd_en;
    reg [11:0] madd_a1, madd_b1;
    reg [11:0] madd_a2, madd_b2;
    reg [11:0] madd_result1, madd_result2;
    reg madd_done;
    
    // 模减模块控制信号
    reg msub_en;
    reg [11:0] msub_a1, msub_b1;
    reg [11:0] msub_a2, msub_b2;
    reg [11:0] msub_result1, msub_result2;
    reg msub_done;
    
    // 模乘模块例化
    wire [11:0] dmm_z1, dmm_z2;
    reg dmm_en;
    
    DMM_v2 dmm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .x1(dmm_en ? (func_sel == 2'b00 ? y1 : (func_sel == 2'b01 ? t1_msub : 12'd0)) : 12'd0),
        .y1(dmm_en ? (func_sel == 2'b00 ? w1 : (func_sel == 2'b01 ? w1 : 12'd0)) : 12'd0),
        .x2(dmm_en ? (func_sel == 2'b00 ? y2 : (func_sel == 2'b01 ? t2_msub : 12'd0)) : 12'd0),
        .y2(dmm_en ? (func_sel == 2'b00 ? w2 : (func_sel == 2'b01 ? w2 : 12'd0)) : 12'd0),
        .z1(dmm_z1),
        .z2(dmm_z2)
    );
    
    // 模加/减操作计数器
    reg [1:0] op_count;
    
    // 状态机同步逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            op_count <= 2'd0;
        end else begin
            state <= next_state;
            
            if (madd_en || msub_en) begin
                op_count <= op_count + 1'b1;
            end else begin
                op_count <= 2'd0;
            end
        end
    end
    
    // 模加/减模块实现（简化版，实际需要完整的模加/减实现）
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            madd_result1 <= 12'd0;
            madd_result2 <= 12'd0;
            msub_result1 <= 12'd0;
            msub_result2 <= 12'd0;
            madd_done <= 1'b0;
            msub_done <= 1'b0;
        end else begin
            if (madd_en && op_count == 2'd1) begin
                // 模加实现（简化版）
                madd_result1 <= (madd_a1 + madd_b1) % 3329;
                madd_result2 <= (madd_a2 + madd_b2) % 3329;
                madd_done <= 1'b1;
            end else if (madd_en && op_count == 2'd2) begin
                madd_done <= 1'b0;
            end
            
            if (msub_en && op_count == 2'd1) begin
                // 模减实现（简化版）
                msub_result1 <= (madd_a1 >= madd_b1) ? (madd_a1 - madd_b1) : (madd_a1 - madd_b1 + 3329);
                msub_result2 <= (madd_a2 >= madd_b2) ? (madd_a2 - madd_b2) : (madd_a2 - madd_b2 + 3329);
                msub_done <= 1'b1;
            end else if (msub_en && op_count == 2'd2) begin
                msub_done <= 1'b0;
            end
        end
    end
    
    // 次态逻辑
    always @(*) begin
        case (state)
            S_IDLE:
                if (func_sel == 2'b00)
                    next_state = S_NTT_1;
                else if (func_sel == 2'b01)
                    next_state = S_INTT_1;
                else if (func_sel == 2'b10)
                    next_state = S_CWM_1;
                else
                    next_state = S_IDLE;
            
            S_NTT_1:
                if (dmm_en && dmm_z1 != 12'd0) // 假设模乘完成
                    next_state = S_NTT_2;
                else
                    next_state = S_NTT_1;
            
            S_NTT_2:
                if (madd_done && msub_done)
                    next_state = S_IDLE;
                else
                    next_state = S_NTT_2;
            
            S_INTT_1:
                if (madd_done && msub_done)
                    next_state = S_INTT_2;
                else
                    next_state = S_INTT_1;
            
            S_INTT_2:
                if (dmm_en && dmm_z1 != 12'd0) // 假设模乘完成
                    next_state = S_INTT_3;
                else
                    next_state = S_INTT_2;
            
            S_INTT_3:
                next_state = S_IDLE;
            
            S_CWM_1:
                // CWM算法第一步处理
                if (dmm_en && dmm_z1 != 12'd0) // 假设模乘完成
                    next_state = S_CWM_2;
                else
                    next_state = S_CWM_1;
            
            S_CWM_2:
                // CWM算法第二步处理
                if (madd_done)
                    next_state = S_IDLE;
                else
                    next_state = S_CWM_2;
            
            default:
                next_state = S_IDLE;
        endcase
    end
    
    // 输出逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            X1 <= 12'd0;
            Y1 <= 12'd0;
            X2 <= 12'd0;
            Y2 <= 12'd0;
            z1 <= 12'd0;
            z2 <= 12'd0;
            t1_madd <= 12'd0;
            t2_madd <= 12'd0;
            t1_msub <= 12'd0;
            t2_msub <= 12'd0;
            Y1_temp <= 12'd0;
            Y2_temp <= 12'd0;
            dmm_en <= 1'b0;
            madd_en <= 1'b0;
            msub_en <= 1'b0;
        end else begin
            case (state)
                S_IDLE: begin
                    dmm_en <= 1'b0;
                    madd_en <= 1'b0;
                    msub_en <= 1'b0;
                end
                
                S_NTT_1: begin
                    // 启动模乘
                    dmm_en <= 1'b1;
                    if (dmm_en && dmm_z1 != 12'd0) begin
                        z1 <= dmm_z1;
                        z2 <= dmm_z2;
                        dmm_en <= 1'b0;
                        
                        // 启动模加和模减
                        madd_en <= 1'b1;
                        msub_en <= 1'b1;
                        madd_a1 <= x1;
                        madd_b1 <= z1;
                        madd_a2 <= x2;
                        madd_b2 <= z2;
                        msub_a1 <= x1;
                        msub_b1 <= z1;
                        msub_a2 <= x2;
                        msub_b2 <= z2;
                    end
                end
                
                S_NTT_2: begin
                    if (madd_done && msub_done) begin
                        X1 <= madd_result1;
                        Y1 <= msub_result1;
                        X2 <= madd_result2;
                        Y2 <= msub_result2;
                        madd_en <= 1'b0;
                        msub_en <= 1'b0;
                    end
                end
                
                S_INTT_1: begin
                    // 启动模加和模减
                    madd_en <= 1'b1;
                    msub_en <= 1'b1;
                    madd_a1 <= x1;
                    madd_b1 <= y1;
                    madd_a2 <= x2;
                    madd_b2 <= y2;
                    msub_a1 <= x1;
                    msub_b1 <= y1;
                    msub_a2 <= x2;
                    msub_b2 <= y2;
                    
                    if (madd_done && msub_done) begin
                        t1_madd <= madd_result1;
                        t2_madd <= madd_result2;
                        t1_msub <= msub_result1;
                        t2_msub <= msub_result2;
                        madd_en <= 1'b0;
                        msub_en <= 1'b0;
                        
                        // 启动模乘
                        dmm_en <= 1'b1;
                    end
                end
                
                S_INTT_2: begin
                    if (dmm_en && dmm_z1 != 12'd0) begin
                        Y1_temp <= dmm_z1;
                        Y2_temp <= dmm_z2;
                        dmm_en <= 1'b0;
                    end
                end
                
                S_INTT_3: begin
                    // 除以2操作（右移一位）
                    X1 <= t1_madd >> 1;
                    Y1 <= Y1_temp >> 1;
                    X2 <= t2_madd >> 1;
                    Y2 <= Y2_temp >> 1;
                end
                
                S_CWM_1: begin
                    // CWM算法实现
                    // 五次模乘: z1 = y1*w1, z2 = y2*w2, z3 = x1*w1, z4 = x2*w2, z5 = y1*y2
                    // 这里简化为两次模乘，实际需要完整实现
                    dmm_en <= 1'b1;
                    if (dmm_en && dmm_z1 != 12'd0) begin
                        z1 <= dmm_z1;  // y1*w1
                        z2 <= dmm_z2;  // y2*w2
                        dmm_en <= 1'b0;
                        
                        // 启动下一轮模乘
                        dmm_en <= 1'b1;
                    end
                end
                
                S_CWM_2: begin
                    if (dmm_en && dmm_z1 != 12'd0) begin
                        // 完成剩余模乘和模加
                        // ...
                        
                        // 启动模加
                        madd_en <= 1'b1;
                        madd_a1 <= z1;  // 示例
                        madd_b1 <= z2;  // 示例
                        
                        if (madd_done) begin
                            X1 <= madd_result1;
                            Y1 <= z1;  // 示例
                            X2 <= z2;  // 示例
                            Y2 <= madd_result1;  // 示例
                            madd_en <= 1'b0;
                        end
                    end
                end
                
                default: begin
                    X1 <= 12'd0;
                    Y1 <= 12'd0;
                    X2 <= 12'd0;
                    Y2 <= 12'd0;
                    dmm_en <= 1'b0;
                    madd_en <= 1'b0;
                    msub_en <= 1'b0;
                end
            endcase
        end
    end
    
endmodule    