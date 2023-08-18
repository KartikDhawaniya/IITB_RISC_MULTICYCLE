LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IITB_RISC2022 IS
    PORT (
        clk, rst : IN STD_LOGIC
    );
END ENTITY;

ARCHITECTURE arci OF IITB_RISC2022 IS
    SIGNAL state, nstate : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL pcw, tempw, irw, rfw, t1w, t2w, t3w, t4w, dmw, xw, zw, cw, aluZ : STD_LOGIC;
    SIGNAL aluin : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL cout, zout : STD_LOGIC;
    SIGNAL ins : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL func : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL control_in : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL t4 : STD_LOGIC;
    SIGNAL aluB : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL aluA : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL d3 : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL a3 : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL pc : STD_LOGIC_VECTOR (1 DOWNTO 0);

    COMPONENT datapath IS
        PORT (
            clk, rst, pcw, tempw, irw, rfw, t1w, t2w, t3w, t4w, dmw, xw, zw, cw, t4m : IN STD_LOGIC;
            pcm, a3m, d3m, aluAm, aluBm, aluin : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            cout, zout, aluZ : OUT STD_LOGIC;
            ins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            func : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT control IS
        PORT (
            control_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            t4 : OUT STD_LOGIC;
            aluB : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            aluA : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            d3 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            a3 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            pc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    data_inst : datapath
    PORT MAP(clk, rst, pcw, tempw, irw, rfw, t1w, t2w, t3w, t4w, dmw, xw, zw, cw, t4, pc, a3, d3, aluA, aluB, aluin, cout, zout, aluZ, ins, func);

    control_inst : control
    PORT MAP(state, t4, aluB, aluA, d3, a3, pc);

    PROCESS (clk, rst)
    BEGIN

        IF (rising_edge(clk)) THEN
            IF (rst = '1') THEN
                state <= "0000";
            ELSE
                state <= nstate;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (state)
    BEGIN

        IF (state = "0000") THEN
            t1w <= '0';
            t2w <= '0';
            t3w <= '0';
            t4w <= '0';
            aluin <= "00";
            IF (ins = "0100") THEN
                nstate <= "1001";
            ELSE
                nstate <= "0001";
                xw <= '1';
                tempw <= '1';
                irw <= '1';
                pcw <= '0';
                rfw <= '0';
                cw <= '0';
                zw <= '0';
                dmw <= '0';
            END IF;
        ELSIF (state = "0001") THEN
            xw <= '0';
            tempw <= '0';
            rfw <= '0';
            t1w <= '1';
            t2w <= '1';
            pcw <= '1';
            irw <= '0';
            dmw <= '0';
            irw <= '0';
            t4w <= '1';
            IF (ins = "0000" OR ins = "0001" OR ins = "0101" OR ins = "0111" OR ins = "0010" OR ins = "1010" OR ins = "1011") THEN
                t3w <= '0';
            ELSIF (ins = "1000" OR ins = "1001") THEN
                t3w <= '1';
            END IF;

            IF (ins = "0001" OR ins = "0010") THEN
                nstate <= "0010";
            ELSIF (ins = "0000") THEN
                nstate <= "0100";
            ELSIF (ins = "0101" OR ins = "0111") THEN
                nstate <= "0110";
            ELSIF (ins = "1001") THEN
                nstate <= "1000";
            ELSIF (ins = "1000") THEN
                nstate <= "1010";
            ELSIF (ins = "1010") THEN
                nstate <= "1011";
            ELSIF (ins = "1011") THEN
                nstate <= "1100";
            END IF;

        ELSIF (state = "1001") THEN
            rfw <= '1';
            irw <= '0';
            dmw <= '0';
            pcw <= '1';
            nstate <= "0000";
        ELSIF (state = "0010") THEN
            t3w <= '1';
            irw <= '0';
            dmw <= '0';
            pcw <= '0';
            rfw <= '0';
            IF (ins = "0001" AND func = "11") THEN
                aluin <= "11";
            ELSIF (ins = "0001") THEN
                aluin <= "00";
            ELSIF (ins = "0010") THEN
                aluin <= "01";
            END IF;

            IF ((func = "10" AND cout = '0') OR (func = "01" AND zout = '0')) THEN
                zw <= '0';
                cw <= '0';
            ELSE
                zw <= '1';
                cw <= '1';
            END IF;

            nstate <= "0011";
        ELSIF (state = "0100") THEN
            t1w <= '0';
            t3w <= '1';
            cw <= '1';
            zw <= '1';
            irw <= '0';
            dmw <= '0';
            pcw <= '0';
            rfw <= '0';
            aluin <= "00";
            nstate <= "0101";
        ELSIF (state = "0110") THEN
            t2w <= '0';
            t3w <= '1';
            zw <= '1';
            cw <= '0';
            irw <= '0';
            dmw <= '0';
            pcw <= '0';
            rfw <= '0';
            aluin <= "00";
            nstate <= "0111";
        ELSIF (state = "1010") THEN
            t1w <= '0';
            t2w <= '0';
            aluin <= "10";
            IF (aluZ = '1') THEN
                pcw <= '1';
            ELSE
                pcw <= '0';
                irw <= '0';
                dmw <= '0';
                rfw <= '0';
                nstate <= "0000";
            END IF;
        ELSIF (state = "1011") THEN
            t4w <= '0';
            rfw <= '1';
            t2w <= '0';
            pcw <= '1';
            irw <= '0';
            dmw <= '0';
            nstate <= "0000";
        ELSIF (state = "1100") THEN
            t1w <= '0';
            pcw <= '1';
            irw <= '0';
            dmw <= '0';
            rfw <= '0';
            aluin <= "00";
            nstate <= "0000";
        ELSIF (state = "0011") THEN
            IF ((func = "10" AND cout = '1') OR (func = "01" AND zout = '1') OR func = "00" OR func = "11") THEN
                rfw <= '1';
            ELSE
                rfw <= '0';
            END IF;
            t3w <= '0';
            irw <= '0';
            dmw <= '0';
            pcw <= '0';
            nstate <= "0000";
        ELSIF (state = "0101") THEN
            t3w <= '0';
            irw <= '0';
            dmw <= '0';
            pcw <= '0';
            rfw <= '1';
            nstate <= "0000";
        ELSIF (state = "0111") THEN
            t3w <= '0';
            irw <= '0';
            rfw <= '0';
            pcw <= '0';

            IF (ins = "0101") THEN
                t4w <= '1';
                dmw <= '0';
                nstate <= "1000";
            ELSIF (ins = "0111") THEN
                t4w <= '0';
                dmw <= '1';
                nstate <= "0000";
            END IF;
        ELSIF (state = "1000") THEN
            t4w <= '0';
            rfw <= '1';
            pcw <= '0';
            irw <= '0';
            dmw <= '0';
            nstate <= "0000";
        ELSE
            nstate <= "0000";
        END IF;

    END PROCESS;

END ARCHITECTURE;