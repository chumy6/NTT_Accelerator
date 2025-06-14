`timescale 1ns / 1ns

module DMM_tb();

    // 定义参数
    parameter CLK_PERIOD = 10;  // 时钟周期10ns
    parameter MODULUS = 3329;   // 模数值
    
    // 信号声明
    reg clk;
    reg [11:0] x1, y1, x2, y2;  // 12位输入，足够表示0-3328
    wire [11:0] z1, z2;         // 12位输出
    reg [11:0] expected_z1, expected_z2;  // 预期输出
    reg error;                  // 错误标志
    
    // 索引表
    reg [2:0] k7_x1, k7_y1, k7_x2, k7_y2;
    reg [4:0] k31_x1, k31_y1, k31_x2, k31_y2;
    reg [4:0] k32_x1, k32_y1, k32_x2, k32_y2;
    
    // 加法表结果
    reg [2:0] q1_1, q1_2;       // 对应z1和z2的q1
    reg [4:0] q2_1, q2_2;       // 对应z1和z2的q2
    reg [4:0] q3_1, q3_2;       // 对应z1和z2的q3
    
    // 实例化被测模块
    DMM uut (
        .clk(clk),
        .x1(x1),
        .y1(y1),
        .x2(x2),
        .y2(y2),
        .z1(z1),
        .z2(z2)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // 读取索引表
    integer idx_file;
    reg [31:0] idx_data [0:MODULUS-1][0:2];  // 3329行3列
    
    // 读取加法表
    integer add7_file, add31_file, add32_file;
    reg [31:0] add7_data [0:7][0:7];        // 8x8
    reg [31:0] add31_data [0:31][0:31];     // 32x32
    reg [31:0] add32_data [0:31][0:31];     // 32x32
    
    // 读取重建表 (7个sheet，每个32x32)
    integer recon_files [0:6];
    reg [31:0] recon_data [0:6][0:31][0:31]; // 7x32x32
    
    // 初始化文件读取和测试
    initial begin        
        // ---------------------------------------//
        // ------------ 数据读取 -----------------//
        //----------------------------------------//
        // 读取索引表
        idx_file = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table1.txt", "r");
        if (!idx_file) begin
            $display("Error: Could not open table1.txt");
            $finish;
        end
        
        for (integer i = 0; i < MODULUS; i = i + 1) begin
            $fscanf(idx_file, "%d %d %d", idx_data[i][0], idx_data[i][1], idx_data[i][2]);
        end
        $fclose(idx_file);
        
        // 读取加法表
        add7_file = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table2_7.txt", "r");
        if (!add7_file) begin
            $display("Error: Could not open table2_7.txt");
            $finish;
        end
        
        for (integer i = 0; i < 8; i = i + 1) begin
            for (integer j = 0; j < 8; j = j + 1) begin
                $fscanf(add7_file, "%d", add7_data[i][j]);
            end
        end
        $fclose(add7_file);
        
        add31_file = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table2_31.txt", "r");
        if (!add31_file) begin
            $display("Error: Could not open table2_31.txt");
            $finish;
        end
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                $fscanf(add31_file, "%d", add31_data[i][j]);
            end
        end
        $fclose(add31_file);
        
        add32_file = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table2_32.txt", "r");
        if (!add32_file) begin
            $display("Error: Could not open table2_32.xlsx");
            $finish;
        end
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                $fscanf(add32_file, "%d", add32_data[i][j]);
            end
        end
        $fclose(add32_file);
        
        // 读取重建表 (7个sheet)
        // 直接读取重建表的7个sheet
        recon_files[0] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet1.txt", "r");
        if (!recon_files[0]) begin
            $display("Error: Could not open table3_sheet1.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet1.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[0], "%d", recon_data[0][i][j]) != 1) begin
                    $display("Error reading table3_sheet1.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[0]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[0]);
        
        recon_files[1] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet2.txt", "r");
        if (!recon_files[1]) begin
            $display("Error: Could not open table3_sheet2.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet2.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[1], "%d", recon_data[1][i][j]) != 1) begin
                    $display("Error reading table3_sheet2.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[1]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[1]);
        
        // 重复上述模式读取table3_sheet3.txt
        recon_files[2] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet3.txt", "r");
        if (!recon_files[2]) begin
            $display("Error: Could not open table3_sheet3.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet3.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[2], "%d", recon_data[2][i][j]) != 1) begin
                    $display("Error reading table3_sheet3.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[2]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[2]);
        
        // 重复上述模式读取table3_sheet4.txt
        recon_files[3] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet4.txt", "r");
        if (!recon_files[3]) begin
            $display("Error: Could not open table3_sheet4.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet4.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[3], "%d", recon_data[3][i][j]) != 1) begin
                    $display("Error reading table3_sheet4.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[3]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[3]);
        
        // 重复上述模式读取table3_sheet5.txt
        recon_files[4] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet5.txt", "r");
        if (!recon_files[4]) begin
            $display("Error: Could not open table3_sheet5.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet5.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[4], "%d", recon_data[4][i][j]) != 1) begin
                    $display("Error reading table3_sheet5.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[4]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[4]);
        
        // 重复上述模式读取table3_sheet6.txt
        recon_files[5] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet6.txt", "r");
        if (!recon_files[5]) begin
            $display("Error: Could not open table3_sheet6.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet6.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[5], "%d", recon_data[5][i][j]) != 1) begin
                    $display("Error reading table3_sheet6.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[5]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[5]);
        
        // 重复上述模式读取table3_sheet7.txt
        recon_files[6] = $fopen("E:/Vivado_Project/NTT_Accelerator/matlab/table3_sheet7.txt", "r");
        if (!recon_files[6]) begin
            $display("Error: Could not open table3_sheet7.txt");
            $finish;
        end
        $display("Successfully opened table3_sheet7.txt");
        
        for (integer i = 0; i < 32; i = i + 1) begin
            for (integer j = 0; j < 32; j = j + 1) begin
                if ($fscanf(recon_files[6], "%d", recon_data[6][i][j]) != 1) begin
                    $display("Error reading table3_sheet7.txt at row %d, column %d", i+1, j+1);
                    $fclose(recon_files[6]);
                    $finish;
                end
            end
        end
        $fclose(recon_files[6]);
        
        //------------------------------//
        // -------- 开始测试 -----------//
        //------------------------------//
        $display("Starting DMM_v2 test...");
        
        // 初始化变量
        error = 0;
        
        // 简单测试一些值
        test_values(1, 2, 3, 4);
        test_values(5, 6, 7, 8);
        test_values(100, 200, 300, 400);
        test_values(1000, 2000, 3000, 3328);
        
        // 随机测试更多值
//        for (integer i = 0; i < 100; i = i + 1) begin
//            test_values($urandom_range(0, MODULUS-1), 
//                        $urandom_range(0, MODULUS-1),
//                        $urandom_range(0, MODULUS-1), 
//                        $urandom_range(0, MODULUS-1));
//        end
        
        // 测试完成
        if (!error) begin
            $display("All tests passed!");
        end else begin
            $display("Some tests failed!");
        end
        $finish;
    end
    
    //-------------------------------------------//
    // ------------- 测试函数 -------------------//
    //-------------------------------------------//
    task test_values;
        input [11:0] a1, b1, a2, b2;
        begin
            // 设置输入值
            x1 = a1;
            y1 = b1;
            x2 = a2;
            y2 = b2;
            
            // 等待时钟上升沿，让DMM_v2计算
            @(posedge clk);
//            #1;  // 等待一小段时间让输出稳定
            //DMM在5个时钟周期之后才输出值，暂时不知道原因是什么……
            #CLK_PERIOD;
            #CLK_PERIOD;
            #CLK_PERIOD;
            #CLK_PERIOD;
            #CLK_PERIOD;
            // 等待一小段时间让输出稳定
            #CLK_PERIOD;
            
            
            // 通过查表计算预期结果
            calculate_expected(a1, b1, a2, b2);
            
            // 比较结果
            if (z1 !== expected_z1 || z2 !== expected_z2) begin
                $display("Test failed!");
                $display("Input: x1=%d, y1=%d, x2=%d, y2=%d", a1, b1, a2, b2);
                $display("Output: z1=%d, z2=%d", z1, z2);
                $display("Expected: z1=%d, z2=%d", expected_z1, expected_z2);
                error = 1;
            end else begin
                $display("Test passed: x1=%d, y1=%d, x2=%d, y2=%d", a1, b1, a2, b2);
            end
        end
    endtask
    
    // 查表计算预期结果
    task calculate_expected;
        input [11:0] a1, b1, a2, b2;
        begin
            // 1. 从索引表获取k值
            k7_x1 = idx_data[a1][0];
            k31_x1 = idx_data[a1][1];
            k32_x1 = idx_data[a1][2];
            
            k7_y1 = idx_data[b1][0];
            k31_y1 = idx_data[b1][1];
            k32_y1 = idx_data[b1][2];
            
            k7_x2 = idx_data[a2][0];
            k31_x2 = idx_data[a2][1];
            k32_x2 = idx_data[a2][2];
            
            k7_y2 = idx_data[b2][0];
            k31_y2 = idx_data[b2][1];
            k32_y2 = idx_data[b2][2];
            
            // 2. 从加法表获取q值
            q1_1 = add7_data[k7_x1][k7_y1];
            q2_1 = add31_data[k31_x1][k31_y1];
            q3_1 = add32_data[k32_x1][k32_y1];
            
            q1_2 = add7_data[k7_x2][k7_y2];
            q2_2 = add31_data[k31_x2][k31_y2];
            q3_2 = add32_data[k32_x2][k32_y2];
            
            // 3. 从重建表获取最终结果
            expected_z1 = recon_data[q1_1][q3_1][q2_1];
            expected_z2 = recon_data[q1_2][q3_2][q2_2];
        end
    endtask
    
    // 监控输出变化
    always @(posedge clk) begin
        $monitor("Time=%0t, x1=%d, y1=%d, x2=%d, y2=%d, z1=%d, z2=%d", 
                 $time, x1, y1, x2, y2, z1, z2);
    end

endmodule
