LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- 蝶形运算单元

ENTITY butterfly2 IS
	PORT(
		I1_real, I1_imag: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		I2_real, W_real, I2_imag, W_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      O1_real, O1_imag, O2_real, O2_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY butterfly2;

ARCHITECTURE bhv OF butterfly2 IS
	-- 复数乘法器
	component complex_mult
		PORT (
			A_real, A_imag, B_real, B_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			OUT_real, OUT_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END component;
	
	-- 复数加法器
	component complex_add
		PORT (
			A_real, A_imag, B_real, B_imag: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_real, OUT_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END component;
	
	-- 复数减法器
	component complex_sub
		PORT (
			A_real, A_imag, B_real, B_imag: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_real, OUT_imag: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END component;

	SIGNAL net1, net2: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	u1 : complex_mult PORT MAP(A_real => I2_real, A_imag => I2_imag, B_real => W_real, B_imag => W_imag, OUT_real => net1, OUT_imag => net2);
	u2 : complex_add  PORT MAP(A_real => I1_real, A_imag => I1_imag, B_real => net1, B_imag => net2, OUT_real => O1_real, OUT_imag => O1_imag);
	u3 : complex_sub  PORT MAP(A_real => I1_real, A_imag => I1_imag, B_real => net1, B_imag => net2, OUT_real => O2_real, OUT_imag => O2_imag);
END ARCHITECTURE bhv;
