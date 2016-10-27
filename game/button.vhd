							
			
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;				
entity button is
		port(
		clk_in_b:in std_logic;
		col_in_b:in std_logic_vector(3 downto 0);
		start_out_b,ready_out_b,show_out_b,a_ok_out_b,b_ok_out_b:out std_logic;
		a_select_out_b,b_select_out_b:out integer range 0 to 2;
		row_out_b:out std_logic_vector(3 downto 0)
		);
end button;

architecture behave of button is
		signal counter_b:integer range 0 to 2;
		begin
			process(clk_in_b)
			begin
				if(clk_in_b'event and clk_in_b = '1')then
					if(counter_b = 3)then
						counter_b <= 0;
					else
						counter_b <= counter_b + 1;
					end if;
					case counter_b is
					when 0=>row_out_b <= "0111";
						if(col_in_b = "0111")then
							start_out_b <= '1';
							ready_out_b <= '0';
							show_out_b <= '0';
							a_ok_out_b <= '0';
							b_ok_out_b <= '0';
							a_select_out_b <= 0;
							b_select_out_b <= 0;
						elsif(col_in_b = "1011")then
							start_out_b <= '0';
							ready_out_b <= '1';
							show_out_b <= '0';
							a_ok_out_b <= '0';
							b_ok_out_b <= '0';
							a_select_out_b <= 0;
							b_select_out_b <= 0;
						elsif(col_in_b = "1101")then
							start_out_b <= '0';
							ready_out_b <= '0';
							show_out_b <= '1';
							a_ok_out_b <= '0';
							b_ok_out_b <= '0';
							a_select_out_b <= 0;
							b_select_out_b <= 0;
						end if;
					when 1=>row_out_b <= "1011";
						if(col_in_b = "0111")then
							a_select_out_b <= 0;
						elsif(col_in_b = "1011")then
							a_select_out_b <= 1;
						elsif(col_in_b = "1101")then
							a_select_out_b <= 2;
						elsif(col_in_b = "1110")then						
							a_ok_out_b <= '1';
						end if;
					when 2=>row_out_b <= "1101";
						if(col_in_b = "0111")then
							b_select_out_b <= 0;
						elsif(col_in_b = "1011")then
							b_select_out_b <= 1;
						elsif(col_in_b = "1101")then
							b_select_out_b <= 2;
						elsif(col_in_b = "1110")then
							b_ok_out_b <= '1';
						end if;
					end case;
				end if;
			end process;
end behave;						
		