`timescale 1ns / 1ns

module DBU_tb();

    // 定义参数
    parameter q = 3329;  // 模数
    
    // 输入信号
    reg clk;
    reg rst_n;
    reg [1:0] func_sel;
    reg [11:0] x1, y1, w1;
    reg [11:0] x2, y2, w2;
    
    // 输出信号
    wire [11:0] X1, Y1;
    wire [11:0] X2, Y2;
    
    // 软件计算结果
    reg [11:0] sw_X1, sw_Y1;
    reg [11:0] sw_X2, sw_Y2;
    
    // 实例化被测模块
    DBU uut (
        .clk(clk),
        .rst_n(rst_n),
        .func_sel(func_sel),
        .x1(x1),
        .y1(y1),
        .w1(w1),
        .x2(x2),
        .y2(y2),
        .w2(w2),
        .X1(X1),
        .Y1(Y1),
        .X2(X2),
        .Y2(Y2)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns周期时钟
    end
    
    // 测试序列
    initial begin
        // 初始化信号
        rst_n = 0;
        func_sel = 2'b00; //NTT测试
        x1 = 12'd0; y1 = 12'd0; w1 = 12'd0;
        x2 = 12'd0; y2 = 12'd0; w2 = 12'd0;
        
        // 复位
        #20;
        rst_n = 1;
        #20;
        
        // ===========================================//
        // ============= 测试NTT算法 =================//
        // ===========================================//
        $display("Testing NTT algorithm...");
        func_sel = 2'b00;
        x1 = 12'd100; y1 = 12'd200; w1 = 12'd3;
        x2 = 12'd400; y2 = 12'd500; w2 = 12'd7;
        
        // 计算软件结果
        sw_NTT();
        
        // 等待硬件计算完成
        #100;
        
        // 比较结果
        compare_results();
        
        // ===========================================//
        // ============= 测试INTT算法 ================//
        // ===========================================//
        $display("Testing INTT algorithm...");
        func_sel = 2'b01;
        x1 = 12'd100; y1 = 12'd200; w1 = 12'd3;
        x2 = 12'd400; y2 = 12'd500; w2 = 12'd7;
        
        // 计算软件结果
        sw_INTT();
        
        // 等待硬件计算完成
        #100;
        
        // 比较结果
        compare_results();
        
        // ===========================================//
        // ============== 测试CWM算法 ================//
        // ===========================================//
//        $display("Testing CWM algorithm...");
//        func_sel = 2'b10;
//        x1 = 12'd100; y1 = 12'd200; w1 = 12'd3;
//        x2 = 12'd400; y2 = 12'd500; w2 = 12'd7;
        
//        // 计算软件结果
//        sw_CWM();
        
//        // 等待硬件计算完成
//        #150;
        
//        // 比较结果
//        compare_results();
        
        // 结束仿真
        $display("Simulation completed.");
        $finish;
    end
    
    // 软件NTT计算
    task sw_NTT;
    begin
        integer z1_sw, z2_sw;
        
        // 计算z1 = y1*w1 mod q
        z1_sw = (y1 * w1) % q;
        // 计算z2 = y2*w2 mod q
        z2_sw = (y2 * w2) % q;
        
        // 计算X1 = x1 + z1 mod q
        sw_X1 = (x1 + z1_sw) % q;
        // 计算Y1 = x1 - z1 mod q
        sw_Y1 = (x1 >= z1_sw) ? (x1 - z1_sw) : (x1 - z1_sw + q);
        
        // 计算X2 = x2 + z2 mod q
        sw_X2 = (x2 + z2_sw) % q;
        // 计算Y2 = x2 - z2 mod q
        sw_Y2 = (x2 >= z2_sw) ? (x2 - z2_sw) : (x2 - z2_sw + q);
        
        $display("NTT software results: X1=%0d, Y1=%0d, X2=%0d, Y2=%0d", sw_X1, sw_Y1, sw_X2, sw_Y2);
    end
    endtask
    
    // 软件INTT计算
    task sw_INTT;
    begin
        integer t1_madd_sw, t1_msub_sw;
        integer t2_madd_sw, t2_msub_sw;
        integer Y1_temp_sw, Y2_temp_sw;
        
        // 计算t1_madd = x1 + y1 mod q
        t1_madd_sw = (x1 + y1) % q;
        // 计算t1_msub = x1 - y1 mod q
        t1_msub_sw = (x1 >= y1) ? (x1 - y1) : (x1 - y1 + q);
        
        // 计算t2_madd = x2 + y2 mod q
        t2_madd_sw = (x2 + y2) % q;
        // 计算t2_msub = x2 - y2 mod q
        t2_msub_sw = (x2 >= y2) ? (x2 - y2) : (x2 - y2 + q);
        
        // 计算Y1_temp = t1_msub * w1 mod q
        Y1_temp_sw = (t1_msub_sw * w1) % q;
        // 计算Y2_temp = t2_msub * w2 mod q
        Y2_temp_sw = (t2_msub_sw * w2) % q;
        
        // 计算X1 = t1_madd / 2
        sw_X1 = t1_madd_sw >> 1;
        // 计算Y1 = Y1_temp / 2
        sw_Y1 = Y1_temp_sw >> 1;
        
        // 计算X2 = t2_madd / 2
        sw_X2 = t2_madd_sw >> 1;
        // 计算Y2 = Y2_temp / 2
        sw_Y2 = Y2_temp_sw >> 1;
        
        $display("INTT software results: X1=%0d, Y1=%0d, X2=%0d, Y2=%0d", sw_X1, sw_Y1, sw_X2, sw_Y2);
    end
    endtask
    
    // 软件CWM计算
    task sw_CWM;
    begin
        integer z1_sw, z2_sw, z3_sw, z4_sw, z5_sw;
        
        // 五次模乘
        z1_sw = (y1 * w1) % q;
        z2_sw = (y2 * w2) % q;
        z3_sw = (x1 * w1) % q;
        z4_sw = (x2 * w2) % q;
        z5_sw = (y1 * y2) % q;
        
        // 两次模加（示例计算，具体根据CWM算法要求）
        sw_X1 = (z1_sw + z2_sw) % q;
        sw_Y1 = z3_sw;
        sw_X2 = z4_sw;
        sw_Y2 = z5_sw;
        
        $display("CWM software results: X1=%0d, Y1=%0d, X2=%0d, Y2=%0d", sw_X1, sw_Y1, sw_X2, sw_Y2);
    end
    endtask
    
    // 结果比较
    task compare_results;
    begin
        $display("Hardware results: X1=%0d, Y1=%0d, X2=%0d, Y2=%0d", X1, Y1, X2, Y2);
        
        if (X1 == sw_X1 && Y1 == sw_Y1 && X2 == sw_X2 && Y2 == sw_Y2) begin
            $display("PASS: Results match!");
        end else begin
            $display("FAIL: Results mismatch!");
            if (X1 != sw_X1) $display("  X1 mismatch: hardware=%0d, software=%0d", X1, sw_X1);
            if (Y1 != sw_Y1) $display("  Y1 mismatch: hardware=%0d, software=%0d", Y1, sw_Y1);
            if (X2 != sw_X2) $display("  X2 mismatch: hardware=%0d, software=%0d", X2, sw_X2);
            if (Y2 != sw_Y2) $display("  Y2 mismatch: hardware=%0d, software=%0d", Y2, sw_Y2);
        end
        
        $display("----------------------------------------");
    end
    endtask
    
endmodule    