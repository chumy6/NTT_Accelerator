`timescale 1ns / 1ns

// 12位模减法模块（参数化模数q）
module modular_sub #(
    parameter [11:0] q = 3329  // 可配置模数，默认值3329（12位）
)(
    input [11:0]      a,      // 被减数（12位无符号整数）
    input [11:0]      b,      // 减数（12位无符号整数）
    output reg [11:0] T       // 结果：(a - b) mod q
);
    
    reg signed [12:0] T1;     // 中间结果：a - b（带符号扩展为13位）
    reg signed [12:0] T2, T3; // 中间结果：添加不同偏移量后的结果
    
    always@(*) begin
        // 计算 a - b，并扩展为13位带符号数
        T1 = a - b;
        
        // 添加偏移量 q << 4 + 1（16q + 1）
        T2 = T1 + {q[11:4], 4'b1};
        
        // 添加更大的偏移量 q << 5 + 2（32q + 2）
        T3 = T1 + {q[11:4], 4'b1, 1'b0};
        
        // 根据符号位选择正确的结果
        if (T1[12] == 1'b0)        // T1 ≥ 0，直接使用T1
            T = T1[11:0];
        else if (T2[12] == 1'b0)   // T2 ≥ 0，使用T2
            T = T2[11:0];
        else                        // 否则使用T3
            T = T3[11:0];
    end
    
endmodule