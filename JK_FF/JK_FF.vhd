--design code

library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is port (j,k,clk,rst: in std_logic; q,qb: out std_logic); end jk_ff;

architecture ff of jk_ff is 
	begin
	process(j,k,clk,rst) 
		variable temp : std_logic := '0';
		begin
			if (rst = '1') then temp := '0';
			elsif (rising_edge (clk)) then
				if (j /= k) then temp := j;
				elsif (j = '1' and k = '1') then temp := not temp;
				end if;
			end if;
		q <= temp;
		qb <= not temp;
	end process;
end ff;


--testbench1

library ieee;
use ieee.std_logic_1164.all;
entity tb is end tb;

architecture behaviour of tb is 
	component jk_ff is port (j,k,clk,rst : in std_logic; q,qb : out std_logic); end component;
	signal j,k,clk,rst : std_logic := '0';
	signal q,qb :std_logic;
	begin uut : jk_ff port map(j => j, k => k, clk => clk, rst => rst, q => q, qb => qb);
	
		clk_process : process begin
			clk <= '0';
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
		end process;
		
		stim_process : process begin
		
		rst <= '1', '0' after 50 ns;
		j <= '0','1' after 150 ns, '0' after 250 ns, '1' after 350 ns;
		k <= '0','1' after 100 ns, '0' after 150 ns,'1' after 200 ns, '0' after 250 ns,'1' after 300 ns, '0' after 350 ns,'1' after 400 ns;
		wait;
		end process;
end behaviour; 


--testbench2

library ieee;
use ieee.std_logic_1164.all;
entity tb is end tb;

architecture behaviour of tb is 
	component jk_ff is port (j,k,clk,rst : in std_logic; q,qb : out std_logic); end component;
	signal j,k,clk,rst : std_logic := '0';
	signal q,qb :std_logic;
	begin uut : jk_ff port map(j => j, k => k, clk => clk, rst => rst, q => q, qb => qb);
	
		clk_process : process begin
			clk <= '0';
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
		end process;
		
		stim_process : process begin
		
		rst <= '1';
		wait for 50 ns;
		
		rst <= '0';
		j <= '0';
		k <= '0';
		wait for 50 ns;
		
		rst <= '0';
		j <= '0';
		k <= '1';
		wait for 50 ns;
		
		rst <= '0';
		j <= '1';
		k <= '0';
		wait for 50 ns;
		
		rst <= '0';
		j <= '1';
		k <= '1';
		wait for 50 ns;
		
		rst <= '0';
		j <= '0';
		k <= '0';
		wait for 50 ns;
		
		rst <= '0';
		j <= '0';
		k <= '1';
		wait for 50 ns;
		
		rst <= '0';
		j <= '1';
		k <= '0';
		wait for 50 ns;
		
		rst <= '0';
		j <= '1';
		k <= '1';
		wait;
		end process;
end behaviour; 