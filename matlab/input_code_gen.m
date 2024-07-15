clear;
clc;

m = 8;
n = 24;

data = data_gen(m, n, 13, 0);

% 按格式生成完整输入数据代码
f = fopen('code.txt', 'w');
for i = 1 : m
    % 实部
    fprintf(f, strcat('I', string(i - 1), '_real <= "0000000000000000"'));
    % 输入数据与时间间隔
    for j = 1 : n
        fprintf(f, strcat(', "', dec2bin(data(j, 1, i), 16), '" AFTER T * ', string(j)));
    end
    fprintf(f, ';\n');
    % 虚部
    fprintf(f, strcat('I', string(i - 1), '_imag <= "0000000000000000"'));
    for j = 1 : n
        fprintf(f, strcat(', "', dec2bin(data(j, 2, i), 16), '" AFTER T * ', string(j)));
    end
    fprintf(f, ';\n');
end      
