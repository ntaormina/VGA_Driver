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

	type v_sync_type is (active_video, front_porch, sync_pulse, back_porch, completed_state);
	signal count_reg, count_next: unsigned(10 downto 0);
	signal state_reg, state_next: v_sync_type;
		
begin

	process(clk, reset)
		begin
		
		
	
			if(reset = '1') then
				state_reg <= active_video;
			elsif (rising_edge(clk)) then
				state_reg <= state_next;
			end if;	
			
		end process;	
		
	process(count_reg, state_reg, state_next, count_next)
	begin
	
		h_sync <= '1';
		blank <= '1';
		completed <= '0';
		column <= "00000000000";
	
	state_next <= state_reg;
	
			case state_reg is
				when active_video=>
					if(count_reg = 640) then 
						state_next <= front_porch;												
					else			
						column <= count_next;
						blank <= '0';
						state_next <= active_video;
					end if;	
				when front_porch=>
					if(count_reg = 16) then
						state_next <= sync_pulse;
					else 
						state_next <= front_porch;	
					end if;	
				when sync_pulse=>
					if(count_reg = 96) then
						state_next <= back_porch;						
					else
						state_next <= sync_pulse;
						h_sync <= '0';
					end if;	
				when back_porch=>
					if(count_reg = 47) then
						state_next <= completed_state;
					else
						state_next <= back_porch;
					end if;	
				when completed_state=>
						completed <= '1';
						state_next <= active_video;
					
			end case;
			
			

	end process;	
	
					
	process(clk, reset)
		begin
		
			if (reset = '1') then
				count_reg <= "00000000000";
			elsif (rising_edge(clk)) then
				count_reg <= count_next;
			end if;
		end process;
		
	process(count_reg, state_reg)
		begin
			if(state_reg /= state_next) then
				count_next <=  "00000000000";				
			else
				count_next <= count_reg + "00000000001" ;
				
			end if;	
		end process;
		
	
 	

end Behavioral;

