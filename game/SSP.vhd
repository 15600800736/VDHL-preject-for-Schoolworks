


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
entity SSP is
	port(
		clk_in:in std_logic;
		--game start signal
		reset:in std_logic;
		--game ready signal
		ready:in std_logic;
		--judge and show signal
		show:in std_logic;
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
		result:out integer range 0 to 2;
		--signal to tell matrix show A and B's selection
		a_select_out,b_select_out:out integer range 0 to 2;
		--A and B score to tell the digitron to show
		a_score_out,b_score_out:out integer range 0 to 3
		);
end SSP;


architecture behave of SSP is
		--game stype:a select,b select and state to wait ready
		type state_type is (s0,a,b,judge,over);
		signal game_state:state_type;
		--A and B score to tell the digitron to show
		signal a_score,b_score:integer range 0 to 3;
		--intialize
		begin
		process(clk_in,reset)
		begin
			if(reset = '1')then
				a_score <= 0;
				b_score <= 0;
				result <= 0;
				game_state <= s0;
			elsif(clk_in'event and clk_in = '1')then 
				case game_state is
				when s0=>
					if(ready = '1')then
						game_state <= a;
					end if;
				when a=>
					if(a_ok = '1')then
						a_select_out <= a_select_in;
						game_state <= b;
					end if;
				when b=>
					if(b_ok = '1')then
						b_select_out <= b_select_in;
						game_state <= judge;
					end if;
				when judge=>
					if(a_select_in = 0)then
						if(b_select_in = 1)then
							a_score <= a_score + 1;
							if(a_score = 3)then
								result <= 1;
							end if;
						elsif(b_select_in = 2)then
							b_score <= b_score +1;
							if(b_score = 3)then
								result <= 2;
							end if;
						end if;
					elsif(a_select_in = 1)then
						if(b_select_in = 2)then
							a_score <= a_score + 1;
							if(a_score = 3)then
								result <= 2;
							end if;
						elsif(b_select_in = 0)then
							b_score <= b_score +1;
							if(b_score = 3)then
								result <= 2;
							end if;
						end if;
					elsif(a_select_in = 2)then
						if(b_select_in = 0)then
							a_score <= a_score + 1;
							if(a_score = 3)then
								result <= 2;
							end if;
						elsif(b_select_in = 1)then
							b_score <= b_score +1;
							if(b_score = 3)then
								result <= 2;
							end if;
						end if;
					end if;
					a_score_out <= a_score;
					b_score_out <= b_score;
					game_state <= s0;
				when others =>
					--do nothing;
				end case;
			end if;
		end process;
end behave;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		