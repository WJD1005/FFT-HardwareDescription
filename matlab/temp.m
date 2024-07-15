a = 2468 + 1j * 2468;
a = repmat(a, 8, 1);
r = fft(a, 8)