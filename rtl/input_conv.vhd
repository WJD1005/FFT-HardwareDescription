LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 输入转换模块，对输入取共轭

ENTITY input_conv IS
	PORT(
		INV: IN STD_LOGIC;
		I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ENTITY input_conv;

ARCHITECTURE bhv OF input_conv IS
BEGIN
	PROCESS(INV, I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real, I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag)
	BEGIN 
		IF(INV = '0') THEN
			-- 正变换直接输出
			O0_real <= I0_real;
			O1_real <= I1_real;
			O2_real <= I2_real;
			O3_real <= I3_real;
			O4_real <= I4_real;
			O5_real <= I5_real;
			O6_real <= I6_real;
			O7_real <= I7_real;
			O0_imag <= I0_imag;
			O1_imag <= I1_imag;
			O2_imag <= I2_imag;
			O3_imag <= I3_imag;
			O4_imag <= I4_imag;
			O5_imag <= I5_imag;
			O6_imag <= I6_imag;
			O7_imag <= I7_imag;
		ELSE
			-- 逆变换实部直接输出，虚部取相反数
			O0_real <= I0_real;
			O1_real <= I1_real;
			O2_real <= I2_real;
			O3_real <= I3_real;
			O4_real <= I4_real;
			O5_real <= I5_real;
			O6_real <= I6_real;
			O7_real <= I7_real;
			O0_imag <= (NOT I0_imag) + 1;
			O1_imag <= (NOT I1_imag) + 1;
			O2_imag <= (NOT I2_imag) + 1;
			O3_imag <= (NOT I3_imag) + 1; 
			O4_imag <= (NOT I4_imag) + 1;
			O5_imag <= (NOT I5_imag) + 1;
			O6_imag <= (NOT I6_imag) + 1;
			O7_imag <= (NOT I7_imag) + 1;
		END IF;
	END PROCESS;
END ARCHITECTURE bhv;