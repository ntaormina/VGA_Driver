----------------------------------------------------------------------------------
-- Company: 
-- Engineer:     C2C Nik Taormina
-- 
-- Create Date:    10:30:20 01/29/2014 
-- Design Name: 
-- Module Name:    v_sync_gen - Behavioral 
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

entity v_sync_gen is
    port ( clk         : in  std_logic;
           reset       : in std_logic;
           h_blank     : in std_logic;
           h_completed : in std_logic;
           v_sync      : out std_logic;
           blank       : out std_logic;
           completed   : out std_logic;
           row_v         : out unsigned(10 downto 0)
     );
end v_sync_gen;

architecture Behavioral of v_sync_gen is

type state_type is (active_video, front_porch, sync_pulse, back_porch, completed_state);
	signal count_reg, count_next, count: unsigned(10 downto 0);
	signal state_reg, state_next: state_type;
		
begin

	process(clk, reset, state_reg, count_reg)
		begin
	
			if(reset = '1') then
				state_reg <= active_video;
			elsif (clk'event and clk = '1') then
				state_reg <= state_next;
			end if;	
	
			case state_reg is
				when active_video=>
					if(count_reg = "00111100000") then
						state_next <= front_porch;
						blank <= '1';
						row_v <= "00000000000";
					else
						row_v <= count_reg;
						completed <= '0';
						blank <= '0';
						state_next <= active_video;
					end if;	
				when front_porch=>
					if(count_reg = "00000001010") then
						state_next <= sync_pulse;
					else 
						state_next <= front_porch;	
					end if;	
				when sync_pulse=>
					if(count_reg = "00000000010") then
						state_next <= back_porch;
						v_sync <= '0';
					else
						state_next <= sync_pulse;
						v_sync <= '1';
					end if;	
				when back_porch=>
					if(count_reg = "00000100000") then
						state_next <= completed_state;
					else
						state_next <= back_porch;
					end if;	
				when completed_state=>
					if(count_reg = "00000000001") then
						completed <= '1';
						state_next <= active_video;
					else
						state_next <= completed_state;		
					end if;
			end case;

	end process;	
	
	
	process(clk, reset, count_reg, state_reg, state_next, h_completed)
		begin
		
			if(reset = '1') then
				count_reg <= "00000000000";
			elsif(clk'event and clk = '1') then
				count_reg <= count_next;
			end if;	
			
			--count_next <= (others => '0') when (state_reg /= state_next) else
			--					count_reg + "00000000001" when (h_completed = '1' and clk = '1') else
			--					count_reg;
								
			if(state_reg /= state_next) then
				count_next <= (others => '0');
			elsif(h_completed = '1' and clk = '1') then
				count_next <= count_reg + "00000000001";
			else
				count_next <= count_reg;
			end if;	

			
	end process;
	

end Behavioral;

