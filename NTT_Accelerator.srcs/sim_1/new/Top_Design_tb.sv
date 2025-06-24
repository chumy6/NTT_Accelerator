`timescale 1ns / 1ns

module Top_Design_tb();

    // 参数定义
    parameter q = 3329;           // 有限域模数
    parameter N = 128;            // 变换长度
    parameter CLK_PERIOD = 10;    // 时钟周期(ns)
    
    // 信号声明
    reg clk;
    reg rst_n;
    reg [1:0] op_sel;
    reg start;
    wire done;
    reg [11:0] a_in;
    reg [6:0] a_addr;
    reg b_in; // 修正：b_in应为12位宽，与Top_Design模块接口一致
    reg [6:0] b_addr;
    wire [11:0] result;
    wire [6:0] result_addr;
    wire result_valid;
    
    // 软件计算结果存储
    reg [11:0] sw_ntt_result [0:N-1];
    reg [11:0] sw_intt_result [0:N-1];
    reg [11:0] sw_cwm_result [0:N-1];
    
    // 测试数据
    reg [11:0] test_data_a [0:N-1];
    reg [11:0] test_data_b [0:N-1];
    
    // 实例化被测模块
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
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // 主测试过程
    initial begin
        // 初始化信号
        rst_n = 0;
        op_sel = 2'b00;
        start = 0;
        
        // 复位
        #100;
        rst_n = 1;
        #100;
        
        // 生成测试数据
        generate_test_data();
        
        // 测试NTT
        $display("开始NTT测试...");
        test_ntt();
        
        // 测试INTT
        #200;
        $display("开始INTT测试...");
        test_intt();
        
        // 测试CWM
        #200;
        $display("开始CWM测试...");
        test_cwm();
        
        // 结束仿真
        #500;
        $finish;
    end
    
    // 生成测试数据
    task generate_test_data();
        integer i;
        for (i = 0; i < N; i = i + 1) begin
            test_data_a[i] = $urandom_range(0, q-1);
            test_data_b[i] = $urandom_range(0, q-1);
        end
        
        // 软件计算NTT结果
        software_ntt(test_data_a, sw_ntt_result);
        
        // 软件计算INTT结果
        software_intt(sw_ntt_result, sw_intt_result);
        
        // 软件计算CWM结果
        software_cwm(test_data_a, test_data_b, sw_cwm_result);
    endtask
    
    // 测试NTT
    task test_ntt();
        integer i, errors;
        
        // 加载测试数据
        load_data(test_data_a, 1'b1);
        
        // 启动NTT
        op_sel = 2'b01;
        start = 1;
        #CLK_PERIOD;
        start = 0;
        
        // 等待完成
        @(posedge done);
        #CLK_PERIOD;
        
        // 读取并验证结果
        errors = 0;
        for (i = 0; i < N; i = i + 1) begin
            @(posedge result_valid);
            if (result !== sw_ntt_result[result_addr]) begin
                $display("NTT结果不匹配! 地址: %0d, 硬件结果: %0d, 软件结果: %0d", 
                         result_addr, result, sw_ntt_result[result_addr]);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("NTT测试通过!");
        end else begin
            $display("NTT测试失败! 错误数量: %0d", errors);
        end
    endtask
    
    // 测试INTT
    task test_intt();
        integer i, errors;
        
        // 加载测试数据 (使用NTT的结果作为INTT的输入)
        load_data(sw_ntt_result, 1'b1);
        
        // 启动INTT
        op_sel = 2'b10;
        start = 1;
        #CLK_PERIOD;
        start = 0;
        
        // 等待完成
        @(posedge done);
        #CLK_PERIOD;
        
        // 读取并验证结果
        errors = 0;
        for (i = 0; i < N; i = i + 1) begin
            @(posedge result_valid);
            if (result !== sw_intt_result[result_addr]) begin
                $display("INTT结果不匹配! 地址: %0d, 硬件结果: %0d, 软件结果: %0d", 
                         result_addr, result, sw_intt_result[result_addr]);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("INTT测试通过!");
        end else begin
            $display("INTT测试失败! 错误数量: %0d", errors);
        end
    endtask
    
    // 测试CWM
    task test_cwm();
        integer i, errors;
        
        // 加载测试数据
        load_data(test_data_a, 1'b1);
        load_data(test_data_b, 1'b0);
        
        // 启动CWM
        op_sel = 2'b11;
        start = 1;
        #CLK_PERIOD;
        start = 0;
        
        // 等待完成
        @(posedge done);
        #CLK_PERIOD;
        
        // 读取并验证结果
        errors = 0;
        for (i = 0; i < N; i = i + 1) begin
            @(posedge result_valid);
            if (result !== sw_cwm_result[result_addr]) begin
                $display("CWM结果不匹配! 地址: %0d, 硬件结果: %0d, 软件结果: %0d", 
                         result_addr, result, sw_cwm_result[result_addr]);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("CWM测试通过!");
        end else begin
            $display("CWM测试失败! 错误数量: %0d", errors);
        end
    endtask
    
    // 加载数据到被测模块
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
    
    // 软件实现的NTT
    task software_ntt(input [11:0] in_data [0:N-1], output [11:0] out_data [0:N-1]);
        integer i, j, k, n;
        reg [11:0] temp [0:N-1];
        reg [11:0] twiddle [0:N-1];
        
        // 预计算旋转因子
        for (i = 0; i < N; i = i + 1) begin
            twiddle[i] = calculate_twiddle(i);
        end
        
        // 复制输入数据
        for (i = 0; i < N; i = i + 1) begin
            temp[i] = in_data[i];
        end
        
        // 位逆序重排
        for (i = 0; i < N; i = i + 1) begin
            j = bit_reverse(i);
            if (i < j) begin
                k = temp[i];
                temp[i] = temp[j];
                temp[j] = k;
            end
        end
        
        // 蝶形运算
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
        
        // 输出结果
        for (i = 0; i < N; i = i + 1) begin
            out_data[i] = temp[i];
        end
    endtask
    
    // 软件实现的INTT
    task software_intt(input [11:0] in_data [0:N-1], output [11:0] out_data [0:N-1]);
        integer i;
        reg [11:0] temp [0:N-1];
        reg [11:0] inv_n;
        
        // 计算N的逆元
        inv_n = mod_inverse(N);
        
        // 调用NTT (INTT是NTT的逆变换)
        software_ntt(in_data, temp);
        
        // 乘以N的逆元
        for (i = 0; i < N; i = i + 1) begin
            out_data[i] = mod_mult(temp[i], inv_n);
        end
    endtask
    
    // 软件实现的CWM
    task software_cwm(input [11:0] a [0:N-1], input [11:0] b [0:N-1], output [11:0] result [0:N-1]);
        integer i;
        reg [11:0] a_ntt [0:N-1];
        reg [11:0] b_ntt [0:N-1];
        reg [11:0] prod [0:N-1];
        
        // 计算a的NTT
        software_ntt(a, a_ntt);
        
        // 计算b的NTT
        software_ntt(b, b_ntt);
        
        // 逐点相乘
        for (i = 0; i < N; i = i + 1) begin
            prod[i] = mod_mult(a_ntt[i], b_ntt[i]);
        end
        
        // 计算乘积的INTT
        software_intt(prod, result);
    endtask
    
    // 计算旋转因子
    function [11:0] calculate_twiddle(input integer index);
        // 这里简化实现，实际应用中需要根据具体的本原单位根计算
        // 例如，对于q=3329，本原单位根可以是1753
        reg [31:0] tw;
        begin
            // 假设twiddle因子已经预计算好
            // 这里使用一个简单的映射来模拟
            tw = (1753 ** index) % q;
            calculate_twiddle = tw[11:0];
        end
    endfunction
    
    // 位逆序
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
    
    // 模加法
    function [11:0] mod_add(input [11:0] a, input [11:0] b);
        reg [12:0] sum;
        begin
            sum = a + b;
            if (sum >= q)
                sum = sum - q;
            mod_add = sum[11:0];
        end
    endfunction
    
    // 模减法
    function [11:0] mod_sub(input [11:0] a, input [11:0] b);
        reg [12:0] diff;
        begin
            diff = a - b;
            if (diff < 0)
                diff = diff + q;
            mod_sub = diff[11:0];
        end
    endfunction
    
    // 模乘法
    function [11:0] mod_mult(input [11:0] a, input [11:0] b);
        reg [23:0] prod;
        begin
            prod = a * b;
            mod_mult = prod % q;
        end
    endfunction
    
    // 模逆元 (简化实现，实际应用中可能需要更高效的算法)
    function [11:0] mod_inverse(input integer value);
        integer i;
        begin
            for (i = 1; i < q; i = i + 1) begin
                if ((value * i) % q == 1) begin
                    mod_inverse = i;
                end
            end
            mod_inverse = 1; // 默认返回1
        end
    endfunction
    
endmodule    
