
		
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity digitron is
		port
		(
		clk_in_d:in std_logic;
		start_in_d:in std_logic;
		show_in_d:in std_logic;
		result_in_d:in integer range 0 to 2;
		a_score_d:in integer range 0 to 3;
		b_score_d:in integer range 0 to 3;
		digitron_cat_d:out std_logic_vector(5 downto 0);
		digitron_show_d:out std_logic_vector(6 downto 0)
		);
end digitron;

architecture behave of digitron is
	signal counter_d:std_logic;
	begin
		process(clk_in_d)
		variable a_score_tmp_d,b_score_tmp_d:integer range 0 to 3;
		begin
		if(clk_in_d'event and clk_in_d = '1')then
			if(start_in_d = '1')then
				digitron_cat_d <= "000000";
				digitron_show_d <= "0000001";
			elsif(result_in_d /= 0)then
				digitron_cat_d <= "000000";
				digitron_show_d <= "0000001";
			elsif(show_in_d = '1')then
				counter_d <= not counter_d;
				a_score_tmp_d := a_score_d;
				b_score_tmp_d := b_score_d;
				case counter_d is
					when '0'=>
						digitron_cat_d <= "011111";
							case a_score_tmp_d is
								when 0=>digitron_show_d<="1111110";
								when 1=>digitron_show_d<="0110000";
								when 2=>digitron_show_d<="1101101";
								when 3=>digitron_show_d<="1111001";
								when others=>digitron_show_d<="1111111";
							end case;
					when '1'=>
						digitron_cat_d <= "101111";
							case b_score_tmp_d is
								when 0=>digitron_show_d<="1111110";
								when 1=>digitron_show_d<="0110000";
								when 2=>digitron_show_d<="1101101";
								when 3=>digitron_show_d<="1111001";
								when others=>digitron_show_d<="1111111";
							end case;
					when others=>
						digitron_cat_d<="000001";
				end case;
			end if;
		end if;
	end process;
end behave;