% 生成用于Vivado的旋转因子.coe文件
% 每两个旋转因子占用一个存储行，位宽为24位，深度为64

% 计算模3329的旋转因子（twiddle factors）
M = 3329;  % 模数
g = 10;    % 模3329的原根
N = 128;   % 变换长度（必须是3328的因子）

% 验证N是否是3328的因子
if mod(3328, N) ~= 0
    error('变换长度N必须是3328的因子');
end

% 预计算指数基数
exponent_base = (M-1) / N;

% 计算旋转因子
twiddle_factors = zeros(1, N);
for k = 0:N-1
    % 计算旋转因子：w_N^k = g^(k*(M-1)/N) mod M
    exponent = mod(k * exponent_base, M-1);  % 利用费马小定理简化指数
    twiddle_factors(k+1) = powermod(g, exponent, M);
end

% 显示前10个旋转因子
disp('前10个旋转因子:');
disp(twiddle_factors(1:10));

% 初始化内存内容（64行，每行24位）
memory_content = zeros(64, 24);

% 将旋转因子每两个存储在一个24位宽的存储行中
for i = 1:64
    idx0 = (i-1)*2 + 1;       % 第一个旋转因子索引
    idx1 = (i-1)*2 + 2;       % 第二个旋转因子索引
    
    % 确保索引不越界
    if idx0 <= N && idx1 <= N
        % 将两个12位的旋转因子组合成一个24位的存储行
        % 左12位存储第一个因子，右12位存储第二个因子
        memory_content(i, :) = [dec2bin(twiddle_factors(idx0), 12), dec2bin(twiddle_factors(idx1), 12)];
    elseif idx0 <= N
        % 如果只有一个因子可用（最后一个可能的情况）
        memory_content(i, :) = [dec2bin(twiddle_factors(idx0), 12), dec2bin(0, 12)];
    else
        % 不应该发生，因为N=128是偶数
        error('索引越界错误');
    end
end

% 写入.coe文件
fid = fopen('twiddle_factors.coe', 'w');
fprintf(fid, 'memory_initialization_radix=2;\n');
fprintf(fid, 'memory_initialization_vector=\n');
for i = 1:63
    fprintf(fid, '%s,\n', memory_content(i, :));
end
fprintf(fid, '%s;', memory_content(64, :));
fclose(fid);

% 显示完成信息
disp('旋转因子文件生成成功:');
disp('twiddle_factors.coe');    
