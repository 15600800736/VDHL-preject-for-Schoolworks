
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test_button is
	port(
		clk_in:in std_logic;
		row_in:in std_logic_vector(3 downto 0);
		col_out:out std_logic_vector(3 downto 0);
		digitron_cat:out std_logic_vector(5 downto 0);
		digitron_show:out std_logic_vector(6 downto 0)
		);
end test_button;

architecture behave of test_button is
	component frequency_division is
	port(
		clk_in_f:in std_logic;
		clk_out_f:out std_logic
		);
	end component;
	component translate is
			port(
			clk_in_col:in std_logic;
			clk_in_row:in std_logic;
			row_in_t:in std_logic_vector(3 downto 0);
			col_out_t:out std_logic_vector(3 downto 0);
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
			a_select_out_p,b_select_out_p:out integer range 0 to 3
			);
	end component;
	component digitron is
		port
		(
		clk_in_d:in std_logic;
		st,re,sh,ao,bo:in std_logic;
		as,bs:in integer range 0 to 3;
		dcat:out std_logic_vector(5 downto 0);
		dshow:out std_logic_vector(6 downto 0)
		);
	end component;
	component get_select is
		port(
			clk_in_g:in std_logic;
			start_in_g:in std_logic;
			ready_in_g:in std_logic;
			a_ok_in_g:in std_logic;
			b_ok_in_g:in std_logic;
			show_in_g:in std_logic;
			a_select_in_g,b_select_in_g:in integer range 0 to 3;
			a_select_out_g,b_select_out_g:out integer range 0 to 3;
			show_out_g,a_ok_out_g,b_ok_out_g:out std_logic
			);
	end component;
	signal clk_out:std_logic;
	signal start,ready,show,a_ok,b_ok:std_logic;
	signal a_select,b_select:integer range 0 to 3;
	signal start2,ready2,show2,a_ok2,b_ok2:std_logic;
	signal a_select2,b_select2,a_select_out,b_select_out:integer range 0 to 3;
	signal a_score_tmp,b_score_tmp:integer range 0 to 3;
	signal a_select_final,b_select_final:integer range 0 to 3;
	signal show_final,a_ok_final,b_ok_final:std_logic;
	begin
	U1:frequency_division port map(clk_in,clk_out);
	U2:translate port map(clk_out,clk_in,row_in,col_out,start,ready,show,a_ok,b_ok,a_select,b_select);
	U3:prevent_shake port map(clk_in,start,ready,show,a_ok,b_ok,a_select,b_select,start2,ready2,show2,a_ok2,b_ok2,a_select2,b_select2);
	U10:get_select port map(clk_in,start2,ready2,a_ok2,b_ok2,show2,a_select2,b_select2,a_select_final,b_select_final,show_final,a_ok_final,b_ok_final);
	U4:digitron port map(clk_in,start2,ready2,show2,a_ok_final,b_ok_final,a_select_final,b_select_final,digitron_cat,digitron_show);
end behave;