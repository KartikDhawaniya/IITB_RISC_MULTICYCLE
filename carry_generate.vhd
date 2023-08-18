LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY carry_generate IS
	PORT (
		p, g : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		cin : IN STD_LOGIC;
		cout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc_carry_generate OF carry_generate IS
	SIGNAL c : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
	c(0) <= cin;
	logic :
	FOR i IN 1 TO 4 GENERATE
		c(i) <= g(i - 1) OR (p(i - 1) AND c(i - 1));
	END GENERATE;

	cout <= c(4 DOWNTO 1);
END ARCHITECTURE;