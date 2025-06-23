`timescale 1ns / 1ns

//Dual butterfly unit (DBU) with output valid flag
//===========����汾��û����Դ���õ�============//
//NTT��INTT�����Ѿ�ͨ��
module DBU #(
    parameter [11:0] q = 3329
)(
    input clk,
    input rst_n,
    input func_sel,  // ����ѡ��0-NTT, 1-INTT
    input [11:0] x1, y1, w1,
    input [11:0] x2, y2, w2,
    output reg [11:0] X1, Y1,
    output reg [11:0] X2, Y2,
    output reg dbu_valid    // �����Ч��־
);

    // �ڲ��ź�����
    wire [11:0] ntt_z1, ntt_z2;         // NTTģ�˽��
    wire [11:0] intt_t1_madd, intt_t1_msub;  // INTT�м���
    wire [11:0] intt_t2_madd, intt_t2_msub;
    wire [11:0] intt_y1_temp, intt_y2_temp;  // INTTģ�˽��
    
    // �ӳټ�����
    reg [3:0] dmm_latency_cnt;  // 4λ������������10������
    
    // ����ѡ����붨��
    localparam NTT_MODE = 1'b0;
    localparam INTT_MODE = 1'b1;
    
    // ģ��ģ��ʵ����������NTT��
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
    
    // ģ��ģ��ʵ����������INTT��
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
    
    // ģ��ģ��ʵ����������INTT��NTT��
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
    
    // INTTģ��ģ��ʵ����
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
     
    // ģ����2�Ĳ���
    function automatic [11:0] div_by_two;
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
    
    // �ڲ��ź�����NTT��ģ�Ӻ�ģ�����
    wire [11:0] ntt_add1_out, ntt_sub1_out;
    wire [11:0] ntt_add2_out, ntt_sub2_out;
    
    // ʵ����NTTģ�Ӻ�ģ��ģ��
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
    
    // DMM�ӳټ���������
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dmm_latency_cnt <= 4'b0;
            dbu_valid <= 1'b0;
        end else begin
            // ��������0��9����10������
            if (dmm_latency_cnt < 4'd9) begin
                dmm_latency_cnt <= dmm_latency_cnt + 1'b1;
                dbu_valid <= 1'b0;
            end else begin
                dbu_valid <= 1'b1;
            end
        end
    end
    
    // ������ѡ�񣬽���DMM�����Чʱ����
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            X1 <= 12'b0;
            Y1 <= 12'b0;
            X2 <= 12'b0;
            Y2 <= 12'b0;
        end else if (dbu_valid) begin  // ���������Чʱ���½��
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
                
                default: begin
                    X1 <= 12'b0;
                    Y1 <= 12'b0;
                    X2 <= 12'b0;
                    Y2 <= 12'b0;
                end
            endcase
        end else begin
            // ����֮ǰ����Ч���
            X1 <= X1;
            Y1 <= Y1;
            X2 <= X2;
            Y2 <= Y2;
        end
    end
    
endmodule
