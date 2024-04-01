set_property PACKAGE_PIN K17 [get_ports clk]
set_property PACKAGE_PIN M19 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports rx_in]
set_property IOSTANDARD LVCMOS33 [get_ports tx_done]
set_property IOSTANDARD LVCMOS33 [get_ports tx_out]

set_property IOSTANDARD LVCMOS33 [get_ports {rx_state[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_state[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_state[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {tx_state[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_state[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_state[2]}]


set_property PACKAGE_PIN N20 [get_ports {rx_state[0]}]
set_property PACKAGE_PIN P20 [get_ports {rx_state[1]}]
set_property PACKAGE_PIN T20 [get_ports {rx_state[2]}]

set_property PACKAGE_PIN P18 [get_ports {tx_state[2]}]
set_property PACKAGE_PIN P19 [get_ports {tx_state[1]}]
set_property PACKAGE_PIN R18 [get_ports {tx_state[0]}]

set_property PACKAGE_PIN T12 [get_ports tx_done]
set_property PACKAGE_PIN P15 [get_ports rx_in]
set_property PACKAGE_PIN U15 [get_ports tx_out]


create_clock -period 5.000 -name clk -waveform {0.000 2.500} [get_ports clk]

