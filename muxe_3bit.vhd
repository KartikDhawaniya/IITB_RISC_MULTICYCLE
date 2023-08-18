LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY muxe_3bit IS
    PORT (
        input1, input2, input3, input4 : IN STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
        flag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc OF muxe_3bit IS
BEGIN
    output <= input1 WHEN (flag = "00") ELSE
        input2 WHEN (flag = "01") ELSE
        input3 WHEN (flag = "10") ELSE
        input4;
END architecture;