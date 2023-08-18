LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
    PORT (
        inp1, inp2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        carry, zero : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE arc_alu OF alu IS
    SIGNAL output_temp : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL output_add : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL output_sub : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inp_temp : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL C : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL csub : STD_LOGIC;

    COMPONENT adder IS
        PORT (
            A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            cin : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            cout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    COMPONENT sub_16bit IS
        PORT (
            A, B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            carry : OUT STD_LOGIC);
    END COMPONENT;

BEGIN

    adder_element : adder
    PORT MAP(inp_temp, inp2, '0', output_add, C);
    subtract_element : sub_16bit
    PORT MAP(inp1, inp2, output_sub, csub);

    PROCESS (inp1, inp2, sel, output_add)
    BEGIN
        IF sel = "00" THEN
            inp_temp <= inp1;
            output_temp <= output_add;
            carry <= C(15);
        ELSIF sel = "01" THEN
            output_temp <= inp1 NAND inp2;
            carry <= '0';
        ELSIF sel = "10" THEN
            output_temp <= output_sub;
            carry <= '0';
        ELSE
            inp_temp(15 DOWNTO 1) <= inp1(14 DOWNTO 0);
            inp_temp(0) <= '0';
            output_temp <= output_add;
            carry <= '0';
        END IF;
    END PROCESS;

    zero <= '1' WHEN (to_integer(unsigned(output_temp)) = 0) ELSE
        '0';
    output <= output_temp;
END ARCHITECTURE;