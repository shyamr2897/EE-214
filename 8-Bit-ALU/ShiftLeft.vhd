library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ShiftLeft is
	port (x,y: in std_logic_vector (7 downto 0);
	r: out std_logic_vector (7 downto 0));
end entity ShiftLeft;

architecture Struct of ShiftLeft is
	signal k, l: std_logic_vector (7 downto 0);
	signal m: std_ulogic := '0';
begin
	m00: Multiplexer port map (a => x(0), b => m, s => y(0), c => k(0));
	m01: Multiplexer port map (a => x(1), b => x(0), s => y(0), c => k(1));
	m02: Multiplexer port map (a => x(2), b => x(1), s => y(0), c => k(2));
	m03: Multiplexer port map (a => x(3), b => x(2), s => y(0), c => k(3));
	m04: Multiplexer port map (a => x(4), b => x(3), s => y(0), c => k(4));
	m05: Multiplexer port map (a => x(5), b => x(4), s => y(0), c => k(5));
	m06: Multiplexer port map (a => x(6), b => x(5), s => y(0), c => k(6));
	m07: Multiplexer port map (a => x(7), b => x(6), s => y(0), c => k(7));

	m10: Multiplexer port map (a => k(0), b => m, s => y(1), c => l(0));
	m11: Multiplexer port map (a => k(1), b => m, s => y(1), c => l(1));
	m12: Multiplexer port map (a => k(2), b => k(0), s => y(1), c => l(2));
	m13: Multiplexer port map (a => k(3), b => k(1), s => y(1), c => l(3));
	m14: Multiplexer port map (a => k(4), b => k(2), s => y(1), c => l(4));
	m15: Multiplexer port map (a => k(5), b => k(3), s => y(1), c => l(5));
	m16: Multiplexer port map (a => k(6), b => k(4), s => y(1), c => l(6));
	m17: Multiplexer port map (a => k(7), b => k(5), s => y(1), c => l(7));

	m20: Multiplexer port map (a => l(0), b => m, s => y(2), c => r(0));
	m21: Multiplexer port map (a => l(1), b => m, s => y(2), c => r(1));
	m22: Multiplexer port map (a => l(2), b => m, s => y(2), c => r(2));
	m23: Multiplexer port map (a => l(3), b => m, s => y(2), c => r(3));
	m24: Multiplexer port map (a => l(4), b => l(0), s => y(2), c => r(4));
	m25: Multiplexer port map (a => l(5), b => l(1), s => y(2), c => r(5));
	m26: Multiplexer port map (a => l(6), b => l(2), s => y(2), c => r(6));
	m27: Multiplexer port map (a => l(7), b => l(3), s => y(2), c => r(7));	
end Struct;
