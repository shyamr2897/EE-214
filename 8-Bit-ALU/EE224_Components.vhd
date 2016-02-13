library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package EE224_Components is
	component INVERTER is
		port (a: in std_ulogic; b : out std_ulogic);
   	end component;

  	component AND2 is
		port (a, b: in std_ulogic; c : out std_ulogic);
   	end component;

	component OR2 is
		port (a, b: in std_ulogic; c : out std_ulogic);
   	end component;

	component XOR2 is 
		port (a,b: in std_ulogic; c: out std_ulogic);
	end component;

	component FullAdder is
		port (x, y, ci: in std_ulogic; s, co: out std_ulogic);
	end component;

	component EightBitAdder is
		port (x,y: in std_logic_vector (7 downto 0); 
		  	s: out std_logic_vector (7 downto 0));
	end component;

	component EightBitSubtractor is
		port (x,y: in std_logic_vector (7 downto 0); 
		  	s: out std_logic_vector (7 downto 0));
	end component;
	
	component TwosComplement is 
		port (x: in std_logic_vector (7 downto 0); 
		  	t: out std_logic_vector (7 downto 0));
	end component;

	component Multiplexer is
		port(a, b, s: in std_ulogic; c: out std_ulogic);
	end component;

	component ShiftLeft is
		port (x,y: in std_logic_vector (7 downto 0);
		  	r: out std_logic_vector (7 downto 0));
	end component;

	component ShiftRight is
		port (x,y: in std_logic_vector (7 downto 0);
		  	r: out std_logic_vector (7 downto 0));
	end component;

	component FourOneMux is
		port (a, b, c, d: in std_ulogic; s: in std_logic_vector (1 downto 0);
			o: out std_ulogic);
	end component;

end EE224_Components;

