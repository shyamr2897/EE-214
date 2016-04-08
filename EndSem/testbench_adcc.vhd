library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;



entity Testbench_ADCC is
end entity;
architecture Behave of Testbench_ADCC is

  signal db_in,db_out: std_logic_vector(7 downto 0);
  signal cs_bar, wr_bar,rd_bar,intr_bar,adc_run ,adc_output_ready: std_logic;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';

  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin
      ret_val := lx;
      return(ret_val);
  end to_string;

  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
    alias lx: bit_vector(1 to x'length) is x;
    variable ret_var : std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_std_logic_vector;

  component adcc is
    port(
        db_in: in std_logic_vector(7 downto 0);
        db_out: out std_logic_vector(7 downto 0);
        cs_bar, wr_bar, rd_bar: out std_logic;
        intr_bar: in std_logic;
        adc_run: in std_logic;
        adc_output_ready: out std_logic;
        clk, reset: in std_logic
);
end component;

begin
  clk <= not clk after 10 ns; -- assume 10ns clock.

  -- reset process
  process
  begin
     wait until clk = '1';
     reset <= '0';
     wait;
  end process;

  process
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "TRACEFILE_ADCC.txt";
    FILE OUTFILE: text  open write_mode is "OUTPUTS_ADCC.txt";

    ---------------------------------------------------
    -- edit the next few lines to customize
    variable db_in_var: bit_vector ( 7 downto 0);
    ----------------------------------------------------
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;

  begin

    wait until clk = '1';

    while not endfile(INFILE) loop
          wait until clk = '0';

          LINE_COUNT := LINE_COUNT + 1;

	  readLine (INFILE, INPUT_LINE);
      read(INPUT_LINE, db_in_var);



          adc_run <= '1';
          intr_bar <= '1';

          while (true) loop
            wait until clk = '1';
            --adc_run <= '0';
            if (wr_bar = '0') then
              db_in <= to_std_logic_vector(db_in_var);
              intr_bar <= '0' after 215 us;
              exit;
            end if;
          end loop;

          -- wait till srd_bary becomes 1
          while (true) loop
            wait until clk = '1';
            if (adc_output_ready = '1') then
            write(OUTPUT_LINE,to_string("readkfjksldjl\n"));
      writeline(OUTFILE, OUTPUT_LINE);
              exit;
            end if;
          end loop;



          --------------------------------------
	  -- check outputs.
	  if (db_out /= to_std_logic_vector(db_in_var)) then
             write(OUTPUT_LINE,to_string("ERROR: in RESULT, line "));
             write(OUTPUT_LINE, LINE_COUNT);
             writeline(OUTFILE, OUTPUT_LINE);
             err_flag := true;
          end if;

    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

  dut: ADCC
     port map(
    cs_bar => cs_bar, wr_bar => wr_bar, rd_bar => rd_bar,
    intr_bar => intr_bar ,
    db_in => db_in,
    adc_run => adc_run,
    adc_output_ready => adc_output_ready,
    db_out => db_out,
    clk => clk, reset => reset);

end Behave;

