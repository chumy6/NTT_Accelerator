% 存疑，7和31的表和论文中的图有出入，32没有问题
function [table2_7, table2_31, table2_32] = generate_add_tables()
    % 子模数定义
    q7 = 7; q31 = 31; q32 = 32;
    
    % 初始化表格
    table2_7  = zeros(q7, q7);
    table2_31 = zeros(q31, q31);
    table2_32 = zeros(q32, q32);
    
    % 模7加法表
    for a = 0:q7-1
        for b = 0:q7-1
            table2_7(a+1, b+1) = mod(a + b, q7);
        end
    end
%     table2_7
    
    % 模31加法表
    for a = 0:q31-1
        for b = 0:q31-1
            table2_31(a+1, b+1) = mod(a + b, q31);
        end
    end
%     table2_31
    
    % 模32加法表
    for a = 0:q32-1
        for b = 0:q32-1
            table2_32(a+1, b+1) = mod(a + b, q32);
        end
    end
%     table2_32
end
