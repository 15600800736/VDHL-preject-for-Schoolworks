
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SSP is
		port(
		clk_in:in std_logic;
		col_in:in std_logic_vector(3 downto 0);
		row_out:out std_logic_vector(3 downto 0);
		start_out,ready_out,show_out,a_ok_out,b_ok_out:out std_logic;
		a_select_out,b_select_out:out integer range 0 to 3;
		st,re,sh,ao,bo:out std_logic;
		as,bs:out integer range 0 to 3;
		a_select_final,b_select_final:out integer range 0 to 3
		);
end SSP;


architecture top of SSP is
component frequency_division is
port(
	clk_in_f:in std_logic;
	clk_out_f:out std_logic
	);
end component;
component translate is
		port(
		clk_in_row:in std_logic;
		clk_in_col:in std_logic;
		col_in_t:in std_logic_vector(3 downto 0);
		row_out_t:out std_logic_vector(3 downto 0);
		start_out_t,ready_out_t,show_out_t,a_ok_out_t,b_ok_out_t:out std_logic;
		a_select_out_t,b_select_out_t:out integer range 0 to 3
		);
end component;
component prevent_shake is
		port(
		clk_in_p:in std_logic;
		start_in_p,ready_in_p,show_in_p,a_ok_in_p,b_ok_in_p:in std_logic;
		a_select_in_p,b_select_in_p:in integer range 0 to 2;
		start_out_p,ready_out_p,show_out_p,a_ok_out_p,b_ok_out_p:out std_logic;
		a_select_out_p,b_select_out_p:out integer range 0 to 3;
		-----
		st,re,sh,ao,bo:out std_logic;
		as,bs:out integer range 0 to 3
		);
end component;
component get_select is
		port(
			clk_in_g:in std_logic;
			start_in_g:in std_logic;
			ready_in_g:in std_logic;
			a_ok_in_g:in std_logic;
			b_ok_in_g:in std_logic;
			a_select_in_g,b_select_in_g:in integer range 0 to 3;
			a_select_out_g,b_select_out_g:out integer range 0 to 3
			);
end component;
	signal clk_out:std_logic;
	signal start,ready,show,a_ok,b_ok:std_logic;
	----------------------------------------------------
	signal start2,ready2,show2,a_ok2,b_ok2:std_logic;
	-----------------------------------------------------
	signal a_select,b_select:integer range 0 to 3;
	signal a_select_long,b_select_long:integer range 0 to 3;
	-----------------------------------------------
	signal a,b,c,d,e:std_logic;
	signal f,g:integer range 0 to 3;
	begin
	U1:frequency_division port map(clk_in,clk_out);
	U2:translate port map(clk_out,clk_in,col_in,row_out,start,ready,show,a_ok,b_ok,a_select,b_select);
	U3:prevent_shake port map(clk_in,start,ready,show,a_ok,b_ok,a_select,b_select,start_out,ready_out,show_out,a_ok_out,b_ok_out,a_select_out,b_select_out,st,re,sh,ao,bo,as,bs);
	U4:prevent_shake port map(clk_in,start,ready,show,a_ok,b_ok,a_select,b_select,start2,ready2,show2,a_ok2,b_ok2,a_select_long,b_select_long,a,b,c,d,e,f,g);
	U5:get_select port map(clk_in,start2,ready2,a_ok2,b_ok2,a_select_long,b_select_long,a_select_final,b_select_final);
end top;	