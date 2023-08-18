LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sign_extend6bit IS
    PORT (
        inp : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc_signextend OF sign_extend6bit IS
BEGIN

    output(5 DOWNTO 0) <= inp;

    padding :
    FOR i IN 6 TO 15 GENERATE
        output(i) <= inp(5);
    END GENERATE;

END ARCHITECTURE;
