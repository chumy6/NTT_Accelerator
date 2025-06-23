`timescale 1ns / 1ns

module DBU_tb();

    // 定义参数
    parameter q = 3329;  // 模数
    parameter CLK_PERIOD = 10; // 10ns时钟周期
    
    // 输入信号
    reg clk;
    reg rst_n;
    reg func_sel;
    reg [11:0] x1, y1, w1;
    reg [11:0] x2, y2, w2;
    
    // 输出信号
    wire [11:0] X1, Y1;
    wire [11:0] X2, Y2;
    wire dbu_valid;  // 输出有效标志
    
    // 软件计算结果
    reg [11:0] sw_X1, sw_Y1;
    reg [11:0] sw_X2, sw_Y2;
    
    // 测试状态机
    reg [2:0] test_state;
    reg [2:0] current_test;  // 保存当前测试状态
    reg [3:0] hw_delay_cnt;  // 新增：硬件延迟计数器
    localparam IDLE = 3'd0,
               NTT_TEST = 3'd1,
               INTT_TEST = 3'd2,
               COMPARE_RESULTS = 3'd3,
               WAIT_VALID = 3'd4,
               WAIT_HW_COMPLETE = 3'd5;  // 新增：等待硬件完成状态
    
    // 测试计数器
    reg [3:0] test_cnt;
    
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
        .Y2(Y2),
        .dbu_valid(dbu_valid)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // 测试序列
    initial begin
        // 初始化
        rst_n = 0;
        func_sel = 2'b00;
        x1 = 12'd0; y1 = 12'd0; w1 = 12'd0;
        x2 = 12'd0; y2 = 12'd0; w2 = 12'd0;
        test_state = IDLE;
        test_cnt = 4'd0;
        hw_delay_cnt = 4'd0;  // 初始化延迟计数器
        
        // 复位
        #20;
        rst_n = 1;
        #20;
        
        // 开始测试
        test_state = NTT_TEST;
        #(CLK_PERIOD*10); // 等待系统稳定
        
        // 主测试循环
        while (test_state != IDLE) begin
            @(posedge clk);
            case (test_state)
                NTT_TEST: begin
                    $display("Testing NTT algorithm...");
                    func_sel = 2'b00;
                    x1 = 12'd5; y1 = 12'd1; w1 = 12'd2;
                    x2 = 12'd6; y2 = 12'd3; w2 = 12'd4;
                    
                    // 计算软件结果
                    sw_NTT();
                    
                    current_test = NTT_TEST;  // 保存当前测试状态
                    test_state = WAIT_VALID;
                    test_cnt = 4'd0;
                end
                
                INTT_TEST: begin
                    $display("Testing INTT algorithm...");
                    func_sel = 2'b01;
                    x1 = 12'd11; y1 = 12'd7; w1 = 12'd8;
                    x2 = 12'd12; y2 = 12'd9; w2 = 12'd10;
                    
                    // 计算软件结果
                    sw_INTT();
                    
                    current_test = INTT_TEST;  // 保存当前测试状态
                    test_state = WAIT_VALID;
                    test_cnt = 4'd0;
                end
                
                WAIT_VALID: begin
                    // 等待输出有效信号
                    if (dbu_valid) begin
                        hw_delay_cnt = 4'd0;  // 重置延迟计数器
                        test_state = WAIT_HW_COMPLETE;  // 转移到等待硬件完成状态
                    end else begin
                        test_cnt = test_cnt + 1'b1;
                        // 超时保护
                        if (test_cnt > 4'd15) begin
                            $display("ERROR: Timeout waiting for valid output");
                            $finish;
                        end
                    end
                end
                
                WAIT_HW_COMPLETE: begin
                    // 等待硬件计算完成（额外延迟10个时钟周期）
                    hw_delay_cnt = hw_delay_cnt + 1'b1;
                    if (hw_delay_cnt >= 4'd10) begin  // 等待10个周期
                        test_state = COMPARE_RESULTS;
                    end
                end
                
                COMPARE_RESULTS: begin
                    // 比较结果
                    compare_results();
                    
                    // 根据保存的测试状态切换到下一个测试
                    case (current_test)
                        NTT_TEST: test_state = INTT_TEST;
                        INTT_TEST: begin
                            test_state = IDLE;
                            $display("All tests completed.");
                            $finish;
                        end
                        default: test_state = IDLE;
                    endcase
                end
                
                default: test_state = IDLE;
            endcase
        end
        
        $display("Simulation completed.");
        $finish;
    end
    
    // ============================================//
    // ============ 软件NTT计算 ===================//
    // ===========================================//
    task sw_NTT;
    begin
        integer z1_sw, z2_sw;
        
        z1_sw = (y1 * w1) % q; // 计算z1 = |y1*w1| mod q
        z2_sw = (y2 * w2) % q; // 计算z2 = |y2*w2| mod q
        
        sw_X1 = (x1 + z1_sw) % q; // 计算X1 = |x1 + z1| mod q
        sw_Y1 = (x1 >= z1_sw) ? (x1 - z1_sw) : (x1 - z1_sw + q); // 计算Y1 = |x1 - z1| mod q
        
        sw_X2 = (x2 + z2_sw) % q; // 计算X2 = |x2 + z2| mod q
        sw_Y2 = (x2 >= z2_sw) ? (x2 - z2_sw) : (x2 - z2_sw + q); // 计算Y2 = |x2 - z2| mod q
        
        $display("NTT software results: X1=%0d, Y1=%0d, X2=%0d, Y2=%0d", sw_X1, sw_Y1, sw_X2, sw_Y2);
    end
    endtask
    
    // =========================================== //
    // =============== 软件INTT计算 ============== //
    // =========================================== //
    task sw_INTT;
    begin
        integer t1_madd_sw, t1_msub_sw;
        integer t2_madd_sw, t2_msub_sw;
        integer Y1_temp_sw, Y2_temp_sw;
        
        t1_madd_sw = (x1 + y1) % q; // 计算t1_madd = |x1 + y1| mod q
        t1_msub_sw = (x1 >= y1) ? (x1 - y1) : (x1 - y1 + q); // 计算t1_msub = |x1 - y1| mod q
        
        t2_madd_sw = (x2 + y2) % q; // 计算t2_madd = |x2 + y2| mod q
        t2_msub_sw = (x2 >= y2) ? (x2 - y2) : (x2 - y2 + q); // 计算t2_msub = |x2 - y2| mod q
        
        Y1_temp_sw = (t1_msub_sw * w1) % q; // 计算Y1_temp = |t1_msub * w1| mod q
        Y2_temp_sw = (t2_msub_sw * w2) % q; // 计算Y2_temp = |t2_msub * w2| mod q
        
        sw_X1 = t1_madd_sw >> 1; // 计算X1 = t1_madd / 2
        sw_Y1 = Y1_temp_sw >> 1; // 计算Y1 = Y1_temp / 2
        
        sw_X2 = t2_madd_sw >> 1; // 计算X2 = t2_madd / 2
        sw_Y2 = Y2_temp_sw >> 1; // 计算Y2 = Y2_temp / 2
        
        $display("INTT software results: X1=%0d, Y1=%0d, X2=%0d, Y2=%0d", sw_X1, sw_Y1, sw_X2, sw_Y2);
    end
    endtask
    
    // =======================================//
    // ============= 结果比较 ===============//
    // ======================================//
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
