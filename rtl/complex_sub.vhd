LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 复数减法器

ENTITY complex_sub IS 
	PORT(
		A_real, A_imag, B_real, B_imag: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_real, OUT_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY complex_sub ;

ARCHITECTURE bhv OF complex_sub IS
BEGIN
	OUT_real <= A_real - B_real;
	OUT_imag <= A_imag - B_imag;
END ARCHITECTURE bhv ;