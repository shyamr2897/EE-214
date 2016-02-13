library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity EightBitSubtractor is
	port(x,y: in std_logic_vector (7 downto 0);
		s: out std_logic_vector(7 downto 0));
end entity;

architecture Struct of EightBitSubtractor is
	signal t: std_logic_vector (7 downto 0);
begin
	t0: TwosComplement port map (x => y, t => t);

	e1: EightBitAdder port map (x => x, y => t, s => s);
end Struct;
	 