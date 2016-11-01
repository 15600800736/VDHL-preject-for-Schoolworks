
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity translate is
		port(
		clk_in_col:in std_logic;
		clk_in_row:in std_logic;
		row_in_t:in std_logic_vector(3 downto 0);
		col_out_t:out std_logic_vector(3 downto 0);
		start_out_t,ready_out_t,show_out_t,a_ok_out_t,b_ok_out_t:out std_logic;
		a_select_out_t,b_select_out_t:out integer range 0 to 3
		);
end translate;

architecture behave of translate is
		signal counter:integer range 0 to 3;
		signal state:integer range 0 to 3;
		begin
		process(clk_in_col)
		begin
			if(clk_in_col'event and clk_in_col = '1')then
				if(counter = 3)then
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end process;
		process(clk_in_col)
		begin
			if(clk_in_col'event and clk_in_col = '1')then
				case counter is
					when 0=>col_out_t<="1110";state <= 0;
					when 1=>col_out_t<="1101";state <= 1;
					when 2=>col_out_t<="1011";state <= 2;
					when 3=>col_out_t<="0111";state <= 3;
					when others=>col_out_t<="1111";
				end case;
			end if;
		end process;
		process(clk_in_row)
			begin
			if(clk_in_row'event and clk_in_row = '1')then
				case state is
					when 0=>
						case row_in_t is
							when "0111"=>
								start_out_t <= '1';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								b_ok_out_t <= '0';
								a_select_out_t <= 0;
								b_select_out_t <= 0;
							when "1011"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								a_select_out_t <= 1;
							when "1101"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								b_ok_out_t <= '0';
								a_ok_out_t <= '0';
								b_select_out_t <= 1;
							when others=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								b_ok_out_t <= '0';
								a_select_out_t <= 0;
								b_select_out_t <= 0;
							end case;
					when 1=>
						case row_in_t is
							when "0111"=>
								start_out_t <= '0';
								ready_out_t <= '1';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								b_ok_out_t <= '0';
								a_select_out_t <= 0;
								b_select_out_t <= 0;
							when "1011"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								a_select_out_t <= 2;
							when "1101"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								b_ok_out_t <= '0';
								a_ok_out_t <= '0';
								b_select_out_t <= 2;	
							when others=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								b_ok_out_t <= '0';
								a_select_out_t <= 0;
								b_select_out_t <= 0;

							end case;
					when 2=>
						case row_in_t is
							when "0111"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '1';
								a_ok_out_t <= '0';
								b_ok_out_t <= '0';						
							when "1011"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								a_select_out_t <= 3;
							when "1101"=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								b_ok_out_t <= '0';
								a_ok_out_t <= '0';
								b_select_out_t <= 3;
							when others=>
								start_out_t <= '0';
								ready_out_t <= '0';
								show_out_t <= '0';
								a_ok_out_t <= '0';
								b_ok_out_t <= '0';
								a_select_out_t <= 0;
								b_select_out_t <= 0;
							end case;
						when 3=>
							case row_in_t is
								when "1011"=>
									start_out_t <= '0';
									ready_out_t <= '0';
									show_out_t <= '0';
									a_ok_out_t <= '1';
								when "1101"=>
									start_out_t <= '0';
									ready_out_t <= '0';
									show_out_t <= '0';
									a_ok_out_t <= '0';
									b_ok_out_t <= '1';
								when others=>
									start_out_t <= '0';
									ready_out_t <= '0';
									show_out_t <= '0';
									a_ok_out_t <= '0';
									b_ok_out_t <= '0';
									a_select_out_t <= 0;
									b_select_out_t <= 0;
								end case;
						when others=>
					end case;
			end if;
		end process;
end behave;