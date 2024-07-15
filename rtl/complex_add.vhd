LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 复数加法器

ENTITY complex_add IS 
	PORT(
		A_real, A_imag, B_real, B_imag: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_real, OUT_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY complex_add;

ARCHITECTURE bhv OF complex_add IS
BEGIN 
	OUT_real <= A_real + B_real;  
	OUT_imag <= A_imag + B_imag;
END ARCHITECTURE bhv ;