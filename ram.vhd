LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ram IS
    PORT (
        addr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        en_wr : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE access1 OF ram IS
    TYPE ram_arr IS ARRAY (65535 DOWNTO 0) OF STD_LOGIC_VECTOR (15 DOWNTO 0);

    SIGNAL ram_mem : ram_arr := (OTHERS => x"0000");

BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk) AND en_wr = '1') THEN
            ram_mem(to_integer(unsigned(addr))) <= data_in;
        END IF;
    END PROCESS;

    data_out <= ram_mem(to_integer(unsigned(addr)));
END ARCHITECTURE;