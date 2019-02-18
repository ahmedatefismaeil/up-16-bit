----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:45 01/30/2019 
-- Design Name: 
-- Module Name:    Dmemory - Behavioral 
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

entity Dmemory is
    Port ( address : in  STD_LOGIC_VECTOR (15 downto 0);
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           read_signal : in  STD_LOGIC;
           write_signal : in  STD_LOGIC);
end Dmemory;

architecture Behavioral of Dmemory is

type memory_type is array(integer range<>) of std_logic_vector (15 downto 0);
signal memory : memory_type (0 to (2**16)-1);
--signal memory : memory_type (0 to 49);
begin
data_write : process (clk) begin 
						if ( clk'event and clk ='1') then
							if (write_signal='1') then 
								memory(conv_integer(address))<= data_in ;
							end if;
						end if;
					end process ;
--data_read : process (clk) begin 
--						if ( clk'event and clk ='1') then
--							if (read_signal='1') then 
--								data_out <= memory(conv_integer(address));
--							end if;
--						end if;
--					end process ;

data_out <= memory(conv_integer(address));
end Behavioral;

