`timescale 1ns / 1ns

module Control_Unit (
    input clk,
    input rst_n,
    input [1:0] op_sel,       // ����ѡ��: 00=IDLE, 01=NTT, 10=INTT, 11=CWM
    input start,              // �����ź�
    output reg done,          // ��������ź�
    output reg mem0_we,       // MEM0дʹ��
    output reg mem1_we,       // MEM1дʹ��
    output reg [5:0] mem_addr_a, // �洢����ַA
    output reg [5:0] mem_addr_b, // �洢����ַB
    output reg [5:0] twiddle_addr, // ��ת���ӵ�ַ
    output reg func_sel,      // DBU����ѡ��: 0=NTT, 1=INTT
    input dbu_valid,          // DBU�����Ч�ź�
    output reg result_valid,  // �����Ч�ź�
    output reg [6:0] result_addr // �����ַ
);

    // ״̬������
    localparam IDLE     = 3'd0,
               LOAD     = 3'd1,
               COMPUTE  = 3'd2,
               STORE    = 3'd3,
               DONE     = 3'd4;
    
    reg [2:0] current_state, next_state;
    reg [8:0] cycle_count;    // ���ڼ���ʱ������
    reg [2:0] stage_count;    // �׶μ��� (0-6)
    reg [6:0] butterfly_count; // ����������� (0-127)
    reg [1:0] cwm_phase;      // CWM�׶� (0-3)
    
    // ״̬��ʱ���߼�
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    // ״̬ת���߼�
    always @(*) begin
        case (current_state)
            IDLE:
                if (start && op_sel != 2'b00)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            
            LOAD:
                // ���ݲ�ͬ����ȷ�������������
                if ((op_sel == 2'b01 || op_sel == 2'b10) && cycle_count == 9'd127)
                    next_state = COMPUTE;
                else if (op_sel == 2'b11 && cycle_count == 9'd255)
                    next_state = COMPUTE;
                else
                    next_state = LOAD;
            
            COMPUTE:
                // ���ݲ�ͬ����ȷ�������������
                if ((op_sel == 2'b01 || op_sel == 2'b10) && cycle_count == 9'd458)
                    next_state = STORE;
                else if (op_sel == 2'b11 && cycle_count == 9'd328)
                    next_state = STORE;
                else
                    next_state = COMPUTE;
            
            STORE:
                // ȷ����ʱ�洢���
                if (cycle_count == 9'd127)
                    next_state = DONE;
                else
                    next_state = STORE;
            
            DONE:
                if (!start) // �ȴ�start�ź��ͷ�
                    next_state = IDLE;
                else
                    next_state = DONE;
            
            default:
                next_state = IDLE;
        endcase
    end
    
    // �����ź�����
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cycle_count <= 9'd0;
            stage_count <= 3'd0;
            butterfly_count <= 7'd0;
            cwm_phase <= 2'd0;
            mem0_we <= 1'b0;
            mem1_we <= 1'b0;
            mem_addr_a <= 6'd0;
            mem_addr_b <= 6'd0;
            twiddle_addr <= 6'd0;
            func_sel <= 1'b0;
            done <= 1'b0;
            result_valid <= 1'b0;
            result_addr <= 7'd0;
        end else begin
            case (current_state)
                IDLE: begin
                    cycle_count <= 9'd0;
                    stage_count <= 3'd0;
                    butterfly_count <= 7'd0;
                    cwm_phase <= 2'd0;
                    done <= 1'b0;
                    result_valid <= 1'b0;
                    
                    // ���ݲ���ѡ�����ù���ѡ���ź�
                    if (start) begin
                        func_sel <= (op_sel == 2'b10) ? 1'b1 : 1'b0; // 10=INTT, ����=NTT/CWM
                    end
                end
                
                LOAD: begin
                    cycle_count <= cycle_count + 1'b1;
                    
                    if (op_sel == 2'b11) begin // CWM����
                        // CWM������Ҫ������������(a��b)
                        if (cycle_count < 9'd128) begin
                            // ����aϵ��
                            mem_addr_a <= cycle_count[5:0]; // Mem0��ַ (0-31)
                            mem_addr_b <= cycle_count[5:0]; // Mem1��ַ (0-31)
                            mem0_we <= 1'b1;
                            mem1_we <= 1'b1;
                        end else begin
                            // ����bϵ��
                            mem_addr_a <= cycle_count[5:0] - 6'd32; // Mem0��ַ (33-64)
                            mem_addr_b <= cycle_count[5:0] - 6'd32; // Mem1��ַ (33-64)
                            mem0_we <= 1'b1;
                            mem1_we <= 1'b1;
                        end
                    end else begin // NTT/INTT����
                        // ����aϵ��
                        mem_addr_a <= cycle_count[5:0]; // Mem0��ַ (0-31)
                        mem_addr_b <= cycle_count[5:0]; // Mem1��ַ (0-31)
                        mem0_we <= 1'b1;
                        mem1_we <= 1'b1;
                    end
                end
                
                COMPUTE: begin
                    cycle_count <= cycle_count + 1'b1;
                    
                    if (op_sel == 2'b11) begin // CWM����
                        // CWM��������
                        case (cwm_phase)
                            2'd0: begin // ��һ��NTT
                                mem_addr_a <= calculate_mem_addr_ntt(stage_count, butterfly_count);
                                mem_addr_b <= calculate_mem_addr_ntt(stage_count, butterfly_count + 1'b1);
                                twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    if (stage_count < 3'd6) begin
                                        stage_count <= stage_count + 1'b1;
                                    end else begin
                                        stage_count <= 3'd0;
                                        cwm_phase <= 2'd1;
                                    end
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                            
                            2'd1: begin // �ڶ���NTT (����bϵ��)
                                mem_addr_a <= calculate_mem_addr_ntt_b(stage_count, butterfly_count);
                                mem_addr_b <= calculate_mem_addr_ntt_b(stage_count, butterfly_count + 1'b1);
                                twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    if (stage_count < 3'd6) begin
                                        stage_count <= stage_count + 1'b1;
                                    end else begin
                                        stage_count <= 3'd0;
                                        cwm_phase <= 2'd2;
                                    end
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                            
                            2'd2: begin // ϵ���˷�
                                mem_addr_a <= butterfly_count[6:1]; // Mem0��ַ (0-31)
                                mem_addr_b <= butterfly_count[6:1] + 6'd32; // Mem1��ַ (33-64)
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    cwm_phase <= 2'd3;
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                            
                            2'd3: begin // INTT
                                func_sel <= 1'b1; // ����ΪINTTģʽ
                                mem_addr_a <= calculate_mem_addr_intt(stage_count, butterfly_count);
                                mem_addr_b <= calculate_mem_addr_intt(stage_count, butterfly_count + 1'b1);
                                twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                                
                                if (butterfly_count == 7'd127) begin
                                    butterfly_count <= 7'd0;
                                    if (stage_count < 3'd6) begin
                                        stage_count <= stage_count + 1'b1;
                                    end
                                end else begin
                                    butterfly_count <= butterfly_count + 1'b1;
                                end
                            end
                        endcase
                    end else begin // NTT/INTT����
                        // �����ʵ��ĵ�ַ��ִ�м���
                        if (op_sel == 2'b01) begin // NTT
                            mem_addr_a <= calculate_mem_addr_ntt(stage_count, butterfly_count);
                            mem_addr_b <= calculate_mem_addr_ntt(stage_count, butterfly_count + 1'b1);
                        end else begin // INTT
                            mem_addr_a <= calculate_mem_addr_intt(stage_count, butterfly_count);
                            mem_addr_b <= calculate_mem_addr_intt(stage_count, butterfly_count + 1'b1);
                        end
                        
                        twiddle_addr <= calculate_twiddle_addr(stage_count, butterfly_count);
                        
                        // ���¼���
                        if (butterfly_count == 7'd127) begin
                            butterfly_count <= 7'd0;
                            if (stage_count < 3'd6)
                                stage_count <= stage_count + 1'b1;
                        end else begin
                            butterfly_count <= butterfly_count + 1'b1;
                        end
                    end
                    
                    // ��DBU�����Чʱ�����ý����Ч�źŲ����ɽ����ַ
                    if (dbu_valid) begin
                        result_valid <= 1'b1;
                        result_addr <= butterfly_count;
                    end else begin
                        result_valid <= 1'b0;
                    end
                end
                
                STORE: begin
                    cycle_count <= cycle_count + 1'b1;
                    
                    // �洢������
                    mem0_we <= 1'b1;
                    mem1_we <= 1'b1;
                    
                    // ����cycle_count����洢��ַ
                    mem_addr_a <= cycle_count[5:0]; // Mem0��ַ (0-31)
                    mem_addr_b <= cycle_count[5:0] + 6'd32; // Mem1��ַ (33-64)
                end
                
                DONE: begin
                    done <= 1'b1;
                    mem0_we <= 1'b0;
                    mem1_we <= 1'b0;
                end
            endcase
        end
    end
    
    // �������������ݽ׶κ͵�������������NTT�洢����ַ
    function [5:0] calculate_mem_addr_ntt;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] offset;
        begin
            offset = 7'd1 << stage; // 2^stage
            if (butterfly[stage] == 1'b0)
                calculate_mem_addr_ntt = (butterfly & ~offset) >> 1; // ż����ַ
            else
                calculate_mem_addr_ntt = ((butterfly & ~offset) >> 1) + 6'd32; // ������ַ
        end
    endfunction
    
    // �������������ݽ׶κ͵�������������INTT�洢����ַ
    function [5:0] calculate_mem_addr_intt;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] reversed_butterfly;
        reg [6:0] offset;
        begin
            // λ����
            reversed_butterfly = ((butterfly & 7'b0000001) << 6) |
                                ((butterfly & 7'b0000010) << 4) |
                                ((butterfly & 7'b0000100) << 2) |
                                ((butterfly & 7'b0001000) >> 2) |
                                ((butterfly & 7'b0010000) >> 4) |
                                ((butterfly & 7'b0100000) >> 6) |
                                (butterfly & 7'b1000000);
            
            offset = 7'd1 << stage; // 2^stage
            if (reversed_butterfly[stage] == 1'b0)
                calculate_mem_addr_intt = (reversed_butterfly & ~offset) >> 1; // ż����ַ
            else
                calculate_mem_addr_intt = ((reversed_butterfly & ~offset) >> 1) + 6'd32; // ������ַ
        end
    endfunction
    
    // �������������ݽ׶κ͵�������������CWM��bϵ����NTT�洢����ַ
    function [5:0] calculate_mem_addr_ntt_b;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] offset;
        begin
            offset = 7'd1 << stage; // 2^stage
            if (butterfly[stage] == 1'b0)
                calculate_mem_addr_ntt_b = ((butterfly & ~offset) >> 1) + 6'd32; // ż����ַ(33-64)
            else
                calculate_mem_addr_ntt_b = ((butterfly & ~offset) >> 1); // ������ַ(0-31)
        end
    endfunction
    
    // �������������ݽ׶κ͵���������������ת���ӵ�ַ
    function [5:0] calculate_twiddle_addr;
        input [2:0] stage;
        input [6:0] butterfly;
        reg [6:0] twiddle_index;
        begin
            // ������ת��������
            twiddle_index = (butterfly << (3'd7 - stage)) & 7'd127;
            calculate_twiddle_addr = twiddle_index[6:1]; // ����2����Ϊÿ������ת���Ӵ�һ��
        end
    endfunction
    
endmodule    
