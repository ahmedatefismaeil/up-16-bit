----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:25:54 01/30/2019 
-- Design Name: 
-- Module Name:    Imemory - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Imemory is
    Port ( address     : in   STD_LOGIC_VECTOR (15 downto 0);
           instruction : out  STD_LOGIC_VECTOR (15 downto 0));
end Imemory;

architecture Behavioral of Imemory is

type memory_type is array (0 to 19) of std_logic_vector (7 downto 0);
signal memory : memory_type := (X"03",X"40",
				X"45",X"42",
				X"50",X"00",
				X"C8",X"46",
				X"C1",X"94",
				X"81",X"44",
				X"82",X"44",
				X"00",X"82",
				X"80",X"72",
				X"00",X"F0");

begin

--process(clk) begin
--	if (clk'event and clk = '1') then 
		instruction(7 downto 0)  <= memory(conv_integer(address));
		instruction(15 downto 8) <= memory(conv_integer(address)+1);
--	end if;
--end process;

end Behavioral;

