LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY control IS
    PORT (
        control_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        t4 : OUT STD_LOGIC;
        aluB : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        aluA : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        d3 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        a3 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        pc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );

END ENTITY;

ARCHITECTURE control_arch OF control IS
BEGIN

    t4 <= NOT control_in(2);
    aluB(0) <= control_in(1);
    aluB(1) <= NOT control_in(3) AND NOT control_in(1);
    aluA(0) <= (NOT control_in(2) AND NOT control_in(0)) OR (NOT control_in(1) AND NOT control_in(0));
    aluA(1) <= control_in(2) AND control_in(1);
    d3(0) <= NOT control_in(0) OR (control_in(1) AND control_in(3));
    d3(1) <= NOT control_in(3);
    a3(0) <= NOT control_in(3) AND NOT control_in(2);
    a3(1) <= control_in(3);
    pc(0) <= NOT control_in(0);
    pc(1) <= control_in(2) OR (control_in(0) AND control_in(1));

END control_arch;