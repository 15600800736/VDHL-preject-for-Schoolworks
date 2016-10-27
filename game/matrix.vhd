

		
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;		
entity matrix is
		port(
		clk_in_m:in std_logic;
		start_in_m:in std_logic;
		ready_in_m:in std_logic;
		show_in_m:in std_logic;
		result_in_m:in integer range 0 to 2;
		a_select_in_m,b_select_in_m:in integer range 0 to 2;
		col_out_m,row_out_m:out std_logic_vector(7 downto 0)
		);
end matrix;

architecture behave of matrix is
		signal counter_m:integer range 0 to 3;
		begin
			process(clk_in_m)
			begin
			if(clk_in_m'event and clk_in_m = '1')then
				if(start_in_m = '1')then
					row_out_m <= "11111111";
					col_out_m <= "00000000";
					counter_m <= 0;
				elsif(ready_in_m = '1')then
					row_out_m <= "11111111";
					col_out_m <= "00000000";
					counter_m <= 0;
				elsif (show_in_m = '1')then
					if(counter_m = 3)then
						counter_m <= 0;
					else
						counter_m <= counter_m+1;
					end if;
					if(result_in_m = 1)then
						case counter_m is
							when 0=>
								row_out_m <= "11011111";
								col_out_m <= "00011100";
							when 1=>
								row_out_m <= "11101111";
								col_out_m <= "00011100";
							when 2=>
								row_out_m <= "11110111";
								col_out_m <= "00011100";
							when 3=>
								row_out_m <= "11111011";
								col_out_m <= "00001000";
							end case;
					elsif(result_in_m = 2)then
						case counter_m is
							when 0=>
								row_out_m <= "11011111";
								col_out_m <= "00111100";
							when 1=>
								row_out_m <= "11101111";
								col_out_m <= "00001000";
							when 2=>
								row_out_m <= "11110111";
								col_out_m <= "00010100";
							when 3=>
								row_out_m <= "11111011";
								col_out_m <= "00111100";
							end case;
					else
						case a_select_in_m is
							when 0=>
								if(b_select_in_m = 0)then
									case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "01000010";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11100111";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11100111";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "01000010";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								elsif(b_select_in_m = 1)then
										case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "01000100";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11100011";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11100011";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "01000100";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								elsif(b_select_in_m = 2)then
									case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "01000111";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11100111";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11100111";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "01000111";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								end if;
							when 1=>
								if(b_select_in_m = 0)then
									case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "00100010";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11000111";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11000111";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "00100010";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								elsif(b_select_in_m = 1)then
										case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "00100100";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11000011";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11000011";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "00100100";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								elsif(b_select_in_m = 2)then
									case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "00100111";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11000111";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11000111";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "00100111";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								end if;
							when 2=>
								if(b_select_in_m = 0)then
									case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "11100010";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11100111";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11100111";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "11100010";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								elsif(b_select_in_m = 1)then
										case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "11100100";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11100011";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11100011";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "11100100";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								elsif(b_select_in_m = 2)then
									case counter_m is
										when 0=>
											row_out_m <= "11011111";
											col_out_m <= "11100111";
										when 1=>
											row_out_m <= "11101111";
											col_out_m <= "11100111";
										when 2=>
											row_out_m <= "11110111";
											col_out_m <= "11100111";
										when 3=>
											row_out_m <= "11111011";
											col_out_m <= "11100111";
										when others=>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
									end case;
								end if;
							when others =>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
						end case;
					end if;
				end if;
			end if;
		end process;
end behave;
			