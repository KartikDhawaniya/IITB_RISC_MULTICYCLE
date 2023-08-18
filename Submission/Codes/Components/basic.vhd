-- Title				: Basic Logic Components 
-- Purpose				:
-- Brief Description	:
-- Author				: Shashank OV
-- Date					: Apr. 11, 2016 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package basic is
		component clk_divider is
		generic(ratio: integer := 5);
		port(
			clk_in: in std_logic;
			clk_out: out std_logic);		
	end component;
	
	component my_reg is
	generic ( data_width : integer);
	port(
		clk, ena, clr: in std_logic;
		Din: in std_logic_vector(data_width-1 downto 0);
		Dout: out std_logic_vector(data_width-1 downto 0));
	end component;

	component adder2Bit is
		port(
			a0, a1, b0, b1, c0: in std_logic;	--input pins
			s0, s1, c2: out std_logic);	--output pins
	end component;

	component adder8Bit is
		port(
			A, B: in std_logic_vector(7 downto 0);	--input numbers to be added
			S: out std_logic_vector(7 downto 0);	--result
			c0: in std_logic;	--input carry
			c8: out std_logic);	--ouput carry
	end component;

	component Sub16 is	--subtracter
		port(
			A, B: in std_logic_vector(15 downto 0);	--input numbers
			S: out std_logic_vector(15 downto 0);	--output result
			c16: out std_logic);	-- output overflow/carry
	end component;

	component equal_to is
		generic ( data_width : integer := 16);
		port (
			A, B: in std_logic_vector(data_width-1 downto 0);
			R: out std_logic);
	end component;
	
	component greater_than is
	generic ( data_width : integer := 16);
	port (
		A, B: in std_logic_vector(data_width-1 downto 0);
		R: out std_logic);
	end component;
	
	component decr4 is
	port(
		A : in std_logic_vector(3 downto 0);
		B : out std_logic_vector(3 downto 0));
	end component;

	component mux4 is
		generic(input_width: integer := 16);
		port(
			inp1, inp2, inp3, inp4: in std_logic_vector(input_width-1 downto 0) := (others => '0');
			sel: in std_logic_vector(1 downto 0);
			output: out std_logic_vector(input_width-1 downto 0));
	end component;

	component mux8 is
		generic(input_width: integer := 16);
		port(
			inp1, inp2, inp3, inp4, inp5, inp6, inp7, inp8: in std_logic_vector(input_width-1 downto 0) := (others => '0');
			sel: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(input_width-1 downto 0));
	end component;

end package;

	
	 	






	









