library ieee;
use ieee.std_logic_1164.all;

entity adcc is
    port(
        db_in: in std_logic_vector(7 downto 0);
        db_out: out std_logic_vector(7 downto 0);
        cs_bar, wr_bar, rd_bar: out std_logic;
        intr_bar: in std_logic;
        adc_run: in std_logic;
        adc_output_ready: out std_logic;
        clk, reset: in std_logic
);
end entity;

architecture Behave of adcc is
    type adcc_fsmstate is(reset_state, wr_high_state, rd_high_state, cs_to_wr, wr_to_intr, intr_to_rd, done_state);
    signal fsm_state : adcc_fsmstate;
begin
    process(fsm_state, db_in, intr_bar, adc_run, clk, reset)
        variable n_state: adcc_fsmstate;
        variable cs_bar_var, wr_bar_var, rd_bar_var: std_logic;
        variable adc_output_ready_var: std_logic;
        variable db_out_var: std_logic_vector(7 downto 0);
        variable wr_cycle, rd_cycle: integer;
    begin
        --defaults
        n_state := fsm_state;
        cs_bar_var := '1';
        wr_bar_var := '1';
        rd_bar_var := '1';
        adc_output_ready_var := '0';

        case fsm_state is
            when reset_state =>
                wr_cycle := 0;
                rd_cycle := 0;
                if(adc_run = '1') then
                    n_state := cs_to_wr;
                else
                    n_state := reset_state;
                end if;

            when cs_to_wr =>
                cs_bar_var := '0';
                n_state := wr_high_state;

            when wr_high_state =>
                cs_bar_var := '0';
                if (wr_cycle < 5) then
                    wr_cycle := wr_cycle + 1;
                    wr_bar_var := '0';
                    n_state := wr_high_state;
                else
                    wr_bar_var := '1';
                    n_state := wr_to_intr;
                end if;

            when wr_to_intr =>
                cs_bar_var := '0';
                if(intr_bar = '0') then
                    n_state := intr_to_rd;
                else
                    n_state := wr_to_intr;
                end if;

            when intr_to_rd =>
                cs_bar_var := '0';
                n_state := rd_high_state;


            when rd_high_state =>
                cs_bar_var := '0';
                if (rd_cycle < 5) then
                    rd_cycle := rd_cycle + 1;
                    rd_bar_var := '0';
                    n_state := rd_high_state;

                else
                    rd_bar_var := '1';
                    n_state := done_state;
                end if;

            when done_state =>
                cs_bar_var := '0';
                adc_output_ready_var := '1';
                db_out_var := db_in;
                n_state := reset_state;
        end case;

        db_out <= db_out_var;
        adc_output_ready <= adc_output_ready_var;

        if (clk'event and (clk = '1')) then
            cs_bar <= cs_bar_var;
            wr_bar <= wr_bar_var;
            rd_bar <= rd_bar_var;
            if(reset = '1') then
                fsm_state <= reset_state;
            else
                fsm_state <= n_state;
            end if;
        end if;
    end process;
end Behave;