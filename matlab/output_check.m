clear;
clc;

m = 8;
n = 24;

data = data_gen(m, n, 13, 0);

% 处理随机数据表
input = transpose(reshape(data(:, 1, :) + 1j * data(:, 2, :), n, m));  % 合成为复数表并转置为列输入

% 第1~7个计算FFT
fft_output = fft(input(:, 1 : 7), 8);

% 第13~24个计算IFFT
ifft_output = ifft(input(:, 13 : 24), 8);
