LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY datapath IS
    PORT (
        clk, rst, pcw, tempw, irw, rfw, t1w, t2w, t3w, t4w, dmw, xw, zw, cw, t4m : IN STD_LOGIC;
        pcm, a3m, d3m, aluAm, aluBm, aluin : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        cout, zout, aluZ : OUT STD_LOGIC;
        ins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        func : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arci OF datapath IS

    COMPONENT muxe_2bit IS
        PORT (
            input1, input2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
            flag : IN STD_LOGIC;
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    COMPONENT muxe_3bit IS
        PORT (
            input1, input2, input3, input4 : IN STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
            flag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
    END COMPONENT;
    COMPONENT my_register IS
        PORT (
            clk, ena, clr : IN STD_LOGIC;
            input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    COMPONENT register_file IS
        PORT (
            data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            sel_in, sel_out1, sel_out2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            clk, wr_ena, reset : IN STD_LOGIC;
            data_out1, data_out2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));

    END COMPONENT;

    COMPONENT ram IS
        PORT (
            addr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            en_wr : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT alu IS
        PORT (
            inp1, inp2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            carry, zero : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT sign_extend6bit IS
        PORT (
            inp : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    COMPONENT sign_extend9bit IS
        PORT (
            inp : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    COMPONENT left_shift7bit IS
        PORT (
            input : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    COMPONENT muxe_4bit IS
        PORT (
            input1, input2, input3, input4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
            flag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    COMPONENT my_register1bit IS
        PORT (
            clk, ena, clr : IN STD_LOGIC;
            input : IN STD_LOGIC;
            output : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL pcin, pcout, tempin, tempout, imout, irout, ls7out, t1out, t2out, t4out, t3out, d3in, d1out, d2out, x6out, x9out, xout, aluAin, aluBin, dmout, t4in, t3in : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL a3in : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL cin, zin, tc, tz : STD_LOGIC;

BEGIN

    pc_reg : my_register
    PORT MAP(clk, pcw, rst, pcin, pcout);

    temp_reg : my_register
    PORT MAP(clk, tempw, rst, tempin, tempout);

    im : ram
    PORT MAP(pcout, "0000000000000000", '0', clk, imout);

    ir_reg : my_register
    PORT MAP(clk, irw, rst, imout, irout);

    ins <= irout(15 DOWNTO 12);

    func <= irout(1 DOWNTO 0);

    a3muxe : muxe_3bit
    PORT MAP(irout(8 DOWNTO 6), irout(5 DOWNTO 3), irout(11 DOWNTO 9), "000", a3m, a3in);

    d3muxe : muxe_4bit
    PORT MAP(ls7out, t4out, t3out, "0000000000000000", d3m, d3in);

    reg : register_file
    PORT MAP(d3in, a3in, irout(11 DOWNTO 9), irout(8 DOWNTO 6), clk, rfw, rst, d1out, d2out);

    l7shift : left_shift7bit
    PORT MAP(irout(8 DOWNTO 0), ls7out);

    extend6bit : sign_extend6bit
    PORT MAP(irout(5 DOWNTO 0), x6out);

    extend9bit : sign_extend9bit
    PORT MAP(irout(8 DOWNTO 0), x9out);

    t1reg : my_register
    PORT MAP(clk, t1w, rst, d1out, t1out);

    t2reg : my_register
    PORT MAP(clk, t2w, rst, d2out, t2out);

    aluAmuxe : muxe_4bit
    PORT MAP(xout, t1out, x6out, "0000000000000000", aluAm, aluAin);

    aluBmuxe : muxe_4bit
    PORT MAP(x9out, t2out, x6out, "0000000000000000", aluBm, aluBin);

    main_alu : alu
    PORT MAP(aluAin, aluBin, aluin, t3in, cin, zin);

    aluZ <= zin;

    xreg : my_register
    PORT MAP(clk, xw, rst, pcout, xout);

    creg : my_register1bit
    PORT MAP(clk, cw, rst, cin, cout);

    zreg : my_register1bit
    PORT MAP(clk, zw, rst, zin, zout);

    dm : ram
    PORT MAP(t3out, t1out, dmw, clk, dmout);

    t4muxe : muxe_2bit
    PORT MAP(dmout, pcout, t4m, t4in);

    t4reg : my_register
    PORT MAP(clk, t4w, rst, t4in, t4out);

    t3reg : my_register
    PORT MAP(clk, t3w, rst, t3in, t3out);

    asm_alu : alu
    PORT MAP(pcout, "0000000000000001", "00", tempin, tc, tz);

    pc_muxe : muxe_4bit
    PORT MAP(tempout, t3out, t2out, t3in, pcm, pcin);

END ARCHITECTURE;