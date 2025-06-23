`timescale 1ns / 1ns

//Dual butterfly unit (DBU).
//========= 这个版本是尝试资源复用的 ============//
module DBU_v2 #(
    parameter [11:0] q = 3329
)(
    input               clk,
    input               rst_n,
    input               func_sel,  // 0: NTT, 1: INTT
    input      [11:0]   x1, y1, w1,
    input      [11:0]   x2, y2, w2,
    output reg [11:0]   X1, Y1,
    output reg [11:0]   X2, Y2,
    output reg          dbu_valid
);

    // 阶段定义
    localparam ST_IDLE   = 3'd0;
    localparam ST_NTT_MUL= 3'd1;
    localparam ST_NTT_ADD= 3'd2;
    localparam ST_INT_ADD= 3'd3;
    localparam ST_INT_SUB= 3'd4;
    localparam ST_INT_MUL= 3'd5;
    localparam ST_DONE   = 3'd6;

    // 内部信号和寄存器
    reg [2:0]   state, next_state;
    reg [3:0]   dmm_latency;      // DMM延迟计数器
    reg         dmm_busy;         // DMM忙碌标志
    reg [11:0]  x1_reg, y1_reg, w1_reg;
    reg [11:0]  x2_reg, y2_reg, w2_reg;
    reg [11:0]  ntt_z1_reg, ntt_z2_reg;
    reg [11:0]  intt_t1_madd_reg, intt_t1_msub_reg;
    reg [11:0]  intt_t2_madd_reg, intt_t2_msub_reg;
    reg [11:0]  intt_y1_temp_reg, intt_y2_temp_reg;
    
    // DMM输入输出信号
    reg [11:0] dmm_x1, dmm_y1, dmm_x2, dmm_y2;
    wire [11:0] dmm_z1, dmm_z2;
    
    // 模加模减输入信号
    reg [11:0] add1_a, add1_b, add2_a, add2_b;
    reg [11:0] sub1_a, sub1_b, sub2_a, sub2_b;
    wire [11:0] intt_t1_madd, intt_t2_madd;
    wire [11:0] intt_t1_msub, intt_t2_msub;
    
    // 功能选择编码
    localparam NTT_MODE = 1'b0;
    localparam INTT_MODE = 1'b1;

    // 除以2的操作（右移1位）
    function automatic [11:0] div_by_two;
        input [11:0] in;
        begin
            div_by_two = (in[0] == 1'b1) ? (in + 1'b1) >> 1 : in >> 1;
        end
    endfunction

    // 模运算单元实例化
    DMM_v2 dmm_unit (
        .clk(clk),
        .rst_n(rst_n),
        .x1(dmm_x1),
        .y1(dmm_y1),
        .x2(dmm_x2),
        .y2(dmm_y2),
        .z1(dmm_z1),
        .z2(dmm_z2)
    );
    
    modular_add #(.q(q)) add_unit1 (
        .a(add1_a),
        .b(add1_b),
        .T(intt_t1_madd)
    );
    
    modular_add #(.q(q)) add_unit2 (
        .a(add2_a),
        .b(add2_b),
        .T(intt_t2_madd)
    );
    
    modular_sub #(.q(q)) sub_unit1 (
        .a(sub1_a),
        .b(sub1_b),
        .T(intt_t1_msub)
    );
    
    modular_sub #(.q(q)) sub_unit2 (
        .a(sub2_a),
        .b(sub2_b),
        .T(intt_t2_msub)
    );

    // 状态机控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= ST_IDLE;
            dmm_latency <= 4'b0;
            dmm_busy <= 1'b0;
            dbu_valid <= 1'b0;
        end else begin
            state <= next_state;
            
            // DMM延迟计数器控制
            if (dmm_busy) begin
                if (dmm_latency < 4'd9) begin
                    dmm_latency <= dmm_latency + 1'b1;
                end else begin
                    dmm_latency <= 4'b0;
                    dmm_busy <= 1'b0;
                end
            end
            
            // 输出有效标志控制
            if (state == ST_DONE) begin
                dbu_valid <= 1'b1;
            end else begin
                dbu_valid <= 1'b0;
            end
        end
    end

    // 状态转移逻辑
    always @(*) begin
        case (state)
            ST_IDLE:
                next_state = (func_sel == NTT_MODE) ? ST_NTT_MUL : ST_INT_ADD;
                
            ST_NTT_MUL:
                next_state = (dmm_busy && dmm_latency == 4'd9) ? ST_NTT_ADD : ST_NTT_MUL;
                
            ST_NTT_ADD:
                next_state = ST_DONE;
                
            ST_INT_ADD:
                next_state = ST_INT_SUB;
                
            ST_INT_SUB:
                next_state = ST_INT_MUL;
                
            ST_INT_MUL:
                next_state = (dmm_busy && dmm_latency == 4'd9) ? ST_DONE : ST_INT_MUL;
                
            ST_DONE:
                next_state = ST_IDLE;
                
            default:
                next_state = ST_IDLE;
        endcase
    end

    // 数据路径控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x1_reg <= 12'b0;
            y1_reg <= 12'b0;
            w1_reg <= 12'b0;
            x2_reg <= 12'b0;
            y2_reg <= 12'b0;
            w2_reg <= 12'b0;
            ntt_z1_reg <= 12'b0;
            ntt_z2_reg <= 12'b0;
            intt_t1_madd_reg <= 12'b0;
            intt_t1_msub_reg <= 12'b0;
            intt_t2_madd_reg <= 12'b0;
            intt_t2_msub_reg <= 12'b0;
            X1 <= 12'b0;
            Y1 <= 12'b0;
            X2 <= 12'b0;
            Y2 <= 12'b0;
        end else begin
            case (state)
                ST_IDLE: begin
                    // 保存输入数据
                    x1_reg <= x1;
                    y1_reg <= y1;
                    w1_reg <= w1;
                    x2_reg <= x2;
                    y2_reg <= y2;
                    w2_reg <= w2;
                    
                    if (func_sel == NTT_MODE) begin
                        // NTT模式：启动第一次模乘
                        dmm_x1 <= y1;
                        dmm_y1 <= w1;
                        dmm_x2 <= y2;
                        dmm_y2 <= w2;
                        dmm_busy <= 1'b1;
                    end else begin
                        // INTT模式：启动模加
                        add1_a <= x1;
                        add1_b <= y1;
                        add2_a <= x2;
                        add2_b <= y2;
                    end
                end
                
                ST_NTT_MUL: begin
                    if (dmm_busy && dmm_latency == 4'd9) begin
                        // 模乘完成，保存结果
                        ntt_z1_reg <= dmm_z1;
                        ntt_z2_reg <= dmm_z2;
                        
                        // 启动模加模减
                        add1_a <= x1_reg;
                        add1_b <= ntt_z1_reg;
                        sub1_a <= x1_reg;
                        sub1_b <= ntt_z1_reg;
                        add2_a <= x2_reg;
                        add2_b <= ntt_z2_reg;
                        sub2_a <= x2_reg;
                        sub2_b <= ntt_z2_reg;
                    end
                end
                
                ST_NTT_ADD: begin
                    // 保存NTT结果
                    X1 <= intt_t1_madd;  // 复用add单元的输出
                    Y1 <= intt_t1_msub;  // 复用sub单元的输出
                    X2 <= intt_t2_madd;
                    Y2 <= intt_t2_msub;
                end
                
                ST_INT_ADD: begin
                    // 保存INTT模加结果
                    intt_t1_madd_reg <= intt_t1_madd;
                    intt_t2_madd_reg <= intt_t2_madd;
                    
                    // 启动模减
                    sub1_a <= x1_reg;
                    sub1_b <= y1_reg;
                    sub2_a <= x2_reg;
                    sub2_b <= y2_reg;
                end
                
                ST_INT_SUB: begin
                    // 保存INTT模减结果
                    intt_t1_msub_reg <= intt_t1_msub;
                    intt_t2_msub_reg <= intt_t2_msub;
                    
                    // 启动INTT模乘
                    dmm_x1 <= intt_t1_msub_reg;
                    dmm_y1 <= w1_reg;
                    dmm_x2 <= intt_t2_msub_reg;
                    dmm_y2 <= w2_reg;
                    dmm_busy <= 1'b1;
                end
                
                ST_INT_MUL: begin
                    if (dmm_busy && dmm_latency == 4'd9) begin
                        // 模乘完成，保存结果并除以2
                        X1 <= div_by_two(intt_t1_madd_reg);
                        Y1 <= div_by_two(dmm_z1);
                        X2 <= div_by_two(intt_t2_madd_reg);
                        Y2 <= div_by_two(dmm_z2);
                    end
                end
                
                ST_DONE: begin
                    // 保持结果
                    X1 <= X1;
                    Y1 <= Y1;
                    X2 <= X2;
                    Y2 <= Y2;
                end
            endcase
        end
    end

endmodule
