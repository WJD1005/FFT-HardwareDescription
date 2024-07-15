LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 输出转换模块，用于在逆变换时对输出取共轭并除以8

ENTITY output_conv IS
	PORT(
		INV: IN STD_LOGIC;
		I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ENTITY output_conv;

ARCHITECTURE bhv OF output_conv IS
BEGIN
	PROCESS(INV, I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real, I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag)
		VARIABLE temp: std_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0'); 
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
			-- 逆变换实部右移三位输出
		   O0_real(11 downto 0) <= I0_real(14 downto 3);
			O0_real(15 downto 12) <= (others => I0_real(15));
			O1_real(11 downto 0) <= I1_real(14 downto 3);
			O1_real(15 downto 12) <= (others => I1_real(15));
			O2_real(11 downto 0) <= I2_real(14 downto 3);
			O2_real(15 downto 12) <= (others => I2_real(15));
			O3_real(11 downto 0) <= I3_real(14 downto 3);
			O3_real(15 downto 12) <= (others => I3_real(15));
			O4_real(11 downto 0) <= I4_real(14 downto 3);
			O4_real(15 downto 12) <= (others => I4_real(15));
			O5_real(11 downto 0) <= I5_real(14 downto 3);
			O5_real(15 downto 12) <= (others => I5_real(15));
			O6_real(11 downto 0) <= I6_real(14 downto 3);
			O6_real(15 downto 12) <= (others => I6_real(15));
			O7_real(11 downto 0) <= I7_real(14 downto 3);
			O7_real(15 downto 12) <= (others => I7_real(15));
			
			-- 虚部取相反数右移三位输出
		   temp := (NOT I0_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O0_imag <= temp;
			temp := (NOT I1_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O1_imag <= temp;
			temp := (NOT I2_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O2_imag <= temp;
			temp := (NOT I3_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O3_imag <= temp;
			temp := (NOT I4_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O4_imag <= temp;
			temp := (NOT I5_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O5_imag <= temp;
			temp := (NOT I6_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O6_imag <= temp;
			temp := (NOT I7_imag) + 1;
			temp(11 downto 0) := temp(14 downto 3);
			temp(14 downto 12) := (others => temp(15));
			O7_imag <= temp;
		END IF; 
	END PROCESS;
END ARCHITECTURE bhv;