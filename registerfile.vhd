----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:47 01/30/2019 
-- Design Name: 
-- Module Name:    registerfile - Behavioral 
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

entity registerfile is
    Port ( address_1 : in  STD_LOGIC_VECTOR (2 downto 0);
           address_2 : in  STD_LOGIC_VECTOR (2 downto 0);
           address_in : in  STD_LOGIC_VECTOR (2 downto 0);
	   reset   : in STD_LOGIC;
           data_1 : out  STD_LOGIC_VECTOR (15 downto 0);
           data_2 : out  STD_LOGIC_VECTOR (15 downto 0);
           write_signal : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (15 downto 0));
end registerfile;

architecture Behavioral of registerfile is

type reg_type is array( integer range<>) of std_logic_vector (15 downto 0);
signal reg_file : reg_type(0 to 7) := (X"0000",X"0000",X"0000",X"0000",
				       X"0000",X"0000",X"0000",X"0000");


begin
 data_write : process (clk,reset) begin 
						if (reset = '1') then
							reg_file(0) <= (others => '0');
							reg_file(1) <= (others => '0');
							reg_file(2) <= (others => '0');
							reg_file(3) <= (others => '0');
							reg_file(4) <= (others => '0');
							reg_file(5) <= (others => '0');
							reg_file(6) <= (others => '0');
							reg_file(7) <= (others => '0');

						else 
							if ( clk'event and clk ='1') then
								if (write_signal='1') then 
									reg_file(conv_integer(address_in))<= data_in ;
								end if;
							end if;
						end if;
					end process ;
								data_1 <= reg_file(conv_integer(address_1));
								data_2 <= reg_file(conv_integer(address_2));
					
--process (clk) begin
--	if (clk'event and clk = '1') then
--		data_1 <= reg_file(conv_integer(address_1));
--		data_2 <= reg_file(conv_integer(address_2));
--	end if;
--end process;

end Behavioral;

