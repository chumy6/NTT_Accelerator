`timescale 1ns / 1ns

//这个版本是没有输出寄存器的
module DMM#(
    parameter q = 3329, // modular
    parameter alpha = 3,
    parameter q1 = 7,
    parameter q2 = 31,
    parameter q3 = 32
)(
    input clk,
    input rst_n,        // 低电平有效的复位信号
    input [11:0] x1, y1,// 第一组输入
    input [11:0] x2, y2,// 第二组输入
    output [11:0] z1, z2 // 模乘结果输出
);
    
    // 索引ROM输出线网
    wire [2:0] k7_x1, k7_x2, k7_y1, k7_y2;
    wire [4:0] k31_x1, k31_x2, k31_y1, k31_y2;
    wire [4:0] k32_x1, k32_x2, k32_y1, k32_y2;
    
    // 加法ROM输出线网
    wire [2:0] q1_1, q1_2;  // 数据位宽为3
    wire [4:0] q2_1, q2_2;  // 数据位宽为5
    wire [4:0] q3_1, q3_2;  // 数据位宽为5
    
    // 重构ROM地址和输出
    wire [13:0] addr_recon_1, addr_recon_2;  // 14位地址
    wire [11:0] dout_recon_1, dout_recon_2; // 12位数据
   
    
    // =========================================================================
    // ROM地址生成 - 直接使用输入信号
    // =========================================================================
    wire [11:0] idx_addr_x1 = x1;
    wire [11:0] idx_addr_y1 = y1;
    wire [11:0] idx_addr_x2 = x2;
    wire [11:0] idx_addr_y2 = y2;
    
    // =========================================================================
    // 索引ROM实例化 - 并行读取x和y的索引
    // =========================================================================
    index7_rom rom_index7_x (
        .clka(clk), 
        .addra(idx_addr_x1), 
        .douta(k7_x1), 
        .clkb(clk),
        .addrb(idx_addr_x2),
        .doutb(k7_x2)
    );
    
    index7_rom rom_index7_y (
        .clka(clk), 
        .addra(idx_addr_y1), 
        .douta(k7_y1), 
        .clkb(clk),
        .addrb(idx_addr_y2),
        .doutb(k7_y2)
    );
    
    index31_rom rom_index31_x (
        .clka(clk), 
        .addra(idx_addr_x1), 
        .douta(k31_x1), 
        .clkb(clk),
        .addrb(idx_addr_x2),
        .doutb(k31_x2)
    );
    
    index31_rom rom_index31_y (
        .clka(clk), 
        .addra(idx_addr_y1), 
        .douta(k31_y1), 
        .clkb(clk),
        .addrb(idx_addr_y2),
        .doutb(k31_y2)
    );
    
    index32_rom rom_index32_x (
        .clka(clk), 
        .addra(idx_addr_x1), 
        .douta(k32_x1), 
        .clkb(clk),
        .addrb(idx_addr_x2),
        .doutb(k32_x2)
    );
    
    index32_rom rom_index32_y (
        .clka(clk), 
        .addra(idx_addr_y1), 
        .douta(k32_y1), 
        .clkb(clk),
        .addrb(idx_addr_y2),
        .doutb(k32_y2)
    );
    
    // =========================================================================
    // 加法ROM地址生成 - 直接使用ROM输出信号
    // =========================================================================
    wire [5:0] add7_addr_1 = {k7_x1, k7_y1};
    wire [5:0] add7_addr_2 = {k7_x2, k7_y2};
    
    wire [9:0] add31_addr_1 = {k31_x1, k31_y1};
    wire [9:0] add31_addr_2 = {k31_x2, k31_y2};
    
    wire [9:0] add32_addr_1 = {k32_x1, k32_y1};
    wire [9:0] add32_addr_2 = {k32_x2, k32_y2};
    
    // =========================================================================
    // 加法ROM实例化
    // =========================================================================
    add7_rom rom_add7 (
        .clka(clk), 
        .addra(add7_addr_1), 
        .douta(q1_1),
        .clkb(clk), 
        .addrb(add7_addr_2),
        .doutb(q1_2)
    );
    
    add31_rom rom_add31 (
        .clka(clk), 
        .addra(add31_addr_1), 
        .douta(q2_1), 
        .clkb(clk),
        .addrb(add31_addr_2),
        .doutb(q2_2)
    );
    
    add32_rom rom_add32 (
        .clka(clk), 
        .addra(add32_addr_1), 
        .douta(q3_1),
        .clkb(clk), 
        .addrb(add32_addr_2),
        .doutb(q3_2)
    );
    
    // =========================================================================
    // 重构ROM地址生成 - 直接使用加法ROM输出
    // =========================================================================
    assign addr_recon_1 = q1_1 * 1024 + q3_1 * 32 + q2_1;
    assign addr_recon_2 = q1_2 * 1024 + q3_2 * 32 + q2_2;
    
    // =========================================================================
    // 重构ROM实例化
    // =========================================================================
    reconstruct_rom rom_recon (
        .clka(clk), 
        .addra(addr_recon_1), 
        .douta(dout_recon_1), 
        .clkb(clk),
        .addrb(addr_recon_2),
        .doutb(dout_recon_2)
    );
    
    // =========================================================================
    // 输出数据
    // =========================================================================
    assign z1 = dout_recon_1;
    assign z2 = dout_recon_2;

endmodule