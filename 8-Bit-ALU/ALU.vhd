library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ALU is
	port (x, y: in std_logic_vector(7 downto 0);
		s: in std_logic_vector(1 downto 0);
		c: out std_logic_vector(7 downto 0));
end entity;

architecture Struct of ALU is
	signal EightBitAdd, EightBitSubtract, ShiftL, ShiftR: std_logic_vector(7 downto 0);

begin
	ea: EightBitAdder port map (x => x, y => y, s => EightBitAdd);
	es: EightBitSubtractor port map (x => x, y => y, s => EightBitSubtract);
	sl: ShiftLeft port map (x => x, y => y, r => ShiftL);
	sr: ShiftRight port map (x => x, y => y, r => ShiftR);

	m0: FourOneMux port map (a => EightBitAdd(0), b => EightBitSubtract(0), c => ShiftL(0), d => ShiftR(0), s => s, o => c(0));
	m1: FourOneMux port map (a => EightBitAdd(1), b => EightBitSubtract(1), c => ShiftL(1), d => ShiftR(1), s => s, o => c(1));
	m2: FourOneMux port map (a => EightBitAdd(2), b => EightBitSubtract(2), c => ShiftL(2), d => ShiftR(2), s => s, o => c(2));
	m3: FourOneMux port map (a => EightBitAdd(3), b => EightBitSubtract(3), c => ShiftL(3), d => ShiftR(3), s => s, o => c(3));	
	m4: FourOneMux port map (a => EightBitAdd(4), b => EightBitSubtract(4), c => ShiftL(4), d => ShiftR(4), s => s, o => c(4));	
	m5: FourOneMux port map (a => EightBitAdd(5), b => EightBitSubtract(5), c => ShiftL(5), d => ShiftR(5), s => s, o => c(5));	
	m6: FourOneMux port map (a => EightBitAdd(6), b => EightBitSubtract(6), c => ShiftL(6), d => ShiftR(6), s => s, o => c(6));
	m7: FourOneMux port map (a => EightBitAdd(7), b => EightBitSubtract(7), c => ShiftL(7), d => ShiftR(7), s => s, o => c(7));
end Struct;

	
		