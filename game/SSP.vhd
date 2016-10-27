

							
			
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity SSP is
		port
		(
		clk_in:in std_logic;
		col_in:in std_logic_vector(3 downto 0);
		row_out:out std_logic_vector(3 downto 0);
		digitron_cat:out std_logic_vector(5 downto 0);
		digitron_show:out std_logic_vector(6 downto 0);
		row_matrix:out std_logic_vector(7 downto 0);
		col_matrix:out std_logic_vector(7 downto 0)
		);
end SSP;

architecture behave of SSP is
component button is
		port(
		clk_in_b:in std_logic;
		col_in_b:in std_logic_vector(3 downto 0);
		start_out_b,ready_out_b,show_out_b,a_ok_out_b,b_ok_out_b:out std_logic;
		a_select_out_b,b_select_out_b:out integer range 0 to 2;
		row_out_b:out std_logic_vector(3 downto 0)
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
component matrix is
		port(
		clk_in_m:in std_logic;
		start_in_m:in std_logic;
		ready_in_m:in std_logic;
		show_in_m:in std_logic;
		result_in_m:in integer range 0 to 2;
		a_select_in_m,b_select_in_m:in integer range 0 to 2;
		col_out_m,row_out_m:out std_logic_vector(7 downto 0)
		);
end component;
component frequency_division is
	port(
		clk_in_f:in std_logic;
		clk_out_f:out std_logic
		);
end component;
component prevent_shake is
		port(
		clk_in_p:in std_logic;
		start_in_p,ready_in_p,show_in_p,a_ok_in_p,b_ok_in_p:in std_logic;
		a_select_in_p,b_select_in_p:in integer range 0 to 2;
		start_out_p,ready_out_p,show_out_p,a_ok_out_p,b_ok_out_p:out std_logic;
		a_select_out_p,b_select_out_p:out integer range 0 to 2
		);
end component;
	signal clk_out:std_logic;
	signal row_out_tmp:std_logic_vector(3 downto 0);
	signal start_out_tmp,ready_out_tmp,show_out_tmp,a_ok_out_tmp,b_ok_out_tmp:std_logic;
	signal a_select_out_tmp,b_select_out_tmp,a_score_out_tmp,b_score_out_tmp:integer range 0 to 2;
	signal result_tmp:integer range 0 to 3;
	signal start_out_ps,ready_out_ps,show_out_ps,a_ok_out_ps,b_ok_out_ps:std_logic;
	signal a_select_out_ps,b_select_out_ps:integer range 0 to 2;
	begin
	U1:button port map(clk_out,col_in,start_out_tmp,ready_out_tmp,show_out_tmp,a_ok_out_tmp,b_ok_out_tmp,a_select_out_tmp,b_select_out_tmp,row_out);
	U2:control port map(clk_out,start_out_ps,ready_out_ps,a_select_out_ps,b_select_out_ps,a_ok_out_ps,b_ok_out_ps,a_score_out_tmp,b_score_out_tmp,result_tmp);
	U3:digitron port map(clk_out,start_out_tmp,show_out_tmp,result_tmp,a_score_out_tmp,b_score_out_tmp,digitron_cat,digitron_show);
	U4:matrix port map(clk_out,start_out_ps,ready_out_ps,show_out_ps,result_tmp,a_select_out_ps,b_select_out_ps,col_matrix,row_matrix);
	U5:frequency_division port map(clk_in,clk_out);
	U6:prevent_shake port map(clk_in,start_out_tmp,ready_out_tmp,show_out_tmp,a_ok_out_tmp,b_ok_out_tmp,a_select_out_tmp,b_select_out_tmp,
								start_out_ps,ready_out_ps,show_out_ps,a_ok_out_ps,b_ok_out_ps,a_select_out_ps,b_select_out_ps);
end behave;
