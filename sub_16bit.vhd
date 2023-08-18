LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sub_16bit IS
    PORT (
        A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        carry : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE arc OF sub_16bit IS
    SIGNAL notB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL cint : STD_LOGIC;
    COMPONENT add_8bit IS
        PORT (
            A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            c0 : IN STD_LOGIC;
            c8 : OUT STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;
BEGIN

    notB <= NOT B;
    adder1 : add_8bit PORT MAP(A(7 DOWNTO 0), notB(7 DOWNTO 0), '1', cint, S(7 DOWNTO 0));
    adder2 : add_8bit PORT MAP(A(15 DOWNTO 8), notB(15 DOWNTO 8), cint, carry, S(15 DOWNTO 8));

END ARCHITECTURE;