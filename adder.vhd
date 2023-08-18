LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY adder IS
	PORT (
		A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

		cin : IN STD_LOGIC;
		S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc_adder OF adder IS
	SIGNAL C : STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL P, G : STD_LOGIC_VECTOR(15 DOWNTO 0);

	COMPONENT full_adder IS
		PORT (
			a, b, cin : IN STD_LOGIC;
			s, p, g : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT carry_generate IS
		PORT (
			p, g : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			cin : IN STD_LOGIC;
			cout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT;

BEGIN

	C(0) <= cin;

	sum_element :
	FOR i IN 0 TO 15 GENERATE
		fulladder : full_adder
		PORT MAP(A(i), B(i), C(i), S(i), P(i), G(i));
	END GENERATE;

	carry_element :
	FOR i IN 0 TO 3 GENERATE
		carrygenerate : carry_generate
		PORT MAP(P(i * 4 + 3 DOWNTO i * 4), G(i * 4 + 3 DOWNTO i * 4), C(i * 4), C(i * 4 + 4 DOWNTO i * 4 + 1));
	END GENERATE;

	cout <= C(16 DOWNTO 1);
END arc_adder;