LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 单级运算模块

ENTITY butterfly8 IS
	GENERIC(OFFSET: INTEGER := 13);  -- 旋转因子左移位数，在计算时也需偏移来保持数值计算正确，根据精度和范围需求调整，同时需要修改旋转因子储存值
	PORT(
		I0_real, I1_real, I2_real, I3_real, I4_real, I5_real, I6_real, I7_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		I0_imag, I1_imag, I2_imag, I3_imag, I4_imag, I5_imag, I6_imag, I7_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		W0_real, W1_real, W2_real, W3_real: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		W0_imag, W1_imag, W2_imag, W3_imag: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_real, O1_real, O2_real, O3_real, O4_real, O5_real, O6_real, O7_real: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		O0_imag, O1_imag, O2_imag, O3_imag, O4_imag, O5_imag, O6_imag, O7_imag: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ENTITY butterfly8;

ARCHITECTURE fdl OF butterfly8 IS
	-- 两点蝶形运算模块
	COMPONENT butterfly2
		PORT(
			I1_real,I1_imag:IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			I2_real,W_real,I2_imag,W_imag:IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			O1_real,O1_imag,O2_real,O2_imag:OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	-- 运算中间移位变量
	SIGNAL Ib0_real, Ib2_real, Ib4_real, Ib6_real: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');  -- 蝶形运算中A扩展到32位左移OFFSET
	SIGNAL Ib0_imag, Ib2_imag, Ib4_imag, Ib6_imag: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');  -- 蝶形运算中A扩展到32位左移OFFSET
	SIGNAL Ob0_real, Ob1_real, Ob2_real, Ob3_real, Ob4_real, Ob5_real, Ob6_real, Ob7_real: STD_LOGIC_VECTOR(31 DOWNTO 0);  -- 两点蝶形运算结果
	SIGNAL Ob0_imag, Ob1_imag, Ob2_imag, Ob3_imag, Ob4_imag, Ob5_imag, Ob6_imag, Ob7_imag: STD_LOGIC_VECTOR(31 DOWNTO 0);  -- 两点蝶形运算结果

BEGIN
	-- 对A扩展到32位并左移OFFSET位
	Ib0_real(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I0_real(15));  -- 位数扩展方法是高位补符号位，考虑到还要移位所以只需补一部分即可
	Ib0_real((OFFSET + 15) DOWNTO OFFSET) <= I0_real(15 DOWNTO 0);  -- 将原16位放在左移OFFSET位后的位置，后面低位全为0（由初始值实现）
	Ib0_imag(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I0_imag(15));
	Ib0_imag((OFFSET + 15) DOWNTO OFFSET) <= I0_imag(15 DOWNTO 0);
	Ib2_real(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I2_real(15));
	Ib2_real((OFFSET + 15) DOWNTO OFFSET) <= I2_real(15 DOWNTO 0);
	Ib2_imag(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I2_imag(15));
	Ib2_imag((OFFSET + 15) DOWNTO OFFSET) <= I2_imag(15 DOWNTO 0);
	Ib4_real(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I4_real(15));
	Ib4_real((OFFSET + 15) DOWNTO OFFSET) <= I4_real(15 DOWNTO 0);
	Ib4_imag(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I4_imag(15));
	Ib4_imag((OFFSET + 15) DOWNTO OFFSET) <= I4_imag(15 DOWNTO 0);
	Ib6_real(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I6_real(15));
	Ib6_real((OFFSET + 15) DOWNTO OFFSET) <= I6_real(15 DOWNTO 0);
	Ib6_imag(31 DOWNTO (OFFSET + 16)) <= (OTHERS => I6_imag(15));
	Ib6_imag((OFFSET + 15) DOWNTO OFFSET) <= I6_imag(15 DOWNTO 0);
	
	-- 进行八点蝶形运算
	b1: butterfly2 PORT MAP(I1_real => Ib0_real, I1_imag => Ib0_imag, I2_real => I1_real, I2_imag => I1_imag, W_real => W0_real, W_imag => W0_imag, O1_real => Ob0_real, O1_imag => Ob0_imag, O2_real => Ob1_real, O2_imag => Ob1_imag);
	b2: butterfly2 PORT MAP(I1_real => Ib2_real, I1_imag => Ib2_imag, I2_real => I3_real, I2_imag => I3_imag, W_real => W1_real, W_imag => W1_imag, O1_real => Ob2_real, O1_imag => Ob2_imag, O2_real => Ob3_real, O2_imag => Ob3_imag);
	b3: butterfly2 PORT MAP(I1_real => Ib4_real, I1_imag => Ib4_imag, I2_real => I5_real, I2_imag => I5_imag, W_real => W2_real, W_imag => W2_imag, O1_real => Ob4_real, O1_imag => Ob4_imag, O2_real => Ob5_real, O2_imag => Ob5_imag);
	b4: butterfly2 PORT MAP(I1_real => Ib6_real, I1_imag => Ib6_imag, I2_real => I7_real, I2_imag => I7_imag, W_real => W3_real, W_imag => W3_imag, O1_real => Ob6_real, O1_imag => Ob6_imag, O2_real => Ob7_real, O2_imag => Ob7_imag);
	
	-- 计算结果右移OFFSET位并转16位变为正确数值大小并输出
	O0_real(15 DOWNTO 0) <= Ob0_real((OFFSET + 15) DOWNTO OFFSET);  -- 直接截取右移OFFSET位后低16位对应的原32位位置数据即可
	O0_imag(15 DOWNTO 0) <= Ob0_imag((OFFSET + 15) DOWNTO OFFSET);
	O1_real(15 DOWNTO 0) <= Ob1_real((OFFSET + 15) DOWNTO OFFSET);
   O1_imag(15 DOWNTO 0) <= Ob1_imag((OFFSET + 15) DOWNTO OFFSET);
	O2_real(15 DOWNTO 0) <= Ob2_real((OFFSET + 15) DOWNTO OFFSET);
	O2_imag(15 DOWNTO 0) <= Ob2_imag((OFFSET + 15) DOWNTO OFFSET);
	O3_real(15 DOWNTO 0) <= Ob3_real((OFFSET + 15) DOWNTO OFFSET);
	O3_imag(15 DOWNTO 0) <= Ob3_imag((OFFSET + 15) DOWNTO OFFSET);
	O4_real(15 DOWNTO 0) <= Ob4_real((OFFSET + 15) DOWNTO OFFSET);
	O4_imag(15 DOWNTO 0) <= Ob4_imag((OFFSET + 15) DOWNTO OFFSET);
	O5_real(15 DOWNTO 0) <= Ob5_real((OFFSET + 15) DOWNTO OFFSET);
	O5_imag(15 DOWNTO 0) <= Ob5_imag((OFFSET + 15) DOWNTO OFFSET);
	O6_real(15 DOWNTO 0) <= Ob6_real((OFFSET + 15) DOWNTO OFFSET);
	O6_imag(15 DOWNTO 0) <= Ob6_imag((OFFSET + 15) DOWNTO OFFSET);
	O7_real(15 DOWNTO 0) <= Ob7_real((OFFSET + 15) DOWNTO OFFSET);
	O7_imag(15 DOWNTO 0) <= Ob7_imag((OFFSET + 15) DOWNTO OFFSET);
	
END ARCHITECTURE fdl;
