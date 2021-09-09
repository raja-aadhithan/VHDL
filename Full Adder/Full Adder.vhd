--structural style of coding: 

--code for or gate:

library ieee; --library instantiation
use ieee.std_logic_1164.all; 
entity or_gate is port ( a,b : in std_logic; y : out std_logic); end or_gate; -- entity of or gate

architecture model_or of or_gate is --architecture of or gate
	begin y <= a or b;
end model_or; -- end architecture


--code for xor gate:

library ieee; --library instantiation
use ieee.std_logic_1164.all;
entity xor_gate is port ( a,b : in std_logic; y : out std_logic); end xor_gate; --entity of xor gate

architecture model_xor of xor_gate is --architecture of xor gate
	begin y <= a xor b;
end model_xor; -- end architecture


--code for and gate:

library ieee; --library instantiation
use ieee.std_logic_1164.all;
entity and_gate is port ( a,b : in std_logic; y : out std_logic); end and_gate; --entity of and gate

architecture model_and of and_gate is --architecture of and gate
	begin y <= a and b;
end model_and; -- end architecture


--code for full adder:

library ieee; --library instantiation
use ieee.std_logic_1164.all;

entity Full_Adder is --entity of full adder
    Port ( a, b, cin : in  STD_LOGIC; -- input bits
           sum, cout : out  STD_LOGIC ); -- output bins
end Full_Adder; -- end entity

architecture structural of Full_Adder is -- architecture of full adder
	
	component or_gate port( a,b : in std_logic ; y : out std_logic); end component; --instantiating or gate inside full adder
	component and_gate port( a,b : in std_logic ; y : out std_logic); end component; --instantiating and gate inside full adder
	component xor_gate port( a,b : in std_logic ; y : out std_logic); end component; --instantiating xor gate inside full adder

	signal x,w,u,v,p : std_logic; --instantiating wires to be used

	begin
		x1: xor_gate port map(a,b,x); --portmapping the components to signals
		x2: xor_gate port map(cin,x,sum);
		a1: and_gate port map(a,b,w);
		a2: and_gate port map(cin,b,u);
		a3: and_gate port map(a,cin,v);
		o1: or_gate port map(w,u,p);
		o2: or_gate port map(v,p,cout);

end structural; -- end architecture


-- testbench of full adder

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY full_adder_tb IS
END full_adder_tb;
 
ARCHITECTURE behavior OF full_adder_tb IS 
 
    COMPONENT full_adder
    PORT(a,b,cin : IN  std_logic;
         sum,cout : OUT  std_logic);
    END COMPONENT;
 
	signal a,b,cin,cout,sum : std_logic;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Full_Adder PORT MAP (
          a => a,
          b => b,
          cin => cin,
          sum => sum,
          cout => cout
        );
	process begin
	
	a <= '0';
	b <= '0';
	cin <= '0';
	wait for 100 ns;
	
	a <= '0';
	b <= '0';
	cin <= '1';
	wait for 100 ns; 
	
	a <= '0';
	b <= '1';
	cin <= '0';
	wait for 100 ns;
	
	a <= '0';
	b <= '1';
	cin <= '1';
	wait for 100 ns;
	
	a <= '1';
	b <= '0';
	cin <= '0';
	wait for 100 ns;
	
	a <= '1';
	b <= '0';
	cin <= '1';
	wait for 100 ns;
	
	a <= '1';
	b <= '1';
	cin <= '0';
	wait for 100 ns;
	
	a <= '1';
	b <= '1';
	cin <= '1';
	wait for 100 ns;
	end process;
	
END; 




--behavioral style of coding: 

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
	port (a, b, cin : in std_logic; sum, cout : out std_logic); --signal instatiation
end entity;

architecture behavioral of full_adder is begin --architecture of full adder
	process(a,b,cin) begin -- sensiivity list is given
		if (a = '0' and b = '0' and cin = '0') then sum <= '0'; cout <= '0'; 
		elsif (a = '0' and b = '0' and cin = '1') then sum <= '1'; cout <= '0'; 
		elsif (a = '0' and b = '1' and cin = '0') then sum <= '1'; cout <= '0'; 
		elsif (a = '0' and b = '1' and cin = '1') then sum <= '0'; cout <= '1'; 
		elsif (a = '1' and b = '0' and cin = '0') then sum <= '1'; cout <= '0'; 
		elsif (a = '1' and b = '0' and cin = '1') then sum <= '0'; cout <= '1'; 
		elsif (a = '1' and b = '1' and cin = '0') then sum <= '0'; cout <= '1'; 
		elsif (a = '1' and b = '1' and cin = '1') then sum <= '1'; cout <= '1'; 
		else sum <= 'X'; cout <= 'X'; --for unknown value of inputs
		end if;
	end process;
end behavioral; -- end architechture

--testbench 2 of full adder

library ieee;
use ieee.std_logic_1164.all;
 
entity full_adder_tb is
end full_adder_tb;
 
architecture behavior of full_adder_tb is 
 
    component full_adder
		port(a,b,cin : IN  std_logic; sum,cout : OUT  std_logic);
    end component;
 
	 signal a,b,cin,cout,sum : std_logic;

	 begin

   uut: full_adder port map( a => a, b => b, cin => cin, sum => sum, cout => cout );
	
	a <= '0', '1' after 400 ns;
	b <= '0', '1' after 200 ns, '0' after 400 ns, '1' after 600 ns;
 cin<='0','1' after 100 ns,'0' after 200 ns,'1' after 300 ns,'0' after 400ns,'1' after 500 ns,'0' after 600 ns,'1' after 700 ns;

end behavior; 



--DATA FLOW

library ieee; -- library instantiation 
use ieee.std_logic_1164.all;

entity full_adder is -- entity
	port (a, b, cin : in std_logic; sum, cout : out std_logic); -- input and output instantiation
end entity;

architecture data_flow of full_adder is begin -- architecture of full adder
	sum <= a xor b xor cin; -- logic for sum 
	cout <= ( a and b ) or ( a and cin ) or ( b and cin ); -- logic for C out
end data_flow;	