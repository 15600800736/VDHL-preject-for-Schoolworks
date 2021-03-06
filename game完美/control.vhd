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
		show_c:in std_logic;
		--A and B select signal
		-- 0 for none
		-- 1 for stone
		-- 2 for scissors
		-- 3 for paper
		a_select_in_c,b_select_in_c:in integer range 0 to 3;
		--A and B ok signal
		a_ok_c,b_ok_c:in std_logic;
		game_state_out_c:out integer range 0 to 5
		);
end control;


architecture behave of control is
		signal game_state_c:integer range 0 to 5;
		--A and B score to tell the digitron to show
		--intialize
		begin
		process(clk_in_c)

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
					if(a_select_in_c = 1 or a_select_in_c = 2 or a_select_in_c = 3)then
						game_state_c <= 2;
					end if;
				when 2=>
					if(a_ok_c = '1')then
						game_state_c <= 3;
					end if;
				when 3=>
					if(b_select_in_c = 1 or b_select_in_c = 2 or b_select_in_c = 3)then
						game_state_c <= 4;
					end if;
				when 4=>
					if(b_ok_c = '1')then
						game_state_c <= 5;
					end if;
				when 5=>
					if(ready_c = '1')then
						game_state_c <= 1;
					end if;
				when others =>
					--do nothing;
				end case;
				game_state_out_c <= game_state_c;
			end if;
		end process;
end behave;