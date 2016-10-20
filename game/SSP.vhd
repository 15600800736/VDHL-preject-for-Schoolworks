


--SSP.vhd
--Stone Scissors and paper
------------------------------
--After pressing ready,
--A and B select Stone Scissors or Paper by turn with an confirmation
--After pressing show,
--the matrix shows what's the selection and judge who is the winner
--with showing the score in digitron




library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--Module1:FrequencyDivision
--FrequencyDivision to provide a certain frequecy to another module
entity frequency_division is
	port(
		clk_in:in std_logic;
		clk_out:out std_logic
		);
end frequency_division;


architecture behave of frequency_division is
	signal counter:integer range 0 to 10;
	signal Q:std_logic;
begin
	process(clk_in)
	begin
		if(clk_in'event and clk_in = '1')then
				if(counter = 10)then
					counter <= 0;
					Q <= not Q;
				else
					counter <= counter + 1;
				end if;
				clk_out <= Q;
		end if;
	end process;
end behave;

--Module2:Controller
--the Logic judgement module
--including win or lose,if a button pressed and tack different actions for diffrent input
--then output result to control Digitron and matirx

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity control is
	--game stype:a select,b select and state to wait ready
	port(
		clk_in:in std_logic;
		--game start signal
		start:in std_logic;
		--game ready signal
		ready:in std_logic;
		--A and B select signal
		-- 0 for stone
		-- 1 for scissors
		-- 2 for paper
		a_select_in,b_select_in:in integer range 0 to 2;
		--A and B ok signal
		a_ok,b_ok:in std_logic;
		--Game's result:one of A and B win or no result
		--0 no result
		--1 A win
		--2 B win
		a_score_out,b_score_out:out integer range 0 to 2;
		result:out integer range 0 to 2		
		);
end control;


architecture behave of control is
		type state_type is (s0,s1,a,b);
		signal game_state:state_type:= s0;
		--A and B score to tell the digitron to show
		--intialize
		begin
		process(clk_in,start)
		variable a_score,b_score:integer range 0 to 3;
		begin
			if(clk_in'event and clk_in = '1')then 
				case game_state is
				when s0=>
					if(start = '1')then
						game_state <= s1;
					end if;
				when s1=>
					if(ready = '1')then
						game_state <= a;
					end if;
				when a=>
					if(a_ok = '1')then
						game_state <= b;
					end if;
				when b=>
					if(b_ok = '1')then
						if(a_select_in = 0)then
							if(b_select_in = 1)then
								a_score := a_score + 1;
								if(a_score = 3)then
									result <= 1;
								end if;
							elsif(b_select_in = 2)then
								b_score := b_score +1;
								if(b_score = 3)then
									result <= 2;
								end if;
							end if;
						elsif(a_select_in = 1)then
							if(b_select_in = 2)then
								a_score := a_score + 1;
								if(a_score = 3)then
									result <= 2;
								end if;
							elsif(b_select_in = 0)then
								b_score := b_score +1;
								if(b_score = 3)then
									result <= 2;
								end if;
							end if;
						elsif(a_select_in = 2)then
							if(b_select_in = 0)then
								a_score := a_score + 1;
								if(a_score = 3)then
									result <= 2;
								end if;
							elsif(b_select_in = 1)then
								b_score := b_score +1;
								if(b_score = 3)then
									result <= 2;
								end if;
							end if;
						end if;
						a_score_out <= a_score;
						b_score_out <= b_score;
						game_state <= s0;
					end if;
				when others =>
					--do nothing;
				end case;
			end if;
		end process;
end behave;
		
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SSP is
		port
		(
		clk_in:in std_logic;
		start_in:in std_logic;
		show:in std_logic;
		a_score:in integer range 0 to 3;
		b_score:in integer range 0 to 3;
		digitron_cat:out std_logic_vector(5 downto 0);
		digitron_show:out std_logic_vector(6 downto 0)
		);
end SSP;

architecture behave of SSP is
		signal counter:std_logic;
		process(clk_in)
		begin
		variable a_score_tmp,b_score_tmp:integer range 0 to 3;
		if(clk_in'event and clk_in = '1')then
			if(start== '1')then
				digitron_cat <= "000000";
				digitron_show <= "0000001";
			else
				counter = not counter;
				a_score_tmp := a_score;
				b_score_tmp := b_score;
				case count is
					when '0'=>
						digitron_cat <= "011111";
							case a_score_tmp is
								when 0=>digitron_show<="1111110";
								when 1=>digitron_show<="0110000";
								when 2=>digitron_show<="1101101";
								when 3=>digitron_show<="1111001";
								when others=>digitorn_show<="1111111";
							end case;
					when '1'=>
						digitron_cat <= "101111";
							case b_score_tmp is
								when 0=>digitron_show<="1111110";
								when 1=>digitron_show<="0110000";
								when 2=>digitron_show<="1101101";
								when 3=>digitron_show<="1111001";
								when others=>digitorn_show<="1111111";
							end case;
					when others=>
						digitron_cat<="0000001";
					end case;
				end if;
			end if;
		end if;
	end process;
end behave;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		