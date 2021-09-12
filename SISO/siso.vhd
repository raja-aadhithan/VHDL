-- design code

library ieee;
use ieee.std_logic_1164.all;
entity si_so is port (clk,i : in std_logic; y: out std_logic); end si_so;

architecture behavioral of si_so is signal q1,q2,q3 : std_logic; begin 
		process(clk) begin 
			if(rising_edge (clk))then
				q1 <= i;
				q2 <= q1;
				q3 <= q2;
				y <= q3;
			end if;
		end process;
end behavioral;

-- self checking test bench

library ieee;
use ieee.std_logic_1164.all;
entity tb is end tb;
architecture behaviour of tb is 
	component si_so is port(clk,i : in std_logic; y: out std_logic); end component;
	signal i,clk : std_logic := '0';
	signal y,temp,err : std_logic;
	signal x : integer := 0;
	
	begin uut : si_so port map(clk => clk, i=> i, y =>y);
	
		clk_process : process begin
			clk <= '0';
			wait for 10 ns;
			clk <= '1';
			wait for 10 ns;
		end process;
		
		stim_process : process begin
			i <= '0','1' after 50 ns,'0' after 100 ns, '1' after 150 ns,'0' after 200 ns, '1' after 250 ns,'0' after 300 ns,
					'1' after 350 ns, '1' after 400 ns,'0' after 450 ns, '0' after 500 ns,'1' after 550 ns, '1' after 600 ns,
					'0' after 650 ns, '1' after 700 ns,'1' after 750 ns;
		wait;
		end process; 
		
		check : process 
		 begin
			temp <= i;
			wait until clk'event and clk = '1';
			wait until clk'event and clk = '1';
			wait until clk'event and clk = '1';
			wait until clk'event and clk = '1';
			err <= temp xor y;
			if(err = '1')then x <= x+1; end if;
		end process;
		
		final : process begin
		wait for 800 ns;
		if (x = 0) then report "verification of siso is successfull"; end if;
		end process;
end behaviour;