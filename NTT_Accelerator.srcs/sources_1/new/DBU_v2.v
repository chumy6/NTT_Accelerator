`timescale 1ns / 1ns

//Dual butterfly unit (DBU).
//========= 这个版本是尝试资源复用的 ============//
module DBU_v2 #(
    parameter [11:0] q = 3329
)(
    input clk,
    input rst_n,        // 低电平有效复位
    input func_sel,         // 运算模式: 0=NTT, 1=INTT
    input [11:0] x1, y1, w1, // 第一组输入
    input [11:0] x2, y2, w2, // 第二组输入
    output [11:0] X1, Y1,     // 第一组输出
    output [11:0] X2, Y2,     // 第二组输出
    output dbu_valid          // 输出有效信号（10周期后持续有效）
);

    // 中间信号定义
    wire [11:0] t1_madd, t1_msub; // 第一组模加/模减结果
    wire [11:0] t2_madd, t2_msub; // 第二组模加/模减结果
    wire [11:0] modmul_in1_x, modmul_in1_y; // 模乘模块第一组输入
    wire [11:0] modmul_in2_x, modmul_in2_y; // 模乘模块第二组输入
    wire [11:0] modmul_out1, modmul_out2;   // 模乘模块输出
    wire [11:0] shift_in1, shift_in2;       // 移位寄存器输入
    wire [11:0] shift_out1, shift_out2;     // 移位寄存器输出
    wire [11:0] X1_ntt, Y1_ntt, X2_ntt, Y2_ntt; // NTT模式输出
    wire [11:0] X1_intt, Y1_intt, X2_intt, Y2_intt; // INTT模式输出
    
    // 有效信号计数器
    reg [3:0] valid_counter;
    reg valid_reg;
    
    // 模加/模减模块实例化 (组合逻辑)
    modular_add #(.q(3329)) mod_add1 (.a(x1), .b(y1), .T(t1_madd));
    modular_sub #(.q(3329)) mod_sub1 (.a(x1), .b(y1), .T(t1_msub));
    modular_add #(.q(3329)) mod_add2 (.a(x2), .b(y2), .T(t2_madd));
    modular_sub #(.q(3329)) mod_sub2 (.a(x2), .b(y2), .T(t2_msub));
    
    // 模乘输入选择逻辑
    assign modmul_in1_x = (func_sel == 1'b0) ? y1 : t1_msub; // NTT: y1, INTT: t1_msub
    assign modmul_in1_y = w1;
    assign modmul_in2_x = (func_sel == 1'b0) ? y2 : t2_msub; // NTT: y2, INTT: t2_msub
    assign modmul_in2_y = w2;
    
    // 模乘模块实例化 (10周期延迟)
    DMM_v2 dmm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .x1(modmul_in1_x),
        .y1(modmul_in1_y),
        .x2(modmul_in2_x),
        .y2(modmul_in2_y),
        .z1(modmul_out1),
        .z2(modmul_out2)
    );
    
    // 移位寄存器输入选择
    assign shift_in1 = (func_sel == 1'b0) ? x1 : t1_madd; // NTT: x1, INTT: t1_madd
    assign shift_in2 = (func_sel == 1'b0) ? x2 : t2_madd; // NTT: x2, INTT: t2_madd
    
    // 10级移位寄存器 (处理10周期延迟)
    reg [11:0] shift_reg1 [9:0];
    reg [11:0] shift_reg2 [9:0];
    integer i;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 10; i = i + 1) begin
                shift_reg1[i] <= 12'b0;
                shift_reg2[i] <= 12'b0;
            end
        end else begin
            // 第一级寄存器
            shift_reg1[0] <= shift_in1;
            shift_reg2[0] <= shift_in2;
            
            // 后续级联移位
            for (i = 1; i < 10; i = i + 1) begin
                shift_reg1[i] <= shift_reg1[i-1];
                shift_reg2[i] <= shift_reg2[i-1];
            end
        end
    end
    
    assign shift_out1 = shift_reg1[9];
    assign shift_out2 = shift_reg2[9];
    
    // 有效信号计数器逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_counter <= 4'd0;
            valid_reg <= 1'b0;
        end else begin
            if (valid_counter < 4'd10) begin
                valid_counter <= valid_counter + 4'd1;
            end else begin
                valid_reg <= 1'b1; // 计数到10后保持高电平
            end
        end
    end
    
    assign dbu_valid = valid_reg;
    
    // 模除以2函数 (组合逻辑)
    function [11:0] div_by_two;
        input [11:0] in;
        begin
            if (in[0] == 1'b0) begin
                // 偶数情况：直接右移一位
                div_by_two = in >> 1;
            end else begin
                // 奇数情况：右移一位后加上q+1/2并取模
                div_by_two = ((in >> 1) + (q+1/2)) % q;
            end
        end
    endfunction
    
    // NTT模式输出计算
    modular_add #(.q(3329)) add_ntt1 (.a(shift_out1), .b(modmul_out1), .T(X1_ntt));
    modular_sub #(.q(3329)) sub_ntt1 (.a(shift_out1), .b(modmul_out1), .T(Y1_ntt));
    modular_add #(.q(3329)) add_ntt2 (.a(shift_out2), .b(modmul_out2), .T(X2_ntt));
    modular_sub #(.q(3329)) sub_ntt2 (.a(shift_out2), .b(modmul_out2), .T(Y2_ntt));
    
    // INTT模式输出计算
    assign X1_intt = div_by_two(shift_out1);
    assign Y1_intt = div_by_two(modmul_out1);
    assign X2_intt = div_by_two(shift_out2);
    assign Y2_intt = div_by_two(modmul_out2);
    
    // 最终输出选择
    assign X1 = (func_sel == 1'b0) ? X1_ntt : X1_intt;
    assign Y1 = (func_sel == 1'b0) ? Y1_ntt : Y1_intt;
    assign X2 = (func_sel == 1'b0) ? X2_ntt : X2_intt;
    assign Y2 = (func_sel == 1'b0) ? Y2_ntt : Y2_intt;

endmodule

