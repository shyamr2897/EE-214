Created by Shyam Ramamoorthy on 14/02/16.


Copy all the commands listed below and paste them into the terminal at once to compile all the .vhd files and run the testbenches. 
Note: The final testbench, that of the ALU, takes around 1 minute to run. 
To view the waveforms on gtkwave, use the command: gtkwave <path/to/file.vcd>

ghdl -a EE224_Components.vhd
ghdl -a Gates.vhd
ghdl -a Components.vhd
ghdl -a EightBitAdder.vhd
ghdl -a EightBitSubtractor.vhd
ghdl -a ShiftLeft.vhd
ghdl -a ShiftRight.vhd
ghdl -a ALU.vhd
ghdl -a Testbench_EightBitAdder.vhd
ghdl -m Testbench_EightBitAdder
ghdl -r Testbench_EightBitAdder --stop-time=2000000ns --vcd=add.vcd
ghdl -a Testbench_EightBitSubtractor.vhd
ghdl -m Testbench_EightBitSubtractor
ghdl -r Testbench_EightBitSubtractor --stop-time=2000000ns --vcd=subtract.vcd
ghdl -a Testbench_ShiftLeft.vhd
ghdl -m Testbench_ShiftLeft
ghdl -r Testbench_ShiftLeft --stop-time=2000000ns --vcd=sleft.vcd
ghdl -a Testbench_ShiftRight.vhd
ghdl -m Testbench_ShiftRight
ghdl -r Testbench_ShiftRight --stop-time=2000000ns --vcd=sright.vcd
ghdl -a Testbench_ALU.vhd
ghdl -m Testbench_ALU
ghdl -r Testbench_ALU --stop-time=2000000ns --vcd=alu.vcd


