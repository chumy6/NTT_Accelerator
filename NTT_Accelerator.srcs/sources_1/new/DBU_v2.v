`timescale 1ns / 1ns

//Dual butterfly unit (DBU).
//========= ����汾�ǳ�����Դ���õ� ============//
module DBU_v2 #(
    parameter [11:0] q = 3329
)(
    input clk,
    input rst_n,        // �͵�ƽ��Ч��λ
    input func_sel,         // ����ģʽ: 0=NTT, 1=INTT
    input [11:0] x1, y1, w1, // ��һ������
    input [11:0] x2, y2, w2, // �ڶ�������
    output [11:0] X1, Y1,     // ��һ�����
    output [11:0] X2, Y2,     // �ڶ������
    output dbu_valid          // �����Ч�źţ�10���ں������Ч��
);

    // �м��źŶ���
    wire [11:0] t1_madd, t1_msub; // ��һ��ģ��/ģ�����
    wire [11:0] t2_madd, t2_msub; // �ڶ���ģ��/ģ�����
    wire [11:0] modmul_in1_x, modmul_in1_y; // ģ��ģ���һ������
    wire [11:0] modmul_in2_x, modmul_in2_y; // ģ��ģ��ڶ�������
    wire [11:0] modmul_out1, modmul_out2;   // ģ��ģ�����
    wire [11:0] shift_in1, shift_in2;       // ��λ�Ĵ�������
    wire [11:0] shift_out1, shift_out2;     // ��λ�Ĵ������
    wire [11:0] X1_ntt, Y1_ntt, X2_ntt, Y2_ntt; // NTTģʽ���
    wire [11:0] X1_intt, Y1_intt, X2_intt, Y2_intt; // INTTģʽ���
    
    // ��Ч�źż�����
    reg [3:0] valid_counter;
    reg valid_reg;
    
    // ģ��/ģ��ģ��ʵ���� (����߼�)
    modular_add #(.q(3329)) mod_add1 (.a(x1), .b(y1), .T(t1_madd));
    modular_sub #(.q(3329)) mod_sub1 (.a(x1), .b(y1), .T(t1_msub));
    modular_add #(.q(3329)) mod_add2 (.a(x2), .b(y2), .T(t2_madd));
    modular_sub #(.q(3329)) mod_sub2 (.a(x2), .b(y2), .T(t2_msub));
    
    // ģ������ѡ���߼�
    assign modmul_in1_x = (func_sel == 1'b0) ? y1 : t1_msub; // NTT: y1, INTT: t1_msub
    assign modmul_in1_y = w1;
    assign modmul_in2_x = (func_sel == 1'b0) ? y2 : t2_msub; // NTT: y2, INTT: t2_msub
    assign modmul_in2_y = w2;
    
    // ģ��ģ��ʵ���� (10�����ӳ�)
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
    
    // ��λ�Ĵ�������ѡ��
    assign shift_in1 = (func_sel == 1'b0) ? x1 : t1_madd; // NTT: x1, INTT: t1_madd
    assign shift_in2 = (func_sel == 1'b0) ? x2 : t2_madd; // NTT: x2, INTT: t2_madd
    
    // 10����λ�Ĵ��� (����10�����ӳ�)
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
            // ��һ���Ĵ���
            shift_reg1[0] <= shift_in1;
            shift_reg2[0] <= shift_in2;
            
            // ����������λ
            for (i = 1; i < 10; i = i + 1) begin
                shift_reg1[i] <= shift_reg1[i-1];
                shift_reg2[i] <= shift_reg2[i-1];
            end
        end
    end
    
    assign shift_out1 = shift_reg1[9];
    assign shift_out2 = shift_reg2[9];
    
    // ��Ч�źż������߼�
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_counter <= 4'd0;
            valid_reg <= 1'b0;
        end else begin
            if (valid_counter < 4'd10) begin
                valid_counter <= valid_counter + 4'd1;
            end else begin
                valid_reg <= 1'b1; // ������10�󱣳ָߵ�ƽ
            end
        end
    end
    
    assign dbu_valid = valid_reg;
    
    // ģ����2���� (����߼�)
    function [11:0] div_by_two;
        input [11:0] in;
        begin
            if (in[0] == 1'b0) begin
                // ż�������ֱ������һλ
                div_by_two = in >> 1;
            end else begin
                // �������������һλ�����q+1/2��ȡģ
                div_by_two = ((in >> 1) + (q+1/2)) % q;
            end
        end
    endfunction
    
    // NTTģʽ�������
    modular_add #(.q(3329)) add_ntt1 (.a(shift_out1), .b(modmul_out1), .T(X1_ntt));
    modular_sub #(.q(3329)) sub_ntt1 (.a(shift_out1), .b(modmul_out1), .T(Y1_ntt));
    modular_add #(.q(3329)) add_ntt2 (.a(shift_out2), .b(modmul_out2), .T(X2_ntt));
    modular_sub #(.q(3329)) sub_ntt2 (.a(shift_out2), .b(modmul_out2), .T(Y2_ntt));
    
    // INTTģʽ�������
    assign X1_intt = div_by_two(shift_out1);
    assign Y1_intt = div_by_two(modmul_out1);
    assign X2_intt = div_by_two(shift_out2);
    assign Y2_intt = div_by_two(modmul_out2);
    
    // �������ѡ��
    assign X1 = (func_sel == 1'b0) ? X1_ntt : X1_intt;
    assign Y1 = (func_sel == 1'b0) ? Y1_ntt : Y1_intt;
    assign X2 = (func_sel == 1'b0) ? X2_ntt : X2_intt;
    assign Y2 = (func_sel == 1'b0) ? Y2_ntt : Y2_intt;

endmodule

