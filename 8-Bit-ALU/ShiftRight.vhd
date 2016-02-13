library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ShiftRight is
	port (x,y: in std_logic_vector (7 downto 0);
		r: out std_logic_vector (7 downto 0));
end entity;

architecture Struct of ShiftRight is
	signal p, q: std_logic_vector (7 downto 0);
begin
	p(0)<=x(7);
	p(1)<=x(6);
	p(2)<=x(5);
	p(3)<=x(4);
	p(4)<=x(3);
	p(5)<=x(2);
	p(6)<=x(1);
	p(7)<=x(0);

	sl: ShiftLeft port map (x=>p, y=>y, r=>q);

	r(0)<=q(7);
	r(1)<=q(6);
	r(2)<=q(5);
	r(3)<=q(4);
	r(4)<=q(3);
	r(5)<=q(2);
	r(6)<=q(1);
	r(7)<=q(0);
end Struct;
