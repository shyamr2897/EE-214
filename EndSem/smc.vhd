library ieee;
use ieee.std_logic_1164.all;

entity smc is
    port(
        mc_address: in std_logic_vector (12 downto 0);
		  address: out std_logic_vector (12 downto 0);
        mc_start, mc_write: in std_logic;
        mc_write_data: in std_logic_vector(7 downto 0);
        mc_read_data: out std_logic_vector(7 downto 0);
        mc_done: out std_logic;
        io: inout std_logic_vector(7 downto 0);
        we_bar, oe_bar, cs_bar: out std_logic;
        clk, reset: in std_logic
        );
end entity;

architecture Behave of smc is
    type smc_fsmstate is(reset_state, r_we_to_cs, r_cs_to_oe, r_wait_for_dout, r_read_state, r_cs_oe_high, r_done_state, w_start_to_oe, w_oe_to_cs, w_cs_to_we, w_we_to_valid, w_valid_to_cs, w_cs_to_oe, w_done_state);
    signal fsm_state: smc_fsmstate;
begin
    process(fsm_state, clk, reset, mc_address, mc_start, mc_write, io, mc_write_data)
        variable n_state: smc_fsmstate;
        variable we_bar_var, oe_bar_var, cs_bar_var, mc_done_var: std_logic;
        variable mc_read_data_var, io_var: std_logic_vector (7 downto 0);
		  variable address_var :std_logic_vector(12 downto 0);
        variable op_var: std_logic; --0 for read, 1 for write
    begin
        --defaults
        n_state := fsm_state;
        we_bar_var := '1';
        oe_bar_var := '1';
        cs_bar_var := '1';
        io_var := (others => '0');
        mc_read_data_var := (others => '0');
		  mc_done_var := '0';
        op_var := '0';

        case fsm_state is

            when reset_state =>
                mc_done_var := '0';
                we_bar_var := '1';
                oe_bar_var := '1';
                cs_bar_var := '1';
					 address_var := mc_address;
                if(mc_start = '1') then
                    if(mc_write = '0') then
                        op_var := '0';
                        n_state := r_we_to_cs;
                    else
                        op_var := '1';
                        n_state := w_oe_to_cs;

                    end if;
                else
                    n_state := reset_state;
                end if;

            when r_we_to_cs =>
                we_bar_var := '1';
                oe_bar_var := '1';
                cs_bar_var := '0';
                n_state := r_cs_to_oe;

            when r_cs_to_oe =>
                we_bar_var := '1';
                cs_bar_var := '0';
                oe_bar_var := '0';
                n_state := r_wait_for_dout;

            when r_wait_for_dout =>
                we_bar_var := '1';
                cs_bar_var := '0';
                oe_bar_var := '0';
                n_state := r_read_state;

            when r_read_state =>
                we_bar_var := '1';
                cs_bar_var := '0';
                oe_bar_var := '0';
                n_state := r_cs_oe_high;

            when r_cs_oe_high =>
                cs_bar_var := '1';
                oe_bar_var := '1';
                we_bar_var := '1';
                mc_read_data_var := io;
                n_state := r_done_state;

            when r_done_state =>
                we_bar_var := '1';
                cs_bar_var := '1';
                oe_bar_var := '1';
                n_state := reset_state;
                mc_done_var := '1';

            when w_start_to_oe =>
                n_state := w_oe_to_cs;
                oe_bar_var := '1';
                cs_bar_var := '1';
                we_bar_var := '1';

            when w_oe_to_cs =>
                n_state := w_cs_to_we;
                cs_bar_var := '0';
                oe_bar_var := '1';
                we_bar_var := '1';

            when w_cs_to_we =>
                n_state := w_we_to_valid;
                we_bar_var := '0';
                oe_bar_var := '1';
                cs_bar_var := '0';

            when w_we_to_valid =>
                n_state := w_valid_to_cs;
                we_bar_var := '0';
                oe_bar_var := '1';
                cs_bar_var := '0';

            when w_valid_to_cs =>
                n_state := w_cs_to_oe;
                io_var := mc_write_data;
                cs_bar_var := '1';
                oe_bar_var := '1';
                we_bar_var := '1';

            when w_cs_to_oe =>
                n_state := w_done_state;
                oe_bar_var := '1';
                we_bar_var := '1';
                cs_bar_var := '1';

            when w_done_state =>
                n_state := reset_state;
                oe_bar_var := '1';
                we_bar_var := '1';
                cs_bar_var := '1';
                mc_done_var := '1';
        end case;
			
			address <= address_var;
        if (op_var = '1') then
            io <= io_var;
        else
            mc_read_data <= mc_read_data_var;
        end if;

        mc_done <= mc_done_var;

        if (clk'event and (clk = '1')) then
            cs_bar <= cs_bar_var;
            we_bar <= we_bar_var;
            oe_bar <= oe_bar_var;
            if(reset = '1') then
                fsm_state <= reset_state;
            else
                fsm_state <= n_state;
            end if;
        end if;
    end process;
end Behave;