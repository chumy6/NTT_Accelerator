%% Dual Modular Multiplier
clear;
clc;

%% 生成Index tables
table1 = generate_index_table();

% 要添加的首行数据
firstRow = [0, 31, 0];

% 在表格数据的开头添加新行
table1 = [firstRow; table1];

% 将每列数据转换为相应位宽的二进制
Index7_bin = dec2bin(table1(:,1), 3);  % 第一列转为3位二进制
Index31_bin = dec2bin(table1(:,2), 5);  % 第二列转为5位二进制
Index32_bin = dec2bin(table1(:,3), 5);  % 第三列转为5位二进制

% 输出Index7.coe文件
fileID = fopen('Index7.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:size(Index7_bin, 1)
    if i < size(Index7_bin, 1)
        fprintf(fileID, '%s,\n', Index7_bin(i,:));  % 写入当前行，末尾加逗号
    else
        fprintf(fileID, '%s;\n', Index7_bin(i,:));  % 最后一行末尾加分号
    end
end
fclose(fileID);
disp('数据已成功写入Index7.coe文件');

% 输出Index31.coe文件
fileID = fopen('Index31.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:size(Index31_bin, 1)
    if i < size(Index31_bin, 1)
        fprintf(fileID, '%s,\n', Index31_bin(i,:));  % 写入当前行，末尾加逗号
    else
        fprintf(fileID, '%s;\n', Index31_bin(i,:));  % 最后一行末尾加分号
    end
end
fclose(fileID);
disp('数据已成功写入Index31.coe文件');

% 输出Index32.coe文件
fileID = fopen('Index32.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:size(Index32_bin, 1)
    if i < size(Index32_bin, 1)
        fprintf(fileID, '%s,\n', Index32_bin(i,:));  % 写入当前行，末尾加逗号
    else
        fprintf(fileID, '%s;\n', Index32_bin(i,:));  % 最后一行末尾加分号
    end
end
fclose(fileID);
disp('数据已成功写入Index32.coe文件');


%% 生成 Addition tables
[table2_7, table2_31, table2_32] = generate_add_tables();

% 模7的加法表
table2_7(8, :) = 0;  % 添加全零的第8行
table2_7(:, 8) = 0;  % 添加全零的第8列

% 模31的加法表
table2_31(32, :) = 31;  % 添加全31的第32行
table2_31(:, 32) = 31;  % 添加全31的第32列

% 将每列数据转换为相应位宽的二进制
Add7_bin = dec2bin(table2_7, 3);  % 第一个表转为3位二进制
Add31_bin = dec2bin(table2_31, 5);  % 第二个表转为5位二进制
Add32_bin = dec2bin(table2_32, 5);  % 第三个表转为5位二进制

% 输出Add7.coe文件
fileID = fopen('Add7.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:size(Add7_bin, 1)
    if i < size(Add7_bin, 1)
        fprintf(fileID, '%s,\n', Add7_bin(i,:));  % 写入当前行，末尾加逗号
    else
        fprintf(fileID, '%s;\n', Add7_bin(i,:));  % 最后一行末尾加分号
    end
end
fclose(fileID);
disp('数据已成功写入Add7.coe文件');

% 输出Add31.coe文件
fileID = fopen('Add31.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:size(Add31_bin, 1)
    if i < size(Add31_bin, 1)
        fprintf(fileID, '%s,\n', Add31_bin(i,:));  % 写入当前行，末尾加逗号
    else
        fprintf(fileID, '%s;\n', Add31_bin(i,:));  % 最后一行末尾加分号
    end
end
fclose(fileID);
disp('数据已成功写入Add31.coe文件');

% 输出Add32.coe文件
fileID = fopen('Add32.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:size(Add32_bin, 1)
    if i < size(Add32_bin, 1)
        fprintf(fileID, '%s,\n', Add32_bin(i,:));  % 写入当前行，末尾加逗号
    else
        fprintf(fileID, '%s;\n', Add32_bin(i,:));  % 最后一行末尾加分号
    end
end
fclose(fileID);
disp('数据已成功写入Add32.coe文件');



%% 生成 Reconstruction table
table3 = generate_reconstruct_table();

% 添加第32列
nRows = size(table3, 1); % 获取table3的行数

% 遍历每个cell
for i = 1:nRows
    % 获取当前cell中的矩阵
    currentMatrix = table3{i};
    
    % 在最右边添加一列全零
    currentMatrix(:, end+1) = 0;
    
    % 将修改后的矩阵放回cell
    table3{i} = currentMatrix;
end

% 创建一个与table3相同大小的cell数组来存储结果
Reconstruct_bin = cell(size(table3));

% 遍历table3中的每个cell
for i = 1:size(table3, 1)
    % 获取当前cell中的数据
    decimal_data = table3{i};
    
    % 获取数据的大小
    [rows, cols] = size(decimal_data);
    
    % 创建一个cell数组来存储二进制字符串
    binary_strings = cell(rows, cols);
    
    % 遍历当前cell中的每个元素
    for r = 1:rows
        for c = 1:cols
            % 将十进制数转换为二进制字符串，并确保长度为12位
            binary_str = dec2bin(decimal_data(r, c), 12);
            
            % 存储二进制字符串
            binary_strings{r, c} = binary_str;
        end
    end
    
    % 将转换后的二进制字符串数组存入结果cell数组
    Reconstruct_bin{i} = binary_strings;
end

% 将二进制数据写入Reconstruct.coe文件
fileID = fopen('Reconstruct.coe', 'w');

% 写入COE文件头
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');

% 遍历每个cell
for i = 1:size(Reconstruct_bin, 1)
    % 获取当前cell中的二进制字符串数组
    binary_strings = Reconstruct_bin{i};
    
    % 遍历每行
    for r = 1:size(binary_strings, 1)
        % 遍历每列
        for c = 1:size(binary_strings, 2)
            % 写入二进制字符串，最后一个元素后加分号，其他元素后加逗号
            if i == size(Reconstruct_bin, 1) && r == size(binary_strings, 1) && c == size(binary_strings, 2)
                fprintf(fileID, '%s;\n', binary_strings{r, c});
            else
                fprintf(fileID, '%s,\n', binary_strings{r, c});
            end
        end
    end
end

% 关闭文件
fclose(fileID);

disp('数据已成功写入Reconstruct.coe文件');


%% 导出到Excel
% % 把索引表导出到Excel
% excel_file = 'table1.csv';
% xlswrite(excel_file, table1);
% disp('table1已成功导出到Excel文件！');
% 
% % 把加法表导出到Excel
% excel_file = 'table2_7.csv';
% xlswrite(excel_file, table2_7);
% disp('table2_7已成功导出到Excel文件！');
% 
% excel_file = 'table2_31.csv';
% xlswrite(excel_file, table2_31);
% disp('table2_31已成功导出到Excel文件！');
% 
% excel_file = 'table2_32.csv';
% xlswrite(excel_file, table2_32);
% disp('table2_32已成功导出到Excel文件！');
% 
% % 把重建表导出到Excel
% excel_file = 'table3.csv';
% sheet_names = cell(7, 1);
% 
% % 为每个sheet创建名称
% for i = 1:7
%     sheet_names{i} = sprintf('Sheet%d', i);
% end
% 
% % 导出数据到Excel
% for i = 1:7
%     xlswrite(excel_file, table3{i}, sheet_names{i}, 'A1');
% end
% 
% disp('table3已成功导出到Excel文件！');

%% 导出到文本文件
% 把索引表导出到文本文件
txt_file = 'table1.txt';
dlmwrite(txt_file, table1, 'delimiter', '\t', 'precision', '%.0f');
disp('table1已成功导出到文本文件！');

% 把加法表导出到文本文件
txt_file = 'table2_7.txt';
dlmwrite(txt_file, table2_7, 'delimiter', '\t', 'precision', '%.0f');
disp('table2_7已成功导出到文本文件！');

txt_file = 'table2_31.txt';
dlmwrite(txt_file, table2_31, 'delimiter', '\t', 'precision', '%.0f');
disp('table2_31已成功导出到文本文件！');

txt_file = 'table2_32.txt';
dlmwrite(txt_file, table2_32, 'delimiter', '\t', 'precision', '%.0f');
disp('table2_32已成功导出到文本文件！');

% 把重建表导出到文本文件
% 为每个sheet创建单独的文本文件
for i = 1:7
    txt_file = sprintf('table3_sheet%d.txt', i);
    dlmwrite(txt_file, table3{i}, 'delimiter', '\t', 'precision', '%.0f');
end

disp('table3已成功导出到文本文件！');


