LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_file IS
    PORT (
        data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        sel_in, sel_out1, sel_out2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        clk, wr_ena, reset : IN STD_LOGIC;
        data_out1, data_out2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));

END ENTITY;

ARCHITECTURE arc_register OF register_file IS

    TYPE custom_array IS ARRAY(7 DOWNTO 0) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL reg_out : custom_array;
    SIGNAL ena : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL data_out : STD_LOGIC_VECTOR(15 DOWNTO 0);

component my_register IS
    PORT (
        clk, ena, clr : IN STD_LOGIC;
        input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END component;

BEGIN
    GEN_REG :
    FOR i IN 0 TO 7 GENERATE
        REG : my_register
        PORT MAP(
            clk => clk, ena => ena(i),
           input=> data_in, output => reg_out(i), clr => reset);
    END GENERATE;

    in_decode : PROCESS (sel_in, wr_ena)
    BEGIN
        ena <= (OTHERS => '0');
        ena(to_integer(unsigned(sel_in))) <= wr_ena;
    END PROCESS;

    data_out1 <= reg_out(to_integer(unsigned(sel_out1)));
    data_out2 <= reg_out(to_integer(unsigned(sel_out2)));
END ARCHITECTURE;