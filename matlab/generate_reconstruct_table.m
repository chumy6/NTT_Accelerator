%论文中编号31列全部为0，不知道是为什么？这一列不应该没有吗？
function tables = generate_reconstruct_table()
    % 系统参数
    q = 3329;
    submods = [7, 32, 31]; % 修改为 [表数量, 行数, 列数]
    M = prod(submods); % 6944
    alpha = 3;
    
    % === CRT 系数 ===
    % 这里这几个模逆不知道怎么算的
%     inv1 = powermod(1/(submods(2)*submods(3)), 1, submods(1)); % |1/992|_7 = 3
%     inv2 = powermod(1/(submods(1)*submods(3)), 1, submods(2)); % |1/217|_32 = 9
%     inv3 = powermod(1/(submods(1)*submods(2)), 1, submods(3)); % |1/224|_31 = 9

    inv1 = 3;
    inv2 = 9;
    inv3 = 9;
    
    c1 = (submods(2)*submods(3)) * inv1; % 992*3 = 2976
    c2 = (submods(1)*submods(3)) * inv2; % 217*9 = 1953
    c3 = (submods(1)*submods(2)) * inv3; % 224*9 = 2016

    % === 初始化表格 ===
    tables = zeros(submods(1), submods(2), submods(3));
    
    % === 生成三维表 (7x32x31) ===
    for table_idx = 0:submods(1)-1
        for row = 0:submods(2)-1
            for col = 0:submods(3)-1
                % CRT 重建
                r = mod(table_idx*c1 + row*c2 + col*c3, M);
                
                % 模溢出修正
                r_final = mod(r, q-1); % q-1=3328
                
                % 逆映射
                result = powermod(alpha, r_final, q);
                
                % 存入三维表(注意MATLAB索引从1开始)
                tables(table_idx+1, row+1, col+1) = result;
            end
        end
    end
    
    % === 将三维数组重构为表格数组 ===
    output_tables = cell(submods(1), 1);
    for i = 1:submods(1)
        output_tables{i} = tables(i, :, :);
        output_tables{i} = squeeze(output_tables{i}); % 转为二维矩阵(32行x31列)
    end
    
    tables = output_tables;
end
