module uart_tx (
	input clk, 
	input reset_n,
	input [7:0] data,
	input start,
	output reg tx,
	output [2:0] tx_state,
	output tx_done
	);
	
	
	parameter IDLE = 0, DATA = 1, PARITY = 2, STOP = 3;
	reg [2:0] state = IDLE;
	
	parameter CLK_FREQ = 50_000_000;  
	parameter BAUD_RATE = 2_000_000;    
	
	localparam BIT_DELAY = CLK_FREQ / BAUD_RATE;
	reg [3:0] cnt_data = 0;
	reg [4:0] count = 0;
	wire bit_start = (count == BIT_DELAY);
	
	reg even = 0;
	reg [7:0] data_temp;
	always@(posedge clk, negedge reset_n) begin
			
			count <= bit_start ? 0 : count + 1;
			if(!reset_n) begin
					state <= IDLE;
					tx <= 1;
					count <= 0;
					cnt_data <= 0;
					even <= 0;
				end
			else begin
					case(state)
						IDLE: if(!start) begin
									state <= IDLE;
									tx <= 1;
									count <= 0;
									even <= 0; 
									cnt_data <= 0;
								end
							else begin	
									data_temp <= data;
									state <= DATA;
									count <= 0;	
									tx <= 0;
									
									
								end
						DATA: if(bit_start) begin
									if(cnt_data != 8) begin
											state <= DATA;
											tx <= data_temp[cnt_data];
											if(data_temp[cnt_data]) even <= ~even;
											cnt_data <= cnt_data + 1;
										end
									else begin
											cnt_data <= 0;
											state <= PARITY;
											if(even) tx <= 1;
											else tx <= 0;	
										end
								end
						PARITY: if(bit_start) begin
									
									even <= 0;
									state <= STOP;
									
								end
						STOP: if(bit_start) begin 
									data_temp <= 8'b00000000;
									if(start) begin 
											state <= DATA;
											tx <= 0;
										end
									else begin
											state <= IDLE;
											tx <= 1;
										end
									
									
								end
						
						
					endcase
					
				end  
		end
	
	
	
	assign tx_done = (state == STOP);	
	assign tx_state = state;
	
endmodule