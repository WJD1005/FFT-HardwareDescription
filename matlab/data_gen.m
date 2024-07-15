function data = data_gen(m, n, bitwidth, seed)
%DATA_GEN 生成输入数据
% 每一行是一个数据(n个数据），第一列是实部，第二列是虚部，第三维用于分开每个输入端口（m个端口）
% 位宽指有符号数的位宽
% 输入随机种子以确保生成结果一致

rng(seed);
data = randi([-2 ^ (bitwidth - 1), 2 ^ (bitwidth - 1) - 1], [n, 2, m]);

end

