LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY add_2bit IS
    PORT (
        a0, a1, b0, b1, c0 : IN STD_LOGIC;
        s0, s1, c2 : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE arc OF add_2bit IS
    SIGNAL c1 : STD_LOGIC;
    COMPONENT full_adder1bit IS
        PORT (
            a, b, c : IN STD_LOGIC;
            carry, s : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    inst1 : full_adder1bit PORT MAP(a0, b0, c0, c1, s0);
    inst2 : full_adder1bit PORT MAP(a1, b1, c1, c2, s1);
END ARCHITECTURE;