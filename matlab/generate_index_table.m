%% Index table检查无误
function table1 = generate_index_table()
    q = 3329;
    alpha = 3; % 原根
    submods = [7, 31, 32];
    
    % === 步骤1：生成离散对数表 k -> g ===
    k_to_g = zeros(1, q-1); % 预分配 (k: 0~3327)
    for k = 0:q-2
        k_to_g(k+1) = powermod(alpha, k, q); % 模幂计算
    end
%     k_to_g  %已检查输出显示没有问题
    
    % === 步骤2：构建逆向映射 g -> k ===
    g_to_k = -ones(1, q); % 初始化-1 (g: 0~3328)
    for k = 0:q-2
        g_val = k_to_g(k+1);
        g_to_k(g_val+1) = k; % g_val=1 → 索引1
    end
    
    % === 零元素特殊处理 ===
    g_to_k(1) = 0; % g=1 对应 k=0
    g_to_k = g_to_k(2:q); % 取后3328个数据
%     g_to_k %已检查输出没有问题
    
    % === 步骤3：计算子模余数 ===
    table1 = zeros(q, 3); % [ |k|_7, |k|_{31}, |k|_{32} ]
    for g = 0:q-2
        k_val = g_to_k(g+1);
        % 零元素处理：设余数为 [0,0,0] (实际乘法时会跳过)
        if g == 0
            table1(g+1, :) = [0, 0, 0];
        else
            table1(g+1, :) = mod(k_val, submods);
        end
    end

    table1 = table1(1:end-1, :); %去掉最后一行
    
end
