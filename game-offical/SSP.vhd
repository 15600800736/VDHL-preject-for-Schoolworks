
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SSP is
		port(
		clk_in:in std_logic;
		col_in:in std_logic_vector(3 downto 0);
		row_out:out std_logic_vector(3 downto 0);
		col_m:out std_logic_vector(7 downto 0);
		row_m:out std_logic_vector(7 downto 0);
		digitron_cat:out std_logic_vector(5 downto 0);
		digitron_show:out std_logic_vector(6 downto 0)
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
		clk_in_t:in std_logic;
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
		a_select_out_p,b_select_out_p:out integer range 0 to 3
		);
end component;
component control is
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
end component;
component judge is
		port
		(
		clk_in_j:in std_logic;
		start_in_j:in std_logic;
		b_ok_in_j,show_in_j:in std_logic;
		a_select_j,b_select_j:in integer range 0 to 3;
		a_score_j,b_score_j:out integer range 0 to 3;
		result_j:out integer range 0 to 2
		);
end component;
component matrix is
		port(
		clk_in_m:in std_logic;
		start_in_m:in std_logic;
		ready_in_m:in std_logic;
		show_in_m:in std_logic;
		result_in_m:in integer range 0 to 2;
		a_select_in_m,b_select_in_m:in integer range 0 to 3;
		col_out_m,row_out_m:out std_logic_vector(7 downto 0)
		);
end component;
component digitron is
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
end component;
	signal clk_out:std_logic;
	signal start,ready,show,a_ok,b_ok:std_logic;
	signal a_select,b_select:integer range 0 to 3;
	signal start2,ready2,show2,a_ok2,b_ok2:std_logic;
	signal a_select2,b_select2,a_select_out,b_select_out:integer range 0 to 3;
	signal game_state:integer range 0 to 5;
	signal result_tmp:integer range 0 to 2;
	signal a_score_tmp,b_score_tmp:integer range 0 to 3;
	---
	signal a,b,c,d,e:std_logic;
	begin
	U1:frequency_division port map(clk_in,clk_out);
	U2:translate port map(clk_out,col_in,row_out,start,ready,show,a_ok,b_ok,a_select,b_select);
	U3:prevent_shake port map(clk_in,start,ready,show,a_ok,b_ok,a_select,b_select,start2,ready2,show2,a_ok2,b_ok2,a_select2,b_select2);
	----
	--U4:control port map(clk_in,start2,ready2,show2,a_select2,b_select2,a_ok2,b_ok2,g_s);
	U6:judge port map(clk_in,start2,b_ok2,show2,a_select2,b_select2,a_score_tmp,b_score_tmp,result_tmp);
	U8:matrix port map(clk_in,start2,ready2,show2,result_tmp,a_select2,b_select2,col_m,row_m);
	U9:digitron port map(clk_in,start2,show2,result_tmp,a_score_tmp,b_score_tmp,digitron_cat,digitron_show);
end top;	