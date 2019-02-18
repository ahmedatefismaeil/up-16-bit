----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:18:23 02/01/2019 
-- Design Name: 
-- Module Name:    full_mips - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_mips is
    Port ( reset    : in   STD_LOGIC;
           clk      : in   STD_LOGIC;
           in_port  : in   STD_LOGIC_VECTOR (15 downto 0);
           out_port : out  STD_LOGIC_VECTOR (15 downto 0);
           run      : out  STD_LOGIC);
end full_mips;

architecture Behavioral of full_mips is

component Imemory
    Port ( address 	  : in   STD_LOGIC_VECTOR (15 downto 0);
           instruction : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component registerfile
    Port ( address_1    : in   STD_LOGIC_VECTOR (2 downto 0);
           address_2    : in   STD_LOGIC_VECTOR (2 downto 0);
           address_in   : in   STD_LOGIC_VECTOR (2 downto 0);
	   reset        : in STD_LOGIC;
           data_1       : out  STD_LOGIC_VECTOR (15 downto 0);
           data_2       : out  STD_LOGIC_VECTOR (15 downto 0);
           write_signal : in   STD_LOGIC;
           clk          : in   STD_LOGIC;
           data_in      : in   STD_LOGIC_VECTOR (15 downto 0)); 
end component;

component Dmemory 
    Port ( address      : in   STD_LOGIC_VECTOR (15 downto 0);
           data_in      : in   STD_LOGIC_VECTOR (15 downto 0);
           data_out     : out  STD_LOGIC_VECTOR (15 downto 0);
           clk          : in   STD_LOGIC;
           read_signal  : in   STD_LOGIC;
           write_signal : in   STD_LOGIC);
end component;

component alsu
    Port ( data_1    : in   STD_LOGIC_VECTOR (15 downto 0);
           data_2    : in   STD_LOGIC_VECTOR (15 downto 0);
           func      : in   STD_LOGIC_VECTOR (2 downto 0);
           data_out  : out  STD_LOGIC_VECTOR (15 downto 0);
           zero_flag : out  STD_LOGIC);
end component;

component control_unit
    Port ( op_code           	  : in   STD_LOGIC_VECTOR (3 downto 0);
			  alu_op               : in   STD_LOGIC_VECTOR (2 downto 0);
	   zf                     : in std_logic;
	   reset                  : in std_logic;
           reg_dst           	  : out  STD_LOGIC;
           mem_read          	  : out  STD_LOGIC;
           mem_to_reg        	  : out  STD_LOGIC;
           alu_scr           	  : out  STD_LOGIC;
           mem_write         	  : out  STD_LOGIC;
           alu_control       	  : out  STD_LOGIC_VECTOR (2 downto 0);
           reg_write         	  : out  STD_LOGIC;
	   s0,s1,s2               : out std_logic;
	   s345 : out  STD_LOGIC_VECTOR(2 downto 0));
end component;

component mux
    Port ( data0   : in   STD_LOGIC_VECTOR (15 downto 0);
           data1   : in   STD_LOGIC_VECTOR (15 downto 0);
           sel      : in   STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

signal instruction          : std_logic_vector(15 downto 0);
signal program_counter      : std_logic_vector(15 downto 0) := x"0000";
signal regdst               : std_logic;
signal memread              : std_logic;
signal memtoreg             : std_logic;
signal aluop                : std_logic_vector(2 downto 0);
signal memwrite             : std_logic;
signal alusrc               : std_logic;
signal regwrite             : std_logic;
signal s0,s1,s2             : std_logic; 
signal s345                 : std_logic_vector(2 downto 0);

signal new_program_counter  : std_logic_vector(15 downto 0) := x"0000";

signal write_reg  : std_logic_vector(2 downto 0);
signal registerA  : std_logic_vector(15 downto 0);
signal registerB  : std_logic_vector(15 downto 0);
signal reg_data   : std_logic_vector(15 downto 0); 
signal alu3       : std_logic_vector(15 downto 0);
signal mem_out    : std_logic_vector(15 downto 0);
signal data2      : std_logic_vector(15 downto 0);
signal signal1    : std_logic_vector(2 downto 0);
signal signal2    : std_logic_vector(15 downto 0);
signal signal3    : std_logic_vector(15 downto 0);
signal signal4    : std_logic_vector(15 downto 0);
signal signal5    : std_logic_vector(15 downto 0);
signal signal6    : std_logic_vector(15 downto 0);
signal signal7    : std_logic_vector(15 downto 0);
signal signal8    : std_logic_vector(15 downto 0);
signal signal9    : std_logic_vector(15 downto 0);
signal in_data 	: std_logic_vector(15 downto 0);

signal zero_flag  : std_logic;

begin


---------------------------------------------------------------------------------------------------------------
---------------------------------------instruction memory------------------------------------------------------
Imem : Imemory port map( address     => program_counter,
								 instruction => instruction);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------register file-----------------------------------------------------------								  
REGFILE : registerfile port map( address_1    => instruction(11 downto 9),
											address_2    => instruction(8 downto 6),
											address_in   => write_reg,
reset   => reset,
data_1       => registerA,
											data_2       => registerB,
											write_signal => regwrite,
											clk          => clk,
											data_in      => reg_data);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------data memory-------------------------------------------------------------
dmem : Dmemory port map( address      => alu3,
								 data_in      => registerB,
								 data_out     => mem_out,
								 clk          => clk,
								 read_signal  => memread,
								 write_signal => memwrite);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------arithmetic logic shift unit---------------------------------------------
alu : alsu port map( data_1    => registerA,
							data_2    => data2,
							func      => aluop,
							data_out  => alu3,
							zero_flag => zero_flag);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------control unit------------------------------------------------------------							
cu : control_unit port map(op_code           => instruction(15 downto 12),
									alu_op            => instruction(2 downto 0),
									zf                => zero_flag,
									reset             => reset,
									reg_dst           => regdst,
								   mem_read          => memread,
								   mem_to_reg        => memtoreg,
								   alu_scr           => alusrc,
								   mem_write         => memwrite,
								   alu_control       => aluop,
								   reg_write         => regwrite,
								   s0 					=> s0,
									s1 					=> s1,
									s2 					=> s2,
									s345  => s345); 
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------mux to choose between Rt and Rd-----------------------------------------
with regdst select
signal1 <= instruction(8 downto 6) when '0',
			   instruction(5 downto 3) when '1',
				(others => '0') when others;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------mux to choose between (Rt or Rd) and 7----------------------------------
with s0 select
write_reg <= signal1 when '0',
			    "111" when '1',
				 (others => '0') when others;							
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------mux to choose between memory and alu------------------------------------
mux3 : mux port map (data0 	=> alu3,
							data1 	=> mem_out,
							sel   	=> memtoreg,
							data_out => signal2);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------mux to choose between (memory or alu) and in port-----------------------
mux4 : mux port map (data0 	=> signal2,
							data1 	=> in_data,
							sel   	=> s1,
							data_out => reg_data);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------



signal8 <= program_counter(15 downto 13) & instruction(11 downto 0) & '0';


signal6 <= signed(program_counter) + conv_signed(2,16) + signed(instruction(5)&instruction(5)&instruction(5)&instruction(5)&instruction(5)&instruction(5)&instruction(5)&instruction(5)&instruction(5)&instruction(5 downto 0)&'0');



signal7 <= unsigned(program_counter) + conv_unsigned(2,16);
with s345 select
new_program_counter <= signal8 when "000",
	registerA when "001",
	program_counter when "010",
	signal6 when "011",
	signal7 when others;
	



signal9 <= X"00"&"00"&instruction(5 downto 0);
---------------------------------------------------------------------------------------------------------------
---------------------------------------mux to choose between register and data---------------------------------
mux9 : mux port map (data0 => registerB,
							data1 => signal9,
							sel   => alusrc,
							data_out => data2);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------program counter---------------------------------------------------------
process(clk,reset)
begin
	if(reset = '1') then
		program_counter <= x"0000";
	else
		if(clk'event and clk = '1') then
			program_counter <= new_program_counter;
		end if;
	end if;
end process;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------in port-----------------------------------------------------------------
process(clk)
begin
	if(clk'event and clk = '1') then
		in_data <= in_port;
	end if;
end process;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
---------------------------------------out port---------------------------------------------------------
process(clk)
begin
	if(clk'event and clk = '1') then
		if (s2 = '1') then
			out_port <= registerA;
		end if;
	end if;
end process;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
end Behavioral;

