LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY full_adder1bit IS
    PORT (
        a, b, c : IN STD_LOGIC;
        carry, s : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE full_adder1bit OF full_adder1bit IS

BEGIN
    s <= a XOR b XOR c;
    carry <= (((a AND b) OR (a AND c)) OR (c AND b));
END ARCHITECTURE;