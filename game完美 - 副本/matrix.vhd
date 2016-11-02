

		
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;		
entity matrix is
		port(
		clk_in_m:in std_logic;
		start_in_m:in std_logic;
		ready_in_m:in std_logic;
		show_in_m:in std_logic;
		a_select_in_m,b_select_in_m:in integer range 0 to 3;
		result_in_m:in integer range 0 to 2;
		col_out_m,row_out_m:out std_logic_vector(7 downto 0)
		);
end matrix;

architecture behave of matrix is
		signal counter_m:integer range 0 to 3;
		signal big_counter_m:integer range 0 to 2499;
		signal state_m:integer range 0 to 1;
		begin
			process(clk_in_m,result_in_m,start_in_m)
			begin
			if(clk_in_m'event and clk_in_m = '1')then
				if(counter_m = 3)then
					counter_m <= 0;
				else
					counter_m <= counter_m+1;
				end if;
				if(start_in_m = '1')then
					big_counter_m <= 0;
				else
					if(result_in_m /= 0)then
						if(big_counter_m = 2499)then
							state_m <= 1;
						else
							big_counter_m <= big_counter_m + 1;
						end if;
					else
						state_m <= 0;
					end if;
				end if;
			end if;
			end process;
			process(counter_m,start_in_m,ready_in_m,show_in_m,a_select_in_m,b_select_in_m)
			begin
				if(start_in_m = '1')then
					row_out_m <= "11111111";
					col_out_m <= "00000000";
				elsif(ready_in_m = '1')then
					row_out_m <= "11111111";
					col_out_m <= "00000000";
				elsif (show_in_m = '1')then
					case state_m is
						when 0=>
							case a_select_in_m is
								when 1=>
								if(b_select_in_m = 1)then
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
								elsif(b_select_in_m = 2)then
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
								elsif(b_select_in_m = 3)then
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
								else
									row_out_m <= "11111111";
									col_out_m <= "00000000";
								end if;
							when 2=>
								if(b_select_in_m = 1)then
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
								elsif(b_select_in_m = 2)then
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
								elsif(b_select_in_m = 3)then
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
								else
									row_out_m <= "11111111";
									col_out_m <= "00000000";
								end if;
							when 3=>
								if(b_select_in_m = 1)then
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
								elsif(b_select_in_m = 2)then
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
								elsif(b_select_in_m = 3)then
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
								else
									row_out_m <= "11111111";
									col_out_m <= "00000000";
								end if;
							when others =>
											row_out_m <= "11111111";
											col_out_m <= "00000000";
						end case;
					when 1=>
						case result_in_m is
							when 1=>
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
									when others=>
										row_out_m <= "11111111";
										col_out_m <= "00000000";
								end case;
							when 2=>
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
									when others=>
										row_out_m <= "11111111";
										col_out_m <= "00000000";
								end case;
							when others=>
										row_out_m <= "11111111";
										col_out_m <= "00000000";
						end case;
					end case;
				end if;
		end process;
end behave;
			