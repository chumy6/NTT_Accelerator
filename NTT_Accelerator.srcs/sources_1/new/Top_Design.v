`timescale 1ns / 1ns

module Top_Design (
    input clk,
    input rst_n,
    input [1:0] op_sel,       // ����ѡ��: 00=IDLE, 01=NTT, 10=INTT, 11=CWM
    input start,              // �����ź�
    output done,              // ��������ź�
    input [11:0] a_in,        // ����ʽa���루���У�
    input [11:0] b_in,        // ����ʽb���루���У�������CWM��
    input [6:0] a_addr,       // a�����ַ
    input [6:0] b_addr,       // b�����ַ
    output reg [11:0] result, // ��������������У�
    output reg [6:0] result_addr, // �����ַ
    output result_valid       // �����Ч�ź�
);

    // �ڲ��ź�����
    wire [11:0] mem0_douta, mem0_doutb;
    wire [11:0] mem1_douta, mem1_doutb;
    wire [23:0] twiddle_douta;
    wire [11:0] twiddle_w1, twiddle_w2;
    wire [11:0] dbu_X1, dbu_Y1, dbu_X2, dbu_Y2;
    wire dbu_valid;
    wire [5:0] mem_addr_a, mem_addr_b;
    wire [5:0] twiddle_addr;
    wire mem0_we, mem1_we;
    wire func_sel;            // ���ݸ�DBU�Ĺ���ѡ���ź�
    wire [6:0] result_addr_int; // �ڲ������ַ
    
    // ��ת����ROM���ݷָ�
    assign twiddle_w1 = twiddle_douta[11:0];
    assign twiddle_w2 = twiddle_douta[23:12];
    
    // �������ݻ���
    reg [11:0] a_buffer [0:127];
    reg [11:0] b_buffer [0:127];
    reg a_buffer_we, b_buffer_we;
    
    // �������Ƶ�Ԫ
    Control_Unit ctrl_unit (
        .clk(clk),
        .rst_n(rst_n),
        .op_sel(op_sel),
        .start(start),
        .done(done),
        .mem0_we(mem0_we),
        .mem1_we(mem1_we),
        .mem_addr_a(mem_addr_a),
        .mem_addr_b(mem_addr_b),
        .twiddle_addr(twiddle_addr),
        .func_sel(func_sel),
        .dbu_valid(dbu_valid),
        .result_valid(result_valid),
        .result_addr(result_addr_int)
    );
    
    // ����MEM0
    Mem0 mem0_inst (
        .clka(clk),
        .addra(mem_addr_a),
        .douta(mem0_douta),
        .clkb(clk),
        .addrb(mem_addr_b),
        .doutb(mem0_doutb)
    );
    
    // ����MEM1
    Mem1 mem1_inst (
        .clka(clk),
        .addra(mem_addr_a),
        .douta(mem1_douta),
        .clkb(clk),
        .enb(mem1_we),
        .addrb(mem_addr_b),
        .doutb(mem1_doutb)
    );
    
    // ����Twiddle Factors ROM
    Twiddle_Factors_ROM twiddle_inst (
        .clka(clk),
        .addra(twiddle_addr),
        .douta(twiddle_douta)
    );
    
    // ����DBU_v2ģ��
    DBU_v2 #(
        .q(12'd3329)
    ) dbu_inst (
        .clk(clk),
        .rst_n(rst_n),
        .func_sel(func_sel),
        .x1(mem0_douta),
        .y1(mem1_douta),
        .w1(twiddle_w1),
        .x2(mem0_doutb),
        .y2(mem1_doutb),
        .w2(twiddle_w2),
        .X1(dbu_X1),
        .Y1(dbu_Y1),
        .X2(dbu_X2),
        .Y2(dbu_Y2),
        .dbu_valid(dbu_valid)
    );
    
    // �������ݻ������
    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 128; i = i + 1) begin
                a_buffer[i] <= 12'd0;
                b_buffer[i] <= 12'd0;
            end
        end else begin
            if (a_buffer_we)
                a_buffer[a_addr] <= a_in;
            if (b_buffer_we)
                b_buffer[b_addr] <= b_in;
        end
    end
    
    // �洢��д����� - ����������д��洢��
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_buffer_we <= 1'b0;
            b_buffer_we <= 1'b0;
        end else begin
            // ��LOAD�׶�д������
            if (start && op_sel != 2'b00) begin
                a_buffer_we <= 1'b1;
                if (op_sel == 2'b11) // CWM������Ҫ����b
                    b_buffer_we <= 1'b1;
                else
                    b_buffer_we <= 1'b0;
            end else begin
                a_buffer_we <= 1'b0;
                b_buffer_we <= 1'b0;
            end
        end
    end
    
    // ����������
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result <= 12'd0;
            result_addr <= 7'd0;
        end else if (result_valid) begin
            result <= dbu_X1; // ���������X1
            result_addr <= result_addr_int;
        end
    end
    
endmodule    
