----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:35 01/29/2014 
-- Design Name: 
-- Module Name:    pixel_gen - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity pixel_gen is
    port ( row      : in unsigned(10 downto 0);
           column   : in unsigned(10 downto 0);
           blank    : in std_logic;
			  switch0  : in std_logic;
			  switch1  : in std_logic;
           r        : out std_logic_vector(7 downto 0);
           g        : out std_logic_vector(7 downto 0);
           b        : out std_logic_vector(7 downto 0));
end pixel_gen;

architecture Behavioral of pixel_gen is

begin


process(column, row, blank)
begin
	if (blank = '0') then
		if(switch0 = '0' and switch1 = '0') then
		
			if(row < 360) then
				if(column < 220 )then
					r <= "11111111";
					g <= "00000000";
					b <= "00000000";
				elsif(column > 440) then
					r <= "00000000";
					g <= "11111111";
					b <= "00000000";
				else
					r <= "00000000";
					g <= "00000000";
					b <= "11111111";
				end if;
			else
				r <= "11111111";
				g <= "11111111";
				b <= "00000000";
			end if;
		elsif(switch0 = '0' and switch1 = '1') then
		
			if(row < 360) then
				if(column < 220 )then
					r <= "11111111";
					g <= "00000000";
					b <= "11111111";
				elsif(column > 440) then
					r <= "00000000";
					g <= "00000000";
					b <= "11111111";
				else
					r <= "00000000";
					g <= "11111111";
					b <= "00000000";
				end if;
			else
				r <= "11111111";
				g <= "00000000";
				b <= "00000000";
			end if;	
		elsif(switch0 = '1' and switch1 = '0') then
		
			if(row < 360) then
				if(column < 220 )then
					r <= "00000000";
					g <= "00000000";
					b <= "11111111";
				elsif(column > 440) then
					r <= "00000000";
					g <= "11111111";
					b <= "11111111";
				else
					r <= "11111111";
					g <= "00000000";
					b <= "11111111";
				end if;
			else
				r <= "11111111";
				g <= "00000000";
				b <= "00000000";
			end if;
		elsif(switch0 = '1' and switch1 = '1') then
		
			if(row < 360) then
				if(column < 220 )then
					r <= "11111111";
					g <= "11111111";
					b <= "00000000";
				elsif(column > 440) then
					r <= "00000000";
					g <= "11111111";
					b <= "11111111";
				else
					r <= "11111111";
					g <= "00000000";
					b <= "11111111";
				end if;
			else
				r <= "00000000";
				g <= "11111111";
				b <= "00000000";
			end if;		
			end if;
	else	
		r <= (others=>'0');
		g <= (others=>'0');
		b <= (others=>'0');
		
	end if;
end process;
end Behavioral;

