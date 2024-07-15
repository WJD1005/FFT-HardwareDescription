LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY fft IS
	PORT(
		EN, CLK, RESET, INV: IN STD_LOGIC;
		I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
	
	-- 旋转因子常量（左移13位储存）
	CONSTANT W8_0_real: STD_LOGIC_VECTOR(15 DOWNTO 0) := "0010000000000000";
	CONSTANT W8_0_imag: STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	CONSTANT W8_1_real: STD_LOGIC_VECTOR(15 DOWNTO 0) := "0001011010100000";
	CONSTANT W8_1_imag: STD_LOGIC_VECTOR(15 DOWNTO 0) := "1110100101011111";
	CONSTANT W8_2_real: STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	CONSTANT W8_2_imag: STD_LOGIC_VECTOR(15 DOWNTO 0) := "1110000000000000";
	CONSTANT W8_3_real: STD_LOGIC_VECTOR(15 DOWNTO 0) := "1110100101011111";
	CONSTANT W8_3_imag: STD_LOGIC_VECTOR(15 DOWNTO 0) := "1110100101011111";
END ENTITY fft;

ARCHITECTURE fdl OF fft IS
	-- 八点蝶形运算模块
	COMPONENT butterfly8
		PORT(
			I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			W0_real, W1_real, W2_real, W3_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			W0_imag, W1_imag, W2_imag, W3_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
	-- 输入转换模块
	COMPONENT input_conv
		PORT(INV: IN STD_LOGIC;
			I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
	-- 输出转换模块
	COMPONENT output_conv
		PORT(INV: IN STD_LOGIC;
			I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
	-- 寄存器模块
	COMPONENT data_reg
		PORT(
			EN, CLK, CLR: IN STD_LOGIC;
			D0_real, D1_real, D2_real, D3_real, D4_real, D5_real, D6_real, D7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			D0_imag, D1_imag, D2_imag, D3_imag, D4_imag, D5_imag, D6_imag, D7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Q0_real, Q1_real, Q2_real, Q3_real, Q4_real, Q5_real, Q6_real, Q7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			Q0_imag, Q1_imag, Q2_imag, Q3_imag, Q4_imag, Q5_imag, Q6_imag, Q7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
	-- 连线信号
	SIGNAL ICI0_real, ICI1_real, ICI2_real, ICI3_real, ICI4_real, ICI5_real, ICI6_real, ICI7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ICI0_imag, ICI1_imag, ICI2_imag, ICI3_imag, ICI4_imag, ICI5_imag, ICI6_imag, ICI7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ICO0_real, ICO1_real, ICO2_real, ICO3_real, ICO4_real, ICO5_real, ICO6_real, ICO7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ICO0_imag, ICO1_imag, ICO2_imag, ICO3_imag, ICO4_imag, ICO5_imag, ICO6_imag, ICO7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L1I0_real, L1I1_real, L1I2_real, L1I3_real, L1I4_real, L1I5_real, L1I6_real, L1I7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L1I0_imag, L1I1_imag, L1I2_imag, L1I3_imag, L1I4_imag, L1I5_imag, L1I6_imag, L1I7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L1O0_real, L1O1_real, L1O2_real, L1O3_real, L1O4_real, L1O5_real, L1O6_real, L1O7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L1O0_imag, L1O1_imag, L1O2_imag, L1O3_imag, L1O4_imag, L1O5_imag, L1O6_imag, L1O7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L2I0_real, L2I1_real, L2I2_real, L2I3_real, L2I4_real, L2I5_real, L2I6_real, L2I7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L2I0_imag, L2I1_imag, L2I2_imag, L2I3_imag, L2I4_imag, L2I5_imag, L2I6_imag, L2I7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L2O0_real, L2O1_real, L2O2_real, L2O3_real, L2O4_real, L2O5_real, L2O6_real, L2O7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L2O0_imag, L2O1_imag, L2O2_imag, L2O3_imag, L2O4_imag, L2O5_imag, L2O6_imag, L2O7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L3I0_real, L3I1_real, L3I2_real, L3I3_real, L3I4_real, L3I5_real, L3I6_real, L3I7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L3I0_imag, L3I1_imag, L3I2_imag, L3I3_imag, L3I4_imag, L3I5_imag, L3I6_imag, L3I7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L3O0_real, L3O1_real, L3O2_real, L3O3_real, L3O4_real, L3O5_real, L3O6_real, L3O7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL L3O0_imag, L3O1_imag, L3O2_imag, L3O3_imag, L3O4_imag, L3O5_imag, L3O6_imag, L3O7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL OCI0_real, OCI1_real, OCI2_real, OCI3_real, OCI4_real, OCI5_real, OCI6_real, OCI7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL OCI0_imag, OCI1_imag, OCI2_imag, OCI3_imag, OCI4_imag, OCI5_imag, OCI6_imag, OCI7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL OCO0_real, OCO1_real, OCO2_real, OCO3_real, OCO4_real, OCO5_real, OCO6_real, OCO7_real: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL OCO0_imag, OCO1_imag, OCO2_imag, OCO3_imag, OCO4_imag, OCO5_imag, OCO6_imag, OCO7_imag: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
BEGIN
	-- 输入寄存器
	R1: data_reg PORT MAP(EN, CLK, RESET, I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real, I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag, ICI0_real, ICI1_real, ICI2_real, ICI3_real, ICI4_real, ICI5_real, ICI6_real, ICI7_real, ICI0_imag, ICI1_imag, ICI2_imag, ICI3_imag, ICI4_imag, ICI5_imag, ICI6_imag, ICI7_imag);
	
	-- 输入转换
	IN_COV: input_conv PORT MAP(INV, ICI0_real, ICI1_real, ICI2_real, ICI3_real, ICI4_real, ICI5_real, ICI6_real, ICI7_real, ICI0_imag, ICI1_imag, ICI2_imag, ICI3_imag, ICI4_imag, ICI5_imag, ICI6_imag, ICI7_imag, ICO0_real, ICO1_real, ICO2_real, ICO3_real, ICO4_real, ICO5_real, ICO6_real, ICO7_real, ICO0_imag, ICO1_imag, ICO2_imag, ICO3_imag, ICO4_imag, ICO5_imag, ICO6_imag, ICO7_imag);
	
	-- 流水寄存器
	R2: data_reg PORT MAP(EN, CLK, RESET, ICO0_real, ICO4_real, ICO2_real, ICO6_real, ICO1_real, ICO5_real, ICO3_real, ICO7_real, ICO0_imag, ICO4_imag, ICO2_imag, ICO6_imag, ICO1_imag, ICO5_imag, ICO3_imag, ICO7_imag, L1I0_real, L1I1_real, L1I2_real, L1I3_real, L1I4_real, L1I5_real, L1I6_real, L1I7_real, L1I0_imag, L1I1_imag, L1I2_imag, L1I3_imag, L1I4_imag, L1I5_imag, L1I6_imag, L1I7_imag);
	
	-- 一级运算
	L1: butterfly8 PORT MAP(L1I0_real, L1I1_real, L1I2_real, L1I3_real, L1I4_real, L1I5_real, L1I6_real, L1I7_real, L1I0_imag, L1I1_imag, L1I2_imag, L1I3_imag, L1I4_imag, L1I5_imag, L1I6_imag, L1I7_imag, W8_0_real, W8_0_real, W8_0_real, W8_0_real, W8_0_imag, W8_0_imag, W8_0_imag, W8_0_imag, L1O0_real, L1O1_real, L1O2_real, L1O3_real, L1O4_real, L1O5_real, L1O6_real, L1O7_real, L1O0_imag, L1O1_imag, L1O2_imag, L1O3_imag, L1O4_imag, L1O5_imag, L1O6_imag, L1O7_imag);
	
	-- 流水寄存器
	R3: data_reg PORT MAP(EN, CLK, RESET, L1O0_real, L1O1_real, L1O2_real, L1O3_real, L1O4_real, L1O5_real, L1O6_real, L1O7_real, L1O0_imag, L1O1_imag, L1O2_imag, L1O3_imag, L1O4_imag, L1O5_imag, L1O6_imag, L1O7_imag, L2I0_real, L2I1_real, L2I2_real, L2I3_real, L2I4_real, L2I5_real, L2I6_real, L2I7_real, L2I0_imag, L2I1_imag, L2I2_imag, L2I3_imag, L2I4_imag, L2I5_imag, L2I6_imag, L2I7_imag);
	
	-- 二级运算
	L2: butterfly8 PORT MAP(L2I0_real, L2I2_real, L2I1_real, L2I3_real, L2I4_real, L2I6_real, L2I5_real, L2I7_real, L2I0_imag, L2I2_imag, L2I1_imag, L2I3_imag, L2I4_imag, L2I6_imag, L2I5_imag, L2I7_imag, W8_0_real, W8_2_real, W8_0_real, W8_2_real, W8_0_imag, W8_2_imag, W8_0_imag, W8_2_imag, L2O0_real, L2O2_real, L2O1_real, L2O3_real, L2O4_real, L2O6_real, L2O5_real, L2O7_real, L2O0_imag, L2O2_imag, L2O1_imag, L2O3_imag, L2O4_imag, L2O6_imag, L2O5_imag, L2O7_imag);
	
	-- 流水寄存器
	R4: data_reg PORT MAP(EN, CLK, RESET, L2O0_real, L2O1_real, L2O2_real, L2O3_real, L2O4_real, L2O5_real, L2O6_real, L2O7_real, L2O0_imag, L2O1_imag, L2O2_imag, L2O3_imag, L2O4_imag, L2O5_imag, L2O6_imag, L2O7_imag, L3I0_real, L3I1_real, L3I2_real, L3I3_real, L3I4_real, L3I5_real, L3I6_real, L3I7_real, L3I0_imag, L3I1_imag, L3I2_imag, L3I3_imag, L3I4_imag, L3I5_imag, L3I6_imag, L3I7_imag);
	
	-- 三级运算
	L3: butterfly8 PORT MAP(L3I0_real, L3I4_real, L3I1_real, L3I5_real, L3I2_real, L3I6_real, L3I3_real, L3I7_real, L3I0_imag, L3I4_imag, L3I1_imag, L3I5_imag, L3I2_imag, L3I6_imag, L3I3_imag, L3I7_imag, W8_0_real, W8_1_real, W8_2_real, W8_3_real, W8_0_imag, W8_1_imag, W8_2_imag, W8_3_imag, L3O0_real, L3O4_real, L3O1_real, L3O5_real, L3O2_real, L3O6_real, L3O3_real, L3O7_real, L3O0_imag, L3O4_imag, L3O1_imag, L3O5_imag, L3O2_imag, L3O6_imag, L3O3_imag, L3O7_imag);
	
	-- 流水寄存器
	R5: data_reg PORT MAP(EN, CLK, RESET, L3O0_real, L3O1_real, L3O2_real, L3O3_real, L3O4_real, L3O5_real, L3O6_real, L3O7_real, L3O0_imag, L3O1_imag, L3O2_imag, L3O3_imag, L3O4_imag, L3O5_imag, L3O6_imag, L3O7_imag, OCI0_real, OCI1_real, OCI2_real, OCI3_real, OCI4_real, OCI5_real, OCI6_real, OCI7_real, OCI0_imag, OCI1_imag, OCI2_imag, OCI3_imag, OCI4_imag, OCI5_imag, OCI6_imag, OCI7_imag);
	
	-- 输出转换
	OUT_COV: output_conv PORT MAP(INV, OCI0_real, OCI1_real, OCI2_real, OCI3_real, OCI4_real, OCI5_real, OCI6_real, OCI7_real, OCI0_imag, OCI1_imag, OCI2_imag, OCI3_imag, OCI4_imag, OCI5_imag, OCI6_imag, OCI7_imag, OCO0_real, OCO1_real, OCO2_real, OCO3_real, OCO4_real, OCO5_real, OCO6_real, OCO7_real, OCO0_imag, OCO1_imag, OCO2_imag, OCO3_imag, OCO4_imag, OCO5_imag, OCO6_imag, OCO7_imag);
	
	-- 输出寄存器
	R6: data_reg PORT MAP(EN, CLK, RESET, OCO0_real, OCO1_real, OCO2_real, OCO3_real, OCO4_real, OCO5_real, OCO6_real, OCO7_real, OCO0_imag, OCO1_imag, OCO2_imag, OCO3_imag, OCO4_imag, OCO5_imag, OCO6_imag, OCO7_imag, O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real, O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag);
	
	
END ARCHITECTURE fdl;