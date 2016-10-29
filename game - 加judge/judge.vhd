

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity judge is
		port
		(
		clk_in_j:in std_logic;
		start_in_j:in std_logic;
		b_ok_in_j,show_in_j:in std_logic;
		a_select_j,b_select_j:in integer range 0 to 3;
		a_score_j,b_score_j:out integer range 0 to 3;
		result_j:out integer range 0 to 2;
		--tmp
		st:out std_logic;
		bo:out std_logic;
		sh:out std_logic;
		as,bs:out integer range 0 to 3
		);
end judge;

architecture behave of judge is
	signal a_score_tmp,b_score_tmp:integer range 0 to 3;
	signal result_tmp:integer range 0 to 2;
	begin
		process(show_in_j)
		begin
		--tmp
		st <= start_in_j;
		bo <= b_ok_in_j;
		sh <= show_in_j;
		as <= a_select_j;
		bs <= b_select_j;
		--tmp
			if(show_in_j'event and show_in_j = '1')then
				case a_select_j is
				when 1=>
					case b_select_j is
						when 2=>
							case a_score_tmp is
								when 0=>
									a_score_tmp <= 1;
								when 1=>
									a_score_tmp <= 2;
								when 2=>
									a_score_tmp <= 3;
									result_tmp <= 1;
								when others=>
							end case;
						when 3=>
							case b_score_tmp is
								when 0=>
									b_score_tmp <= 1;
								when 1=>
									b_score_tmp <= 2;
								when 2=>
									b_score_tmp <= 3;
									result_tmp <= 2;
								when others=>
							end case;
						when others=>
					end case;
				when 2=>
					case b_select_j is
						when 3=>
							case a_score_tmp is
								when 0=>
									a_score_tmp <= 1;
								when 1=>
									a_score_tmp <= 2;
								when 2=>
									a_score_tmp <= 3;
									result_tmp <= 1;
								when others=>
							end case;
						when 1=>
							case b_score_tmp is
								when 0=>
									b_score_tmp <= 1;
								when 1=>
									b_score_tmp <= 2;
								when 2=>
									b_score_tmp <= 3;
									result_tmp <= 2;
								when others=>
							end case;
						when others=>
					end case;
				when 3=>
					case b_select_j is
						when 1=>
							case a_score_tmp is
								when 0=>
									a_score_tmp <= 1;
								when 1=>
									a_score_tmp <= 2;
								when 2=>
									a_score_tmp <= 3;
									result_tmp <= 1;
								when others=>
							end case;
						when 2=>
							case b_score_tmp is
								when 0=>
									b_score_tmp <= 1;
								when 1=>
									b_score_tmp <= 2;
								when 2=>
									b_score_tmp <= 3;
									result_tmp <= 2;
								when others=>
							end case;
						when others=>
						end case;
				when others=>
				end case;
			end if;
		end process;
		process(clk_in_j)
		begin
			if(clk_in_j'event and clk_in_j = '1')then
				if(start_in_j = '1')then
						a_score_j <= 0;
						b_score_j <= 0;
						result_j <= 0;
				elsif(show_in_j = '1')then
						a_score_j <= a_score_tmp;
						b_score_j <= b_score_tmp;
						result_j <= result_tmp;
				end if;
			end if;
		end process;
end behave;