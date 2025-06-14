`timescale 1ns / 1ps

module modular_add_tb();

    // ���Բ���
    parameter CYCLE = 10;  // ʱ������(ns)
    
    // �ź�����
    reg [11:0] a, b;
    wire [11:0] T;
    reg clk;
    
    // ʵ��������ģ��
    modular_add uut (
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
        
        // ��������1: a + b < q������������
        a = 5; b = 3;
        #CYCLE;
        check_result();
        
        // ��������2: a + b �� q����Ҫ��q
        a = 7; b = 5;
        #CYCLE;
        check_result();
        
        // ��������3: a + b �� 2q����Ҫ��2q
        a = 15; b = 10;
        #CYCLE;
        check_result();
        
        // ��������4: �߽������a + b = q
        a = 8; b = 2;
        #CYCLE;
        check_result();
        
        // ��������5: �߽������a + b = 2q
        a = 10; b = 10;
        #CYCLE;
        check_result();
        
        // ��������6: �ϴ��qֵ
        a = 300; b = 200;
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
            expected = (a + b) % 3329;
            
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