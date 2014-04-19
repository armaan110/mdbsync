module MDP3_Parser(
	input clk,
	input done, //when we've completely received one message
	input logic [1:2] ACTION, //assume each message is 8 bytes
	input logic[3:4] PRICE,
	input logic[5:6] QUANTITY,
	input logic[7:8] NUM_ORDERS,
	input logic[9:10] ENTRY_TYPE,
	output logic orderbook_ready //let next block know message is ready might need more?
	);
	

	logic reset = 1'b1; //if reset is 1 reset to initial state

	always_ff @(posedge clk) begin
		if(reset) begin

		end else begin

		end
	end
	
	

endmodule
