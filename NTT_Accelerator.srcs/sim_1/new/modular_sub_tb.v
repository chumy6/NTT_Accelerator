`timescale 1ns / 1ns

module modular_sub_tb();

    // ���Բ���
    parameter CYCLE = 10;  // ʱ������(ns)
    
    // �ź�����
    reg [11:0] a, b;
    wire [11:0] T;
    reg clk;
    
    // ʵ��������ģ��
    modular_sub uut (
        .a(a),
        .b(b),
        .T(T)
    );
    
    // ����ʱ��
    initial begin
        clk = 0;
        forever #(CYCLE/2) clk = ~clk;
    end
    
    // ��������
    integer i;
    initial begin
        // ��ʼ���ź�
        a = 0; b = 0;
        #CYCLE;
        
        // ��������1: a >= b������������
        a = 10; b = 3;
        #CYCLE;
        check_result();
        
        // ��������2: a < b����Ҫ��q
        a = 3; b = 10;
        #CYCLE;
        check_result();
        
        // ��������3: �߽������a=0, b=q-1
        a = 0; b = 14;
        #CYCLE;
        check_result();
        
        // ��������4: �ϴ��qֵ
        a = 200; b = 300;
        #CYCLE;
        check_result();
        
        // ���ֵ����
        for (i = 0; i < 100; i = i + 1) begin
            a = $random % 3329;
            b = $random % 3329;
            #CYCLE;
            check_result();
        end
        
        $display("���в�������ͨ��!");
        $finish;
    end
    
    // ��֤���������
    task check_result;
        integer expected;
        begin
            // ��������ֵ   
            if (a < b) 
                expected = (a - b) + 3329;
            else
                expected = (a - b) % 3329;
            
            // ���ʵ�ʽ��
            if (T === expected) begin
                $display("PASS: a=%0d, b=%0d, Test=%0d, expected=%0d", a, b, T, expected);
            end else begin
                $error("FAIL: a=%0d, b=%0d, Test=%0d, expected=%0d", 
                       a, b, T, expected);
            end
        end
    endtask

endmodule