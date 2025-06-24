% 生成用于Vivado的.coe文件，组织随机系数a和b到MEM0和MEM1
% 脚本按照指定规则将0-3329之间的随机系数组织到两个.coe文件中
clear;
clc;

% 设置随机数种子以便结果可重现
rng('shuffle');

% 生成系数a和系数b (0-3329之间的随机整数)
a_coeffs = randi([0, 3329], 1, 128);
b_coeffs = randi([0, 3329], 1, 128);

% 初始化MEM0和MEM1的内存内容
mem0_content = zeros(64, 24); % 64行，每行24位(两个12位系数)
mem1_content = zeros(64, 24); % 64行，每行24位(两个12位系数)

% 组织系数a到MEM0和MEM1的前32行
% MEM0存储偶数下标的系数 (a0,a2,a4...)
% MEM1存储奇数下标的系数 (a1,a3,a5...)
for i = 1:32
    % 计算对应的系数索引
    idx0 = (i-1)*2;       % 偶数索引
    idx1 = (i-1)*2 + 1;   % 奇数索引
    
    % 组合两个12位系数为24位
    mem0_content(i, :) = [dec2bin(a_coeffs(idx0+1), 12), dec2bin(a_coeffs(idx1+1), 12)];
    mem1_content(i, :) = [dec2bin(a_coeffs(idx1+1), 12), dec2bin(a_coeffs(idx0+1), 12)];
end

% 组织系数b到MEM0和MEM1的33-64行
% MEM0存储奇数下标的系数 (b1,b3,b5...)
% MEM1存储偶数下标的系数 (b0,b2,b4...)
for i = 33:64
    % 计算对应的系数索引
    idx0 = (i-33)*2;       % 偶数索引
    idx1 = (i-33)*2 + 1;   % 奇数索引
    
    % 组合两个12位系数为24位
    mem0_content(i, :) = [dec2bin(b_coeffs(idx1+1), 12), dec2bin(b_coeffs(idx0+1), 12)];
    mem1_content(i, :) = [dec2bin(b_coeffs(idx0+1), 12), dec2bin(b_coeffs(idx1+1), 12)];
end

% 写入MEM0的.coe文件
fid0 = fopen('MEM0.coe', 'w');
fprintf(fid0, 'memory_initialization_radix=2;\n');
fprintf(fid0, 'memory_initialization_vector=\n');
for i = 1:63
    fprintf(fid0, '%s,\n', mem0_content(i, :));
end
fprintf(fid0, '%s;', mem0_content(64, :));
fclose(fid0);

% 写入MEM1的.coe文件
fid1 = fopen('MEM1.coe', 'w');
fprintf(fid1, 'memory_initialization_radix=2;\n');
fprintf(fid1, 'memory_initialization_vector=\n');
for i = 1:63
    fprintf(fid1, '%s,\n', mem1_content(i, :));
end
fprintf(fid1, '%s;', mem1_content(64, :));
fclose(fid1);

% 显示完成信息
disp('Coefficient files generated successfully:');
disp('MEM0.coe and MEM1.coe');    
