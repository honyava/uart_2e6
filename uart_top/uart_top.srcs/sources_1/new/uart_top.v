module uart_top(
    input clk,
    input reset,
    
    input rx_in,
    
    output tx_out,
    output tx_done,
    output [2:0] rx_state,
    output [2:0] tx_state

    );
    
    
    wire [2:0] ila_probe0_rx;
    wire [2:0] ila_probe1_tx;
    wire ila_probe2_rxin;
    wire ila_probe3_txout;
    
    assign ila_probe2_rxin = rx_in;
    assign ila_probe3_txout = tx_out;   
    assign ila_probe0_rx = rx_state;   
    assign ila_probe1_tx = tx_state;   
       

/*    ila_0 ila_0_inst
    (
    .clk(clk),
    .probe0(ila_probe0_rx),
    .probe1(ila_probe1_tx),
    .probe2(ila_probe2_rxin),
    .probe3(ila_probe3_txout)
    );*/

    
    
    wire tx_start;
    wire rx_done;
    wire [7:0] tx_data;
    wire [7:0] rx_data_out;

uart_tx uart_tx_inst (
    .clk(clk),
    .data(tx_data),
    .start(rx_done),
    .reset_n(reset),
    .tx(tx_out),
    .tx_state(tx_state),
    .tx_done(tx_done)
);	 


uart_rx uart_rx_inst (
    .clk(clk),
    .reset_n(reset),
    .rx(rx_in),
    .rx_done(rx_done),
    .rx_state(rx_state),
    .data_out(tx_data)
);  

    
endmodule
