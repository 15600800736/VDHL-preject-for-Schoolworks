


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
--Module1:FrequencyDivision
--FrequencyDivision to provide a certain frequecy to another module
entity FrequencyDivision is
	port(
		clk_in:in std_logic;
		clk_out:out std_logic
		);
end SSP;

architecture behave of FrequencyDivision is
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
entity SSP is
	port(
		start:in std_logic;
		show:in std_logic;
		