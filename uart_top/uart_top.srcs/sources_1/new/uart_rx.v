module uart_rx(
	input clk,
	input reset_n,
	input rx,
	output rx_done,
	output [2:0] rx_state,
	output reg [7:0] data_out
	);
	
	parameter IDLE = 0, START = 1, DATA = 2, PARITY = 3, STOP = 4, ERROR = 5;
	reg[2:0] state = IDLE; 
	
	parameter CLK_FREQ = 50_000_000;  
	parameter BAUD_RATE = 2_000_000;    
	localparam BIT_DELAY = CLK_FREQ / BAUD_RATE;
	reg [3:0] cnt_data = 0;
	reg [4:0] count = 0;
	wire bit_start = (count == BIT_DELAY);
	
	reg even = 0;
	
	
	always@(posedge clk, negedge reset_n) begin
			if(!reset_n) begin 
					state <= IDLE; 
					data_out <= 8'b0; 
					count <= 0;
					even <= 0;			
				end
			else begin
					count <= count + 1;
					case(state)
						IDLE : begin  
								if(rx) begin 
										state <= IDLE;
										data_out <= 8'b0; 
										count <= 0;
										even <= 0;
									end
								else begin 
									state <= START;
									
									end	
								cnt_data <= 0;
							end
						START : begin
								if(bit_start) begin
										state <= DATA;
										count <= BIT_DELAY;
										cnt_data <= 0; 
									end
							end
						DATA : begin
								if(bit_start) begin 
										if(cnt_data != 8) begin
												state <= DATA;
												data_out[cnt_data] <= rx;
												if(rx) even <= ~even;
												cnt_data <= cnt_data + 1;
											end
										else begin
												cnt_data <= 0;
									            if(rx == even) state <= PARITY;
									            else state <= ERROR;
											end
										count <= 0;
									end
							end
						PARITY : if(bit_start) begin 
									count <= 0;
									state <= STOP;
								end
						STOP: if(bit_start) begin
									if(rx) state <= IDLE;
									else state <= START;
									
									count <= 0;
									even <= 0;
								end
						ERROR: if(bit_start) begin 
									count <= 0;
									if(rx) begin
											state <= IDLE;
										end
									else state <= START;
								end
					endcase					
				end
			
			
		end
	
	
	assign rx_done = (state == STOP);
	assign rx_state = state;
endmodule
