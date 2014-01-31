----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:42 01/29/2014 
-- Design Name: 
-- Module Name:    h_sync_gen - Behavioral 
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

entity h_sync_gen is
    port ( clk       : in  std_logic;
           reset     : in  std_logic;
           h_sync    : out std_logic;
           blank     : out std_logic;
           completed : out std_logic;
           column    : out unsigned(10 downto 0)
     );
end h_sync_gen;


architecture Behavioral of h_sync_gen is

	type state_type is (active_video, front_porch, sync_pulse, back_porch);
	signal count_reg, count_next, count: integer;
	signal state_reg, state_next: state_type;
		
begin

	process(clk, reset)
	begin
	if((clk'event) and (clk='1') and (count > count_reg)) then
		state_reg <= state_next;
	else 
		state_reg <= state_reg;
	end if;
	

		case state_reg is
			when active_video=>
				state_next <= front_porch;
			when front_porch=>
				state_next <= sync_pulse;
			when sync_pulse=>
				state_next <= back_porch;
			when back_porch=>
				state_next <= active_video;
				
		end case;
	end process;

process(clk, reset)
	begin
	
	if(state_type'event) then
		count_reg <= count_next;
	else
		count<= count + 1;
	end if;	

		case count_reg is
			when 640=>				
				count_next <= 16;
			when 16=>
				count_next <= 96;
			when 96=>				 
				count_next <= 48;
			when 48=>
				count_next <= 640;
				
		end case;
	end process;	
	
completed <= '1' when(count_reg = 47 and state_reg = back_porch) else
				 '0'; 	

end Behavioral;

