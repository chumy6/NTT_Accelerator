`timescale 1ns / 1ns

//Dual butterfly unit (DBU) with output valid flag
module DBU (
    input clk,
    input rst_n,
    input [1:0] func_sel,  // 功能选择：00-NTT, 01-INTT, 10-CWM
    input [11:0] x1, y1, w1,
    input [11:0] x2, y2, w2,
    output reg [11:0] X1, Y1,
    output reg [11:0] X2, Y2,
    output reg dbu_valid    // 输出有效标志
);

    // 内部信号声明
    wire [11:0] ntt_z1, ntt_z2;         // NTT模乘结果
    wire [11:0] intt_t1_madd, intt_t1_msub;  // INTT中间结果
    wire [11:0] intt_t2_madd, intt_t2_msub;
    wire [11:0] intt_y1_temp, intt_y2_temp;  // INTT模乘结果
    
    // CWM算法信号
    wire [11:0] cwm_z1, cwm_z2, cwm_z3, cwm_z4, cwm_z5;  // CWM模乘结果
    wire [11:0] cwm_t1, cwm_t2;                          // CWM模加结果
    
    // 延迟计数器
    reg [3:0] dmm_latency_cnt;  // 4位计数器，足够计数10个周期
    
    // 功能选择编码定义
    localparam NTT_MODE = 2'b00;
    localparam INTT_MODE = 2'b01;
    localparam CWM_MODE = 2'b10;
    
    // 模乘模块实例化（用于NTT和CWM）
    DMM_v2 ntt_dmm (
        .clk(clk),
        .rst_n(rst_n),
        .x1(y1),
        .y1(w1),
        .x2(y2), 
        .y2(w2),
        .z1(ntt_z1),
        .z2(ntt_z2)
    );
    
    // 模加模块实例化（用于INTT和CWM）
    modular_add intt_add1 (
        .a(x1),
        .b(y1),
        .T(intt_t1_madd)
    );
    
    modular_add intt_add2 (
        .a(x2),
        .b(y2),
        .T(intt_t2_madd)
    );
    
    // 模减模块实例化（用于INTT和NTT）(模减的顺序)
    modular_sub intt_sub1 (
        .a(x1),
        .b(y1),
        .T(intt_t1_msub)
    );
    
    modular_sub intt_sub2 (
        .a(x2),
        .b(y2),
        .T(intt_t2_msub)
    );
    
    // INTT模乘模块实例化
    DMM_v2 intt_dmm (
        .clk(clk),
        .rst_n(rst_n),
        .x1(intt_t1_msub),
        .y1(w1),
        .x2(intt_t2_msub), 
        .y2(w2),
        .z1(intt_y1_temp),
        .z2(intt_y2_temp)
    );
    
    // CWM算法需要5个模乘模块和2个模加模块
    DMM_v2 cwm_dmm1 (
        .clk(clk),
        .rst_n(rst_n),
        .x1(x1),
        .y1(y1),
        .x2(x2), 
        .y2(y2),
        .z1(cwm_z1),
        .z2(cwm_z2)
    );
    
    DMM_v2 cwm_dmm2 (
        .clk(clk),
        .rst_n(rst_n),
        .x1(x1),
        .y1(y1),
        .x2(x2), 
        .y2(x2),
        .z1(cwm_z3),
        .z2(cwm_z4)
    );
    
    DMM_v2 cwm_dmm3 (
        .clk(clk),
        .rst_n(rst_n),
        .x1(w1),
        .y1(cwm_z3),
        .x2(w2), 
        .y2(cwm_z4),
        .z1(cwm_z5),
        .z2() // 第二个输出未使用
    );
    
    modular_add cwm_add1 (
        .a(cwm_z1),
        .b(cwm_z5),
        .T(cwm_t1)
    );
    
    modular_add cwm_add2 (
        .a(cwm_z2),
        .b(cwm_z5),
        .T(cwm_t2)
    );
    
    // 除以2的操作实现（右移一位）
    function [11:0] div_by_two;
        input [11:0] in;
        begin
            // 处理奇数情况：(a + 1)/2
            if (in[0] == 1'b1) begin
                div_by_two = (in + 1'b1) >> 1;
            end else begin
                div_by_two = in >> 1;
            end
        end
    endfunction
    
    // 内部信号用于NTT的模加和模减结果
    wire [11:0] ntt_add1_out, ntt_sub1_out;
    wire [11:0] ntt_add2_out, ntt_sub2_out;
    
    // 实例化NTT模加和模减模块
    modular_add ntt_add1 (
        .a(x1),
        .b(ntt_z1),
        .T(ntt_add1_out)
    );
    
    modular_sub ntt_sub1 (
        .a(x1),
        .b(ntt_z1),
        .T(ntt_sub1_out)
    );
    
    modular_add ntt_add2 (
        .a(x2),
        .b(ntt_z2),
        .T(ntt_add2_out)
    );
    
    modular_sub ntt_sub2 (
        .a(x2),
        .b(ntt_z2),
        .T(ntt_sub2_out)
    );
    
    // DMM延迟计数器控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dmm_latency_cnt <= 4'b0;
            dbu_valid <= 1'b0;
        end else begin
            // 计数器从0到9计数10个周期
            if (dmm_latency_cnt < 4'd9) begin
                dmm_latency_cnt <= dmm_latency_cnt + 1'b1;
                dbu_valid <= 1'b0;
            end else begin
                dbu_valid <= 1'b1;
            end
        end
    end
    
    // 输出结果选择，仅在DMM输出有效时更新
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            X1 <= 12'b0;
            Y1 <= 12'b0;
            X2 <= 12'b0;
            Y2 <= 12'b0;
        end else if (dbu_valid) begin  // 仅当输出有效时更新结果
            case (func_sel)
                NTT_MODE: begin
                    X1 <= ntt_add1_out;
                    Y1 <= ntt_sub1_out;
                    X2 <= ntt_add2_out;
                    Y2 <= ntt_sub2_out;
                end
                
                INTT_MODE: begin
                    X1 <= div_by_two(intt_t1_madd);
                    Y1 <= div_by_two(intt_y1_temp);
                    X2 <= div_by_two(intt_t2_madd);
                    Y2 <= div_by_two(intt_y2_temp);
                end
                
                CWM_MODE: begin
                    X1 <= cwm_t1;
                    Y1 <= cwm_z3;
                    X2 <= cwm_z4;
                    Y2 <= cwm_t2;
                end
                
                default: begin
                    X1 <= 12'b0;
                    Y1 <= 12'b0;
                    X2 <= 12'b0;
                    Y2 <= 12'b0;
                end
            endcase
        end else begin
            // 保持之前的有效结果
            X1 <= X1;
            Y1 <= Y1;
            X2 <= X2;
            Y2 <= Y2;
        end
    end
    
endmodule
