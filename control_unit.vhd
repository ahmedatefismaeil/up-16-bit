----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:43:44 01/30/2019 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
    Port ( op_code              : in   STD_LOGIC_VECTOR (3 downto 0);
	   alu_op               : in   STD_LOGIC_VECTOR (2 downto 0);
	   zf                   : in STD_LOGIC;
reset : in std_logic;
           reg_dst              : out  STD_LOGIC;
           branch               : out  STD_LOGIC;
           mem_read          	  : out  STD_LOGIC;
           mem_to_reg        	  : out  STD_LOGIC;
           alu_scr              : out  STD_LOGIC;
           mem_write            : out  STD_LOGIC;
           alu_control       	  : out  STD_LOGIC_VECTOR (2 downto 0);
           reg_write            : out  STD_LOGIC;
	   s0,s1,s2             : out STD_LOGIC;
	   s345             : out STD_LOGIC_VECTOR(2 downto 0));
end control_unit;

architecture Behavioral of control_unit is

constant alsu : std_logic_vector(3 downto 0) := "0000";
constant ini  : std_logic_vector(3 downto 0) := "0001";
constant outi : std_logic_vector(3 downto 0) := "0010";
constant jr   : std_logic_vector(3 downto 0) := "0011";
constant addi : std_logic_vector(3 downto 0) := "0100";
constant andi : std_logic_vector(3 downto 0) := "0101";
constant ori  : std_logic_vector(3 downto 0) := "0110";
constant lw   : std_logic_vector(3 downto 0) := "0111";
constant sw   : std_logic_vector(3 downto 0) := "1000";
constant beq  : std_logic_vector(3 downto 0) := "1001";
constant bne  : std_logic_vector(3 downto 0) := "1010";
constant j    : std_logic_vector(3 downto 0) := "1011";
constant jal  : std_logic_vector(3 downto 0) := "1100";
--constant ?    : std_logic_vector(3 downto 0) := "1101";
constant nop  : std_logic_vector(3 downto 0) := "1110";
constant halt : std_logic_vector(3 downto 0) := "1111";

begin

reg_write <= '0' when reset = '1' else
	     '1' when (op_code = addi or op_code = andi or op_code = alsu or op_code = ori or op_code = lw or op_code = jal) else
	     '0';
				 
with op_code select 
alu_scr <= '0' when alsu,
				   '0' when ini,
				   '0' when outi,
				   '0' when jr,
				   '1' when addi,
				   '1' when andi,
				   '1' when ori,
				   '1' when lw,
				   '1' when sw,
				   '0' when beq,
				   '0' when bne,
				   '0' when j,
				   '0' when jal,
				 
				   '0' when nop,
				   '0' when halt,
				   '0' when others;
			
mem_write <= '0' when reset = '1' else
	     '1' when op_code = sw else
	     '0'; 		
				 
with op_code select 
alu_control <= "000" when lw,
				  "000" when sw,
				  "000" when addi,
				  "010" when andi,
				  "011" when ori,
				  "001" when beq,
				  "001" when bne,
				  alu_op when others;
				  
with op_code select 
mem_to_reg <=  '1' when lw,
				   '0' when others;
			 		
with op_code select 
mem_read <=  '1' when sw,
				 '0' when others;
				 
with op_code select 
branch <=  '1' when jr,
			  '1' when beq,
			  '1' when bne,
			  '1' when j,
			  '1' when jal,
			  '1' when halt,
			  '0' when others;
			  
with op_code select 
reg_dst <= '1' when alsu,
			  '1' when ini,
			  '0' when others;
			  
with op_code select
s0 <= '1' when jal,
		'0' when others;
		
with op_code select
s1 <= '1' when ini,
		'0' when others;
	
with op_code select
s2 <= '1' when outi,
		'0' when others;

s345 <= "000" when op_code = j or op_code = jal else
        "001" when op_code = jr else
	"010" when op_code = halt else
	"011" when (op_code = beq and zf = '1') or (op_code = bne and zf = '0') else
	"100" ;
		
end Behavioral;

