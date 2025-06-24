`timescale 1ns / 1ns

module Top_Design_tb();

    // ��������
    parameter q = 3329;           // ������ģ��
    parameter N = 128;            // �任����
    parameter CLK_PERIOD = 10;    // ʱ������(ns)
    
    // �ź�����
    reg clk;
    reg rst_n;
    reg [1:0] op_sel;
    reg start;
    wire done;
    reg [11:0] a_in;
    reg [6:0] a_addr;
    reg b_in; // ������b_inӦΪ12λ����Top_Designģ��ӿ�һ��
    reg [6:0] b_addr;
    wire [11:0] result;
    wire [6:0] result_addr;
    wire result_valid;
    
    // ����������洢
    reg [11:0] sw_ntt_result [0:N-1];
    reg [11:0] sw_intt_result [0:N-1];
    reg [11:0] sw_cwm_result [0:N-1];
    
    // ��������
    reg [11:0] test_data_a [0:N-1];
    reg [11:0] test_data_b [0:N-1];
    
    // ʵ��������ģ��
    Top_Design uut (
        .clk(clk),
        .rst_n(rst_n),
        .op_sel(op_sel),
        .start(start),
        .done(done),
        .a_in(a_in),
        .a_addr(a_addr),
        .b_in(b_in),
        .b_addr(b_addr),
        .result(result),
        .result_addr(result_addr),
        .result_valid(result_valid)
    );
    
    // ʱ������
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // �����Թ���
    initial begin
        // ��ʼ���ź�
        rst_n = 0;
        op_sel = 2'b00;
        start = 0;
        
        // ��λ
        #100;
        rst_n = 1;
        #100;
        
        // ���ɲ�������
        generate_test_data();
        
        // ����NTT
        $display("��ʼNTT����...");
        test_ntt();
        
        // ����INTT
        #200;
        $display("��ʼINTT����...");
        test_intt();
        
        // ����CWM
        #200;
        $display("��ʼCWM����...");
        test_cwm();
        
        // ��������
        #500;
        $finish;
    end
    
    // ���ɲ�������
    task generate_test_data();
        integer i;
        for (i = 0; i < N; i = i + 1) begin
            test_data_a[i] = $urandom_range(0, q-1);
            test_data_b[i] = $urandom_range(0, q-1);
        end
        
        // �������NTT���
        software_ntt(test_data_a, sw_ntt_result);
        
        // �������INTT���
        software_intt(sw_ntt_result, sw_intt_result);
        
        // �������CWM���
        software_cwm(test_data_a, test_data_b, sw_cwm_result);
    endtask
    
    // ����NTT
    task test_ntt();
        integer i, errors;
        
        // ���ز�������
        load_data(test_data_a, 1'b1);
        
        // ����NTT
        op_sel = 2'b01;
        start = 1;
        #CLK_PERIOD;
        start = 0;
        
        // �ȴ����
        @(posedge done);
        #CLK_PERIOD;
        
        // ��ȡ����֤���
        errors = 0;
        for (i = 0; i < N; i = i + 1) begin
            @(posedge result_valid);
            if (result !== sw_ntt_result[result_addr]) begin
                $display("NTT�����ƥ��! ��ַ: %0d, Ӳ�����: %0d, ������: %0d", 
                         result_addr, result, sw_ntt_result[result_addr]);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("NTT����ͨ��!");
        end else begin
            $display("NTT����ʧ��! ��������: %0d", errors);
        end
    endtask
    
    // ����INTT
    task test_intt();
        integer i, errors;
        
        // ���ز������� (ʹ��NTT�Ľ����ΪINTT������)
        load_data(sw_ntt_result, 1'b1);
        
        // ����INTT
        op_sel = 2'b10;
        start = 1;
        #CLK_PERIOD;
        start = 0;
        
        // �ȴ����
        @(posedge done);
        #CLK_PERIOD;
        
        // ��ȡ����֤���
        errors = 0;
        for (i = 0; i < N; i = i + 1) begin
            @(posedge result_valid);
            if (result !== sw_intt_result[result_addr]) begin
                $display("INTT�����ƥ��! ��ַ: %0d, Ӳ�����: %0d, ������: %0d", 
                         result_addr, result, sw_intt_result[result_addr]);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("INTT����ͨ��!");
        end else begin
            $display("INTT����ʧ��! ��������: %0d", errors);
        end
    endtask
    
    // ����CWM
    task test_cwm();
        integer i, errors;
        
        // ���ز�������
        load_data(test_data_a, 1'b1);
        load_data(test_data_b, 1'b0);
        
        // ����CWM
        op_sel = 2'b11;
        start = 1;
        #CLK_PERIOD;
        start = 0;
        
        // �ȴ����
        @(posedge done);
        #CLK_PERIOD;
        
        // ��ȡ����֤���
        errors = 0;
        for (i = 0; i < N; i = i + 1) begin
            @(posedge result_valid);
            if (result !== sw_cwm_result[result_addr]) begin
                $display("CWM�����ƥ��! ��ַ: %0d, Ӳ�����: %0d, ������: %0d", 
                         result_addr, result, sw_cwm_result[result_addr]);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("CWM����ͨ��!");
        end else begin
            $display("CWM����ʧ��! ��������: %0d", errors);
        end
    endtask
    
    // �������ݵ�����ģ��
    task load_data(input [11:0] data [0:N-1], input a_or_b);
        integer i;
        
        for (i = 0; i < N; i = i + 1) begin
            if (a_or_b) begin
                a_in = data[i];
                a_addr = i;
            end else begin
                b_in = data[i];
                b_addr = i;
            end
            
            @(posedge clk);
        end
    endtask
    
    // ���ʵ�ֵ�NTT
    task software_ntt(input [11:0] in_data [0:N-1], output [11:0] out_data [0:N-1]);
        integer i, j, k, n;
        reg [11:0] temp [0:N-1];
        reg [11:0] twiddle [0:N-1];
        
        // Ԥ������ת����
        for (i = 0; i < N; i = i + 1) begin
            twiddle[i] = calculate_twiddle(i);
        end
        
        // ������������
        for (i = 0; i < N; i = i + 1) begin
            temp[i] = in_data[i];
        end
        
        // λ��������
        for (i = 0; i < N; i = i + 1) begin
            j = bit_reverse(i);
            if (i < j) begin
                k = temp[i];
                temp[i] = temp[j];
                temp[j] = k;
            end
        end
        
        // ��������
        for (n = 1; n < N; n = n * 2) begin
            for (j = 0; j < n; j = j + 1) begin
                k = j * (N / (n * 2));
                for (i = j; i < N; i = i + 2 * n) begin
                    reg [11:0] t, u;
                    
                    t = mod_mult(temp[i + n], twiddle[k]);
                    u = temp[i];
                    
                    temp[i] = mod_add(u, t);
                    temp[i + n] = mod_sub(u, t);
                end
            end
        end
        
        // ������
        for (i = 0; i < N; i = i + 1) begin
            out_data[i] = temp[i];
        end
    endtask
    
    // ���ʵ�ֵ�INTT
    task software_intt(input [11:0] in_data [0:N-1], output [11:0] out_data [0:N-1]);
        integer i;
        reg [11:0] temp [0:N-1];
        reg [11:0] inv_n;
        
        // ����N����Ԫ
        inv_n = mod_inverse(N);
        
        // ����NTT (INTT��NTT����任)
        software_ntt(in_data, temp);
        
        // ����N����Ԫ
        for (i = 0; i < N; i = i + 1) begin
            out_data[i] = mod_mult(temp[i], inv_n);
        end
    endtask
    
    // ���ʵ�ֵ�CWM
    task software_cwm(input [11:0] a [0:N-1], input [11:0] b [0:N-1], output [11:0] result [0:N-1]);
        integer i;
        reg [11:0] a_ntt [0:N-1];
        reg [11:0] b_ntt [0:N-1];
        reg [11:0] prod [0:N-1];
        
        // ����a��NTT
        software_ntt(a, a_ntt);
        
        // ����b��NTT
        software_ntt(b, b_ntt);
        
        // ������
        for (i = 0; i < N; i = i + 1) begin
            prod[i] = mod_mult(a_ntt[i], b_ntt[i]);
        end
        
        // ����˻���INTT
        software_intt(prod, result);
    endtask
    
    // ������ת����
    function [11:0] calculate_twiddle(input integer index);
        // �����ʵ�֣�ʵ��Ӧ������Ҫ���ݾ���ı�ԭ��λ������
        // ���磬����q=3329����ԭ��λ��������1753
        reg [31:0] tw;
        begin
            // ����twiddle�����Ѿ�Ԥ�����
            // ����ʹ��һ���򵥵�ӳ����ģ��
            tw = (1753 ** index) % q;
            calculate_twiddle = tw[11:0];
        end
    endfunction
    
    // λ����
    function integer bit_reverse(input integer value);
        integer i, result;
        begin
            result = 0;
            for (i = 0; i < $clog2(N); i = i + 1) begin
                result = (result << 1) | ((value >> i) & 1);
            end
            bit_reverse = result;
        end
    endfunction
    
    // ģ�ӷ�
    function [11:0] mod_add(input [11:0] a, input [11:0] b);
        reg [12:0] sum;
        begin
            sum = a + b;
            if (sum >= q)
                sum = sum - q;
            mod_add = sum[11:0];
        end
    endfunction
    
    // ģ����
    function [11:0] mod_sub(input [11:0] a, input [11:0] b);
        reg [12:0] diff;
        begin
            diff = a - b;
            if (diff < 0)
                diff = diff + q;
            mod_sub = diff[11:0];
        end
    endfunction
    
    // ģ�˷�
    function [11:0] mod_mult(input [11:0] a, input [11:0] b);
        reg [23:0] prod;
        begin
            prod = a * b;
            mod_mult = prod % q;
        end
    endfunction
    
    // ģ��Ԫ (��ʵ�֣�ʵ��Ӧ���п�����Ҫ����Ч���㷨)
    function [11:0] mod_inverse(input integer value);
        integer i;
        begin
            for (i = 1; i < q; i = i + 1) begin
                if ((value * i) % q == 1) begin
                    mod_inverse = i;
                end
            end
            mod_inverse = 1; // Ĭ�Ϸ���1
        end
    endfunction
    
endmodule    
