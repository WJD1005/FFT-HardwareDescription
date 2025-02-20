LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

-- 复数乘法器

ENTITY complex_mult IS
	PORT(
		A_real, A_imag, B_real, B_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      OUT_real, OUT_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY complex_mult ;

ARCHITECTURE bhv OF complex_mult IS 
BEGIN 
	OUT_real <= (signed(A_real) * signed(B_real) - signed(A_imag) * signed(B_imag));
	OUT_imag <= (signed(A_real) * signed(B_imag) + signed(A_imag) * signed(B_real));
END ARCHITECTURE bhv ;