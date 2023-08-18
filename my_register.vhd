LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY my_register IS
    PORT (
        clk, ena, clr : IN STD_LOGIC;
        input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc_my_register OF my_register IS
BEGIN
    PROCESS (clk, clr)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF (ena = '1') THEN
                output<=input;
            END IF;
        END IF;
        IF (clr = '1') THEN
            output <= (OTHERS => '0');
        END IF;
    END PROCESS;

END ARCHITECTURE;

