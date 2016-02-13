--Two bit input XOR gate
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity XOR2 is
	port(a,b: in std_ulogic;
		c: out std_ulogic);
end entity;

architecture Struct of XOR2 is
	signal na, nb, t1, t2: std_ulogic;
begin
	n1: INVERTER port map (a => a, b=> na);
	n2: INVERTER port map (a => b, b=> nb);
	
	a1: AND2 port map (a => a, b => nb, c => t1);
	a2: AND2 port map (a => na, b => b, c => t2);

	o1: OR2 port map (a => t1, b => t2, c => c);

end Struct;

--------------------------------------------------------------------------
-- Two bit input full adder
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FullAdder is
	port(x,y,ci: in std_ulogic;
		s, co: out std_ulogic);
end entity;

architecture Struct of FullAdder is
	signal s1, c1, c2 : std_ulogic;
begin
	x1: XOR2 port map (a => x, b => y, c => s1);
	x2: XOR2 port map (a => s1, b => ci, c => s);

	a1: AND2 port map (a => x, b => y, c => c1);
	a2: AND2 port map (a => ci, b => s1, c => c2);

	o1: OR2 port map (a => c1, b => c2, c => co);
end Struct;

-------------------------------------------------------------------------------
--Two's Complement of an eight bit vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity TwosComplement is
	port (x: in std_logic_vector (7 downto 0);
		t: out std_logic_vector (7 downto 0));
end entity;

architecture Struct of TwosComplement is
	signal i: std_logic_vector (7 downto 0);
	signal o: std_logic_vector (7 downto 0) := "00000001";
begin
	n0: INVERTER port map (a => x(0), b => i(0));
	n1: INVERTER port map (a => x(1), b => i(1));
	n2: INVERTER port map (a => x(2), b => i(2));
	n3: INVERTER port map (a => x(3), b => i(3));
	n4: INVERTER port map (a => x(4), b => i(4));
	n5: INVERTER port map (a => x(5), b => i(5));
	n6: INVERTER port map (a => x(6), b => i(6));
	n7: INVERTER port map (a => x(7), b => i(7));

	f0: EightBitAdder port map (x => i, y => o, s => t);
end Struct;

----------------------------------------------------------------------------
-- 2:1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity Multiplexer is
	port(a, b, s: in std_ulogic; c: out std_ulogic);
end entity;

architecture Struct of Multiplexer is
	signal t1, t2, t3: std_ulogic;
begin
	i1: INVERTER port map (a => s, b => t1);
	
	a1: AND2 port map (a => t1, b => a, c => t2);
	a2: AND2 port map (a => s, b => b, c => t3);

	o1: OR2 port map (a => t2, b => t3, c => c);
end Struct;

-----------------------------------------------------------------------------
--4:1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FourOneMux is
	port (a, b, c, d: in std_ulogic; s: in std_logic_vector (1 downto 0);
		o: out std_ulogic);
end entity;

architecture Struct of FourOneMux is
	signal t1, t2: std_ulogic;
begin
	m1: Multiplexer port map (a => a, b => b, s => s(0), c => t1);
	m2: Multiplexer port map (a => d, b => c, s => s(0), c => t2);

	m3: Multiplexer port map (a => t1, b => t2, s => s(1), c => o);
end Struct;

-----------------------------------------------------------------------------
	



	


