`timescale 1ns / 1ns

//����汾��û������Ĵ�����
module DMM#(
    parameter q = 3329, // modular
    parameter alpha = 3,
    parameter q1 = 7,
    parameter q2 = 31,
    parameter q3 = 32
)(
    input clk,
    input rst_n,        // �͵�ƽ��Ч�ĸ�λ�ź�
    input [11:0] x1, y1,// ��һ������
    input [11:0] x2, y2,// �ڶ�������
    output [11:0] z1, z2 // ģ�˽�����
);
    
    // ����ROM�������
    wire [2:0] k7_x1, k7_x2, k7_y1, k7_y2;
    wire [4:0] k31_x1, k31_x2, k31_y1, k31_y2;
    wire [4:0] k32_x1, k32_x2, k32_y1, k32_y2;
    
    // �ӷ�ROM�������
    wire [2:0] q1_1, q1_2;  // ����λ��Ϊ3
    wire [4:0] q2_1, q2_2;  // ����λ��Ϊ5
    wire [4:0] q3_1, q3_2;  // ����λ��Ϊ5
    
    // �ع�ROM��ַ�����
    wire [13:0] addr_recon_1, addr_recon_2;  // 14λ��ַ
    wire [11:0] dout_recon_1, dout_recon_2; // 12λ����
   
    
    // =========================================================================
    // ROM��ַ���� - ֱ��ʹ�������ź�
    // =========================================================================
    wire [11:0] idx_addr_x1 = x1;
    wire [11:0] idx_addr_y1 = y1;
    wire [11:0] idx_addr_x2 = x2;
    wire [11:0] idx_addr_y2 = y2;
    
    // =========================================================================
    // ����ROMʵ���� - ���ж�ȡx��y������
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
    // �ӷ�ROM��ַ���� - ֱ��ʹ��ROM����ź�
    // =========================================================================
    wire [5:0] add7_addr_1 = {k7_x1, k7_y1};
    wire [5:0] add7_addr_2 = {k7_x2, k7_y2};
    
    wire [9:0] add31_addr_1 = {k31_x1, k31_y1};
    wire [9:0] add31_addr_2 = {k31_x2, k31_y2};
    
    wire [9:0] add32_addr_1 = {k32_x1, k32_y1};
    wire [9:0] add32_addr_2 = {k32_x2, k32_y2};
    
    // =========================================================================
    // �ӷ�ROMʵ����
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
    // �ع�ROM��ַ���� - ֱ��ʹ�üӷ�ROM���
    // =========================================================================
    assign addr_recon_1 = q1_1 * 1024 + q3_1 * 32 + q2_1;
    assign addr_recon_2 = q1_2 * 1024 + q3_2 * 32 + q2_2;
    
    // =========================================================================
    // �ع�ROMʵ����
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
    // �������
    // =========================================================================
    assign z1 = dout_recon_1;
    assign z2 = dout_recon_2;

endmodule