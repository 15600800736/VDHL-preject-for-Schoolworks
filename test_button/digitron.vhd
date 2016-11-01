
		
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity digitron is
		port
		(
		clk_in_d:in std_logic;
		st,re,sh,ao,bo:in std_logic;
		as,bs:in integer range 0 to 3;
		dcat:out std_logic_vector(5 downto 0);
		dshow:out std_logic_vector(6 downto 0)
		);
end digitron;

architecture behave of digitron is
	signal counter_d:std_logic;
	begin
		process(clk_in_d)
		begin
		if(clk_in_d'event and clk_in_d = '1')then
			dcat <= "011111";
			if(st = '1')then
				dshow <= "0000000";
			elsif(re = '1')then
				dshow <= "1111110";
			elsif(sh = '1')then
				dshow <= "1110000";
			elsif(bs = 1)then
				dshow <= "0110011";
			elsif(bs = 2)then
				dshow <= "1011011";
			elsif(bs = 3)then
				dshow <= "1011111";
			elsif(as = 1)then
				dshow <= "0110000";
			elsif(as = 2)then
				dshow <= "1101101";
			elsif(as = 3)then
				dshow <= "1111001";

			else
				dcat <= "101111";
				dshow <= "0000000";
			end if;
		end if;
	end process;
end behave;