function twiddle_factors = calculate_twiddle_factors(N)
    % 计算模3329下的旋转因子
    % 输入：N - 变换长度（必须是3328的因子）
    % 输出：twiddle_factors - 包含N个旋转因子的数组
    
    M = 3329;  % 模数
    g = 10;    % 模3329的原根
    
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
end
