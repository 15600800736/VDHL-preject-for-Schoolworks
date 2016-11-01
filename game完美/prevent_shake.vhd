


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;	
entity prevent_shake is
		port(
		clk_in_p:in std_logic;
		start_in_p,ready_in_p,show_in_p,a_ok_in_p,b_ok_in_p:in std_logic;
		a_select_in_p,b_select_in_p:in integer range 0 to 2;
		start_out_p,ready_out_p,show_out_p,a_ok_out_p,b_ok_out_p:out std_logic;
		a_select_out_p,b_select_out_p:out integer range 0 to 3;
		-------
		st,re,sh,ao,bo:out std_logic;
		as,bs:out integer range 0 to 3
		);
end prevent_shake;

architecture behave of prevent_shake is
		signal start_in_p_tmp,ready_in_p_tmp,show_in_p_tmp,a_ok_in_p_tmp,b_ok_in_p_tmp:std_logic;
		signal a_select_in_p_tmp,b_select_in_p_tmp:integer range 0 to 2;
		signal start_p:std_logic;
		signal counter_p:integer range 0 to 4;
		begin
			process(clk_in_p)
			begin
				if(clk_in_p'event and clk_in_p = '1')then
					if(start_in_p /= start_in_p_tmp
						or ready_in_p /= ready_in_p_tmp
						or show_in_p /=show_in_p_tmp
						or a_ok_in_p /= a_ok_in_p_tmp
						or b_ok_in_p /= b_ok_in_p_tmp
						or a_select_in_p /= a_select_in_p_tmp
						or b_select_in_p /= b_select_in_p_tmp)then
								start_in_p_tmp <= start_in_p;
								ready_in_p_tmp <= ready_in_p;
								show_in_p_tmp <= show_in_p;
								a_ok_in_p_tmp <= a_ok_in_p;
								b_ok_in_p_tmp <= b_ok_in_p;
								a_select_in_p_tmp <= a_select_in_p;
								b_select_in_p_tmp <= b_select_in_p;	
								counter_p <= 0;
								-----
							st <= start_in_p_tmp;
							re <= ready_in_p_tmp;
							sh <= show_in_p_tmp;
							ao <= a_ok_in_p_tmp;
							bo <= b_ok_in_p_tmp;
							as <= a_select_in_p_tmp;
							bs <= b_select_in_p_tmp;
					else
						if(counter_p = 4)then
							start_out_p <= start_in_p_tmp;
							ready_out_p <= ready_in_p_tmp;
							show_out_p <= show_in_p_tmp;
							a_ok_out_p <= a_ok_in_p_tmp;
							b_ok_out_p <= b_ok_in_p_tmp;
							a_select_out_p <= a_select_in_p_tmp;
							b_select_out_p <= b_select_in_p_tmp;	
							counter_p <= 0;
							--------
							st <= start_in_p_tmp;
							re <= ready_in_p_tmp;
							sh <= show_in_p_tmp;
							ao <= a_ok_in_p_tmp;
							bo <= b_ok_in_p_tmp;
							as <= a_select_in_p_tmp;
							bs <= b_select_in_p_tmp;
						else
							counter_p <= counter_p + 1;

						end if;
					end if;
				end if;
			end process;
end behave;
		
		
		
		
		
		
		
		