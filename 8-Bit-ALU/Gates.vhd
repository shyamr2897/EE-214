library ieee;
use ieee.std_logic_1164.all;
entity INVERTER is
  port (a: in std_ulogic;
         b: out std_ulogic);
end entity INVERTER;
architecture Behave of INVERTER is
begin
  b <= not a;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity ANDTwo is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity ANDTwo;
architecture Behave of ANDTwo is
begin
  c <= a and b;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity ORTwo is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity ORTwo;
architecture Behave of ORTwo is
begin
  c <= a or b;
end Behave;
