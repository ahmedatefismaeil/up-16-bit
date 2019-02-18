----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:36:27 01/30/2019 
-- Design Name: 
-- Module Name:    alsu - Behavioral 
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
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alsu is
    Port ( data_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           data_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           func : in  STD_LOGIC_VECTOR (2 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           zero_flag : out  STD_LOGIC);
end alsu;

architecture Behavioral of alsu is

signal data_check : std_logic_vector(15 downto 0);
signal zero_signal : std_logic_vector(15 downto 0);

begin

with func select
	data_check <= data_1 + data_2 when "000",
					data_1 - data_2 when "001",
					data_1 and data_2 when "010",
					data_1 or data_2 when "011",
					data_1 nor data_2 when "100",
					data_1 xor data_2 when "101",
					data_1(14 downto 0) & '0' when "110",
					'0' & data_1(15 downto 1) when "111",
					data_1 when others;
	
data_out <= data_check; 
zero_signal(0) <= data_check(0);
zero_flag <= not(zero_signal(15));

L1: for i in 1 to 15 generate
	zero_signal(i) <= zero_signal(i-1) or data_check(i);
end generate;


end Behavioral;

