library ieee;
use ieee.std_logic_1164.all;
entity seq is port(clk,rst,i : in std_logic; q : out std_logic); end seq;

architecture behave of seq is 
	signal y1,y2,y3 : std_logic;
	begin
		process (clk) begin
			if (clk = '1' and rst = '1')then q <= '0';
			elsif(clk = '1' and rst = '0') then
				y1 <= i;
				y2 <= y1;
				y3 <= y2;
				q <= y3 and (not y2) and y1;
			end if;
		end process;
end behave;

library ieee;
use ieee.std_logic_1164.all;
entity tb is end tb;
architecture test of tb is
	component seq is port(clk,rst,i : in std_logic; q : out std_logic); end component;
	signal clk,rst,i :std_logic := '0';
	signal q: std_logic;
	
	begin uut: seq port map( clk => clk, rst => rst, i => i, q => q);
	clock : process begin
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
			wait for 10 ns;
		end process;
		
	stim : process begin
			rst <= '1' after 50 ns,'0' after 100 ns;
			i <= '1' after 120 ns, '0' after 140 ns, '1' after 160 ns, '0' after 180 ns, '1' after 200 ns,
					 '0' after 230 ns, '1' after 250 ns, '0' after 270 ns, '1' after 290 ns, '0' after 380 ns,
					 '1' after 400 ns, '0' after 420 ns, '1' after 430 ns, '0' after 470 ns, '1' after 540 ns,
					 '0' after 560 ns, '1' after 580 ns, '0' after 600 ns, '1' after 620 ns, '1' after 640 ns;
			wait;
		end process; 
end test;
	