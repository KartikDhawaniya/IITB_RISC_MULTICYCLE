LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sign_extend9bit IS
    PORT (
        inp : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc_signextend OF sign_extend9bit IS
BEGIN

    output(8 DOWNTO 0) <= inp;

    padding :
    FOR i IN 9 TO 15 GENERATE
        output(i) <= inp(8);
    END GENERATE;

END ARCHITECTURE;
