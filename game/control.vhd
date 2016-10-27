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
		clk_in_c:in std_logic;
		--game start signal
		start_c:in std_logic;
		--game ready signal
		ready_c:in std_logic;
		--A and B select signal
		-- 0 for stone
		-- 1 for scissors
		-- 2 for paper
		a_select_in_c,b_select_in_c:in integer range 0 to 2;
		--A and B ok signal
		a_ok_c,b_ok_c:in std_logic;
		--Game's result:one of A and B win or no result
		--0 no result
		--1 A win
		--2 B win
		a_score_out_c,b_score_out_c:out integer range 0 to 2;
		result_c:out integer range 0 to 2
		);
end control;


architecture behave of control is
		signal game_state_c:integer range 0 to 2;
		--A and B score to tell the digitron to show
		--intialize
		begin
		process(clk_in_c)
		variable a_score_c,b_score_c:integer range 0 to 3;
		begin
			if(clk_in_c'event and clk_in_c = '1')then 
				if(start_c = '1')then
					game_state_c <= 0;
				end if;
				case game_state_c is
				when 0=>
					if(ready_c = '1')then
						game_state_c <= 1;
					end if;
				when 1=>
					if(a_ok_c = '1')then
						game_state_c <= 2;
					end if;
				when 2=>
					if(b_ok_c = '1')then
						if(a_select_in_c = 0)then
							if(b_select_in_c = 1)then
								a_score_c := a_score_c + 1;
								if(a_score_c = 3)then
									result_c <= 1;
								end if;
							elsif(b_select_in_c = 2)then
								b_score_c := b_score_c +1;
								if(b_score_c = 3)then
									result_c <= 2;
								end if;
							end if;
						elsif(a_select_in_c = 1)then
							if(b_select_in_c = 2)then
								a_score_c := a_score_c + 1;
								if(a_score_c = 3)then
									result_c <= 2;
								end if;
							elsif(b_select_in_c = 0)then
								b_score_c := b_score_c +1;
								if(b_score_c = 3)then
									result_c <= 2;
								end if;
							end if;
						elsif(a_select_in_c = 2)then
							if(b_select_in_c = 0)then
								a_score_c := a_score_c + 1;
								if(a_score_c = 3)then
									result_c <= 2;
								end if;
							elsif(b_select_in_c = 1)then
								b_score_c := b_score_c +1;
								if(b_score_c = 3)then
									result_c <= 2;
								end if;
							end if;
						end if;
						a_score_out_c <= a_score_c;
						b_score_out_c <= b_score_c;
						game_state <= 0;
					end if;
				when others =>
					--do nothing;
				end case;
			end if;
		end process;
end behave;