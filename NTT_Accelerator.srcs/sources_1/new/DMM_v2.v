`timescale 1ns / 1ns

//这个版本是有输出寄存器的
module DMM_v2#(
    parameter q = 3329, // modular
    parameter alpha = 3,
    parameter q1 = 7,
    parameter q2 = 31,
    parameter q3 = 32
)(
    input clk,
    input rst_n,        // 新增：低电平有效的复位信号
    input [11:0] x1, y1,// 第一组输入
    input [11:0] x2, y2,// 第二组输入
    output reg [11:0] z1, z2 // 模乘结果输出
);
    
    // 输入寄存器 - 第一级流水
    reg [11:0] x1_reg, y1_reg;
    reg [11:0] x2_reg, y2_reg;
    
    // 索引ROM输出寄存器 - 第二级流水
    reg [2:0] k7_x1_reg, k7_x2_reg, k7_y1_reg, k7_y2_reg;
    reg [4:0] k31_x1_reg, k31_x2_reg, k31_y1_reg, k31_y2_reg;
    reg [4:0] k32_x1_reg, k32_x2_reg, k32_y1_reg, k32_y2_reg;
    
    // 加法ROM输出寄存器 - 第三级流水
    reg [2:0] q1_1_reg, q1_2_reg;
    reg [4:0] q2_1_reg, q2_2_reg;
    reg [4:0] q3_1_reg, q3_2_reg;
    
    // 重构ROM输出寄存器
    reg [11:0] dout_recon_1_reg, dout_recon_2_reg;
    
    // 索引ROM输出线网
    wire [2:0] k7_x1, k7_x2, k7_y1, k7_y2;
    wire [4:0] k31_x1, k31_x2, k31_y1, k31_y2;
    wire [4:0] k32_x1, k32_x2, k32_y1, k32_y2;
    
    // 加法ROM输出线网
    wire [2:0] q1_1, q1_2;  // 数据位宽为3
    wire [4:0] q2_1, q2_2;  // 数据位宽为5
    wire [4:0] q3_1, q3_2;  // 数据位宽为5
    
    // 重构ROM地址和输出
    wire [13:0] addr_recon_1, addr_recon_2;  // 修正：扩展为14位地址 (8190需要14位)
    wire [11:0] dout_recon_1, dout_recon_2; // 数据位宽为12
     
    // =========================================================================
    // 输入寄存器 - 第一级流水 (带复位)
    // =========================================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x1_reg <= 12'd0;
            y1_reg <= 12'd0;
            x2_reg <= 12'd0;
            y2_reg <= 12'd0;
        end else begin
            x1_reg <= x1;
            y1_reg <= y1;
            x2_reg <= x2;
            y2_reg <= y2;
        end
    end
    
    // =========================================================================
    // ROM地址生成 - 修正物理地址从1开始的偏移
    // =========================================================================
    // 索引ROM地址 - 输入值作为物理地址
    wire [11:0] idx_addr_x1 = x1_reg;
    wire [11:0] idx_addr_y1 = y1_reg;
    wire [11:0] idx_addr_x2 = x2_reg;
    wire [11:0] idx_addr_y2 = y2_reg;
    
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
    // 索引寄存器更新 - 第二级流水 (带复位)
    // =========================================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            k7_x1_reg <= 3'd0;
            k7_x2_reg <= 3'd0;
            k31_x1_reg <= 5'd0;
            k31_x2_reg <= 5'd0;
            k32_x1_reg <= 5'd0;
            k32_x2_reg <= 5'd0;
            k7_y1_reg <= 3'd0;
            k7_y2_reg <= 3'd0;
            k31_y1_reg <= 5'd0;
            k31_y2_reg <= 5'd0;
            k32_y1_reg <= 5'd0;
            k32_y2_reg <= 5'd0;
        end else begin
            k7_x1_reg <= k7_x1;
            k7_x2_reg <= k7_x2;
            k31_x1_reg <= k31_x1;
            k31_x2_reg <= k31_x2;
            k32_x1_reg <= k32_x1;
            k32_x2_reg <= k32_x2;
            k7_y1_reg <= k7_y1;
            k7_y2_reg <= k7_y2;
            k31_y1_reg <= k31_y1;
            k31_y2_reg <= k31_y2;
            k32_y1_reg <= k32_y1;
            k32_y2_reg <= k32_y2;
        end
    end
    
    // =========================================================================
    // 加法ROM地址生成
    // =========================================================================
    // 8x8表格地址：{行, 列} - 直接使用寄存器值
    wire [5:0] add7_addr_1 = {k7_x1_reg, k7_y1_reg};
    wire [5:0] add7_addr_2 = {k7_x2_reg, k7_y2_reg};
    
    // 32x32表格地址：{行, 列}
    wire [9:0] add31_addr_1 = {k31_x1_reg, k31_y1_reg};
    wire [9:0] add31_addr_2 = {k31_x2_reg, k31_y2_reg};
    
    wire [9:0] add32_addr_1 = {k32_x1_reg, k32_y1_reg};
    wire [9:0] add32_addr_2 = {k32_x2_reg, k32_y2_reg};
    
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
    // 加法ROM输出寄存器 - 第三级流水 (带复位)
    // =========================================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1_1_reg <= 3'd0;
            q2_1_reg <= 5'd0;
            q3_1_reg <= 5'd0;
            q1_2_reg <= 3'd0;
            q2_2_reg <= 5'd0;
            q3_2_reg <= 5'd0;
        end else begin
            q1_1_reg <= q1_1;
            q2_1_reg <= q2_1;
            q3_1_reg <= q3_1;
            q1_2_reg <= q1_2;
            q2_2_reg <= q2_2;
            q3_2_reg <= q3_2;
        end
    end
    
    // =========================================================================
    // 重构ROM地址生成 (q1*1024 + q3*32 + q2) - 修正地址位宽
    // =========================================================================
    assign addr_recon_1 = q1_1_reg * 1024 + q3_1_reg * 32 + q2_1_reg;
    assign addr_recon_2 = q1_2_reg * 1024 + q3_2_reg * 32 + q2_2_reg;
    
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
    // 新增：重构ROM输出寄存器 - 第四级流水 (带复位)
    // =========================================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dout_recon_1_reg <= 12'd0;
            dout_recon_2_reg <= 12'd0;
        end else begin
            dout_recon_1_reg <= dout_recon_1;
            dout_recon_2_reg <= dout_recon_2;
        end
    end
    
    // =========================================================================
    // 输出赋值
    // =========================================================================
    always @(*) begin
        z1 = dout_recon_1_reg;
        z2 = dout_recon_2_reg;
    end

endmodule