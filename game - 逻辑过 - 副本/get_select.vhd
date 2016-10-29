

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;	

entity get_select is
		port(
			clk_in_g:in std_logic;
			start_in_g:in std_logic;
			ready_in_g:in std_logic;
			a_ok_in_g:in std_logic;
			b_ok_in_g:in std_logic;
			a_select_in_g,b_select_in_g:in integer range 0 to 3;
			a_select_out_g,b_select_out_g:out integer range 0 to 3
			);
end get_select;

architecture behave of get_select is
	signal a_select_tmp,b_select_tmp:integer range 0 to 3;
	begin
	process(clk_in_g)
	begin
		if(clk_in_g'event and clk_in_g = '1')then
			if(start_in_g = '1')then
				a_select_out_g <= 0;
				b_select_out_g <= 0;
			elsif(ready_in_g = '1')then
				a_select_out_g <= 0;
				b_select_out_g <= 0;
			else
				if(a_select_in_g /= 0)then
					a_select_tmp <= a_select_in_g;
				end if;
				if(b_select_in_g /= 0)then
					b_select_tmp <= b_select_in_g;
				end if;
				if(a_ok_in_g = '1')then
					a_select_out_g <= a_select_tmp;
				end if;
				if(b_ok_in_g = '1')then
					b_select_out_g <= b_select_tmp;
				end if;
			end if;
		end if;
	end process;
end behave;