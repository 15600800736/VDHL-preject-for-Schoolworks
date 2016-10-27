

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--Module1:FrequencyDivision
--FrequencyDivision to provide a certain frequecy to another module
entity frequency_division is
	port(
		clk_in_f:in std_logic;
		clk_out_f:out std_logic
		);
end frequency_division;


architecture behave of frequency_division is
	signal counter_f:integer range 0 to 10;
	signal Q_f:std_logic;
begin
	process(clk_in_f)
	begin
		if(clk_in_f'event and clk_in_f = '1')then
				if(counter_f = 6)then
					counter_f <= 0;
					Q_f <= not Q_f;
				else
					counter_f <= counter_f + 1;
				end if;
				clk_out_f <= Q_f;
		end if;
	end process;
end behave;