library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity EightBitAdder is
	port(x,y: in std_logic_vector (7 downto 0);
		s: out std_logic_vector(7 downto 0));
end entity;

architecture Struct of EightBitAdder is
	signal m: std_ulogic := '0';
	signal c: std_logic_vector (7 downto 0);
begin
	f0: FullAdder port map (x => x(0), y => y(0), ci => m, s => s(0), co => c(0));
	f1: FullAdder port map (x => x(1), y => y(1), ci => c(0), s => s(1), co => c(1));
	f2: FullAdder port map (x => x(2), y => y(2), ci => c(1), s => s(2), co => c(2));
	f3: FullAdder port map (x => x(3), y => y(3), ci => c(2), s => s(3), co => c(3));
	f4: FullAdder port map (x => x(4), y => y(4), ci => c(3), s => s(4), co => c(4));
	f5: FullAdder port map (x => x(5), y => y(5), ci => c(4), s => s(5), co => c(5));
	f6: FullAdder port map (x => x(6), y => y(6), ci => c(5), s => s(6), co => c(6));
	f7: FullAdder port map (x => x(7), y => y(7), ci => c(6), s => s(7), co => c(7));
end Struct;
