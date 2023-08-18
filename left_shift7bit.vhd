LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY left_shift7bit IS
    PORT (
        input : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc OF left_shift7bit IS
BEGIN

    output(15 DOWNTO 7) <= input(8 downto 0);
	 output(6 downto 0)<="0000000";

END ARCHITECTURE;