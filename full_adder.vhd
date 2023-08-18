LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY full_adder IS
	PORT (
		a, b, cin : IN STD_LOGIC;
		s, p, g : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE arc_full_adder OF full_adder IS
BEGIN

	g <= a AND b;
	p <= a OR b;
	s <= a XOR b XOR cin;

END ARCHITECTURE;