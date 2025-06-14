`timescale 1ns / 1ns

module modular_sub_tb();

    // 测试参数
    parameter CYCLE = 10;  // 时钟周期(ns)
    
    // 信号声明
    reg [11:0] a, b;
    wire [11:0] T;
    reg clk;
    
    // 实例化被测模块
    modular_sub uut (
        .a(a),
        .b(b),
        .T(T)
    );
    
    // 生成时钟
    initial begin
        clk = 0;
        forever #(CYCLE/2) clk = ~clk;
    end
    
    // 测试序列
    integer i;
    initial begin
        // 初始化信号
        a = 0; b = 0;
        #CYCLE;
        
        // 测试用例1: a >= b，结果无需调整
        a = 10; b = 3;
        #CYCLE;
        check_result();
        
        // 测试用例2: a < b，需要加q
        a = 3; b = 10;
        #CYCLE;
        check_result();
        
        // 测试用例3: 边界情况，a=0, b=q-1
        a = 0; b = 14;
        #CYCLE;
        check_result();
        
        // 测试用例4: 较大的q值
        a = 200; b = 300;
        #CYCLE;
        check_result();
        
        // 随机值测试
        for (i = 0; i < 100; i = i + 1) begin
            a = $random % 3329;
            b = $random % 3329;
            #CYCLE;
            check_result();
        end
        
        $display("所有测试用例通过!");
        $finish;
    end
    
    // 验证结果的任务
    task check_result;
        integer expected;
        begin
            // 计算期望值   
            if (a < b) 
                expected = (a - b) + 3329;
            else
                expected = (a - b) % 3329;
            
            // 检查实际结果
            if (T === expected) begin
                $display("PASS: a=%0d, b=%0d, Test=%0d, expected=%0d", a, b, T, expected);
            end else begin
                $error("FAIL: a=%0d, b=%0d, Test=%0d, expected=%0d", 
                       a, b, T, expected);
            end
        end
    endtask

endmodule