LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY muxe_2bit IS
    PORT (
        input1, input2: IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
        flag : IN STD_LOGIC;
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE arc OF muxe_2bit IS
BEGIN
    output <= input1 WHEN (flag = '0') ELSE
        input2;
END architecture;