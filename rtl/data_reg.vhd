LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- 寄存器模块

ENTITY data_reg IS
	PORT(
		EN, CLK, CLR: IN STD_LOGIC;
		D0_real, D1_real, D2_real, D3_real, D4_real, D5_real, D6_real, D7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		D0_imag, D1_imag, D2_imag, D3_imag, D4_imag, D5_imag, D6_imag, D7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Q0_real, Q1_real, Q2_real, Q3_real, Q4_real, Q5_real, Q6_real, Q7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		Q0_imag, Q1_imag, Q2_imag, Q3_imag, Q4_imag, Q5_imag, Q6_imag, Q7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ENTITY data_reg;

ARCHITECTURE bhv OF data_reg IS
BEGIN
	PROCESS(EN, CLK, CLR, D0_real, D1_real, D2_real, D3_real, D4_real, D5_real, D6_real, D7_real, D0_imag, D1_imag, D2_imag, D3_imag, D4_imag, D5_imag, D6_imag, D7_imag) BEGIN
		IF (CLR = '1') THEN
			Q0_real <= (OTHERS => '0');
			Q1_real <= (OTHERS => '0');
			Q2_real <= (OTHERS => '0');
			Q3_real <= (OTHERS => '0');
			Q4_real <= (OTHERS => '0');
			Q5_real <= (OTHERS => '0');
			Q6_real <= (OTHERS => '0');
			Q7_real <= (OTHERS => '0');
			Q0_imag <= (OTHERS => '0');
			Q1_imag <= (OTHERS => '0');
			Q2_imag <= (OTHERS => '0');
			Q3_imag <= (OTHERS => '0');
			Q4_imag <= (OTHERS => '0');
			Q5_imag <= (OTHERS => '0');
			Q6_imag <= (OTHERS => '0');
			Q7_imag <= (OTHERS => '0');
		ELSIF RISING_EDGE(CLK) THEN 
			IF (EN = '1') THEN
				Q0_real <= D0_real;
				Q1_real <= D1_real;
				Q2_real <= D2_real;
				Q3_real <= D3_real;
				Q4_real <= D4_real;
				Q5_real <= D5_real;
				Q6_real <= D6_real;
				Q7_real <= D7_real;
				Q0_imag <= D0_imag;
				Q1_imag <= D1_imag;
				Q2_imag <= D2_imag;
				Q3_imag <= D3_imag;
				Q4_imag <= D4_imag;
				Q5_imag <= D5_imag;
				Q6_imag <= D6_imag;
				Q7_imag <= D7_imag;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE bhv;