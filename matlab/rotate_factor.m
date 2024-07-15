clc;
clear;

N = 8;
offset = 13;
W = zeros(N, 1);
W_16O = strings(N, 2);
for m = 0 : 3
    W(m + 1) = cos(2 * pi * m / N) - 1i * sin(2 * pi * m / N);
    W_16O(m + 1, 1) = dec2bin(real(W(m + 1)) * 2 ^ offset, 16);
    W_16O(m + 1, 2) = dec2bin(imag(W(m + 1)) * 2 ^ offset, 16);
end

