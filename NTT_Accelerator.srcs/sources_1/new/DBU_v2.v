`timescale 1ns / 1ns

//Dual butterfly unit (DBU).
//========= ����汾�ǳ�����Դ���õ� ============//
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

    // �׶ζ���
    localparam ST_IDLE   = 3'd0;
    localparam ST_NTT_MUL= 3'd1;
    localparam ST_NTT_ADD= 3'd2;
    localparam ST_INT_ADD= 3'd3;
    localparam ST_INT_SUB= 3'd4;
    localparam ST_INT_MUL= 3'd5;
    localparam ST_DONE   = 3'd6;

    // �ڲ��źźͼĴ���
    reg [2:0]   state, next_state;
    reg [3:0]   dmm_latency;      // DMM�ӳټ�����
    reg         dmm_busy;         // DMMæµ��־
    reg [11:0]  x1_reg, y1_reg, w1_reg;
    reg [11:0]  x2_reg, y2_reg, w2_reg;
    reg [11:0]  ntt_z1_reg, ntt_z2_reg;
    reg [11:0]  intt_t1_madd_reg, intt_t1_msub_reg;
    reg [11:0]  intt_t2_madd_reg, intt_t2_msub_reg;
    reg [11:0]  intt_y1_temp_reg, intt_y2_temp_reg;
    
    // DMM��������ź�
    reg [11:0] dmm_x1, dmm_y1, dmm_x2, dmm_y2;
    wire [11:0] dmm_z1, dmm_z2;
    
    // ģ��ģ�������ź�
    reg [11:0] add1_a, add1_b, add2_a, add2_b;
    reg [11:0] sub1_a, sub1_b, sub2_a, sub2_b;
    wire [11:0] intt_t1_madd, intt_t2_madd;
    wire [11:0] intt_t1_msub, intt_t2_msub;
    
    // ����ѡ�����
    localparam NTT_MODE = 1'b0;
    localparam INTT_MODE = 1'b1;

    // ����2�Ĳ���������1λ��
    function automatic [11:0] div_by_two;
        input [11:0] in;
        begin
            div_by_two = (in[0] == 1'b1) ? (in + 1'b1) >> 1 : in >> 1;
        end
    endfunction

    // ģ���㵥Ԫʵ����
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

    // ״̬������
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= ST_IDLE;
            dmm_latency <= 4'b0;
            dmm_busy <= 1'b0;
            dbu_valid <= 1'b0;
        end else begin
            state <= next_state;
            
            // DMM�ӳټ���������
            if (dmm_busy) begin
                if (dmm_latency < 4'd9) begin
                    dmm_latency <= dmm_latency + 1'b1;
                end else begin
                    dmm_latency <= 4'b0;
                    dmm_busy <= 1'b0;
                end
            end
            
            // �����Ч��־����
            if (state == ST_DONE) begin
                dbu_valid <= 1'b1;
            end else begin
                dbu_valid <= 1'b0;
            end
        end
    end

    // ״̬ת���߼�
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

    // ����·������
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
                    // ������������
                    x1_reg <= x1;
                    y1_reg <= y1;
                    w1_reg <= w1;
                    x2_reg <= x2;
                    y2_reg <= y2;
                    w2_reg <= w2;
                    
                    if (func_sel == NTT_MODE) begin
                        // NTTģʽ��������һ��ģ��
                        dmm_x1 <= y1;
                        dmm_y1 <= w1;
                        dmm_x2 <= y2;
                        dmm_y2 <= w2;
                        dmm_busy <= 1'b1;
                    end else begin
                        // INTTģʽ������ģ��
                        add1_a <= x1;
                        add1_b <= y1;
                        add2_a <= x2;
                        add2_b <= y2;
                    end
                end
                
                ST_NTT_MUL: begin
                    if (dmm_busy && dmm_latency == 4'd9) begin
                        // ģ����ɣ�������
                        ntt_z1_reg <= dmm_z1;
                        ntt_z2_reg <= dmm_z2;
                        
                        // ����ģ��ģ��
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
                    // ����NTT���
                    X1 <= intt_t1_madd;  // ����add��Ԫ�����
                    Y1 <= intt_t1_msub;  // ����sub��Ԫ�����
                    X2 <= intt_t2_madd;
                    Y2 <= intt_t2_msub;
                end
                
                ST_INT_ADD: begin
                    // ����INTTģ�ӽ��
                    intt_t1_madd_reg <= intt_t1_madd;
                    intt_t2_madd_reg <= intt_t2_madd;
                    
                    // ����ģ��
                    sub1_a <= x1_reg;
                    sub1_b <= y1_reg;
                    sub2_a <= x2_reg;
                    sub2_b <= y2_reg;
                end
                
                ST_INT_SUB: begin
                    // ����INTTģ�����
                    intt_t1_msub_reg <= intt_t1_msub;
                    intt_t2_msub_reg <= intt_t2_msub;
                    
                    // ����INTTģ��
                    dmm_x1 <= intt_t1_msub_reg;
                    dmm_y1 <= w1_reg;
                    dmm_x2 <= intt_t2_msub_reg;
                    dmm_y2 <= w2_reg;
                    dmm_busy <= 1'b1;
                end
                
                ST_INT_MUL: begin
                    if (dmm_busy && dmm_latency == 4'd9) begin
                        // ģ����ɣ�������������2
                        X1 <= div_by_two(intt_t1_madd_reg);
                        Y1 <= div_by_two(dmm_z1);
                        X2 <= div_by_two(intt_t2_madd_reg);
                        Y2 <= div_by_two(dmm_z2);
                    end
                end
                
                ST_DONE: begin
                    // ���ֽ��
                    X1 <= X1;
                    Y1 <= Y1;
                    X2 <= X2;
                    Y2 <= Y2;
                end
            endcase
        end
    end

endmodule
