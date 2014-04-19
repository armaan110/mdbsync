module MDP3_Parser(
	input clk,
	input done, //when we've completely received one message
	input logic [63:0] MESSAGE, //assume each message is 8 bytes
	output logic[7:0] NUM_ORDERS,
	output logic[15:0] QUANTITY,
	output logic[63:0] PRICE,
	output logic[1:0] ACTION, ENTRY_TYPE,
	output logic message_ready //let next block know message is ready
	);
	
	int bus_count = 0;
	logic reset = 1'b1; //if reset is 1 reset to initial state
	logic test = 1'b0;
	logic [63:0] PRICE_TEMP;
	
	//if reset, reset all data
	always_ff @(posedge clk) begin
		if(reset) begin
			message_ready <= 1'b0;
			bus_count = 0;
			reset <= 1'b0;
		end else begin
			case(bus_count)
				0: begin
					bus_count += 1;
				end
				1: begin
					ACTION <= MESSAGE[25 -: 1];
					ENTRY_TYPE <= MESSAGE[17 -: 1];
					bus_count += 1;
				end
				2: begin 
					PRICE_TEMP[63 -: 16] <= MESSAGE[15 -: 16];
					bus_count += 1; 
				end
				3: begin 
					PRICE_TEMP[47 -: 48] <= MESSAGE[63 -:48];
					QUANTITY <= changeEndian16(MESSAGE [15 -: 16]);
					bus_count += 1;
				end
				4: begin 
					NUM_ORDERS <= MESSAGE[63 -: 8];
					PRICE <= changeEndian64(PRICE_TEMP);
					message_ready <= 1'b1;
					reset <= 1'b1;
				end
			endcase
		end //end else
	end //end always_ff
	
	function [15 : 0] changeEndian16;
		input [15:0] value;
		changeEndian16 = {value[7 -: 8], value[15 -: 8]};
	endfunction	
	
	function [23:0] changeEndian24;
		input [23:0] value;
		changeEndian24 = {value[7 -: 8], value[15 -: 8], value[23 -: 8]};
	endfunction	
	
	function [31:0] changeEndian32;
		input [31:0] value;
		changeEndian32 = {value[7 -: 8], value[15 -: 8], value[23 -: 8], value[31 -: 8]};
	endfunction	
	
	function [39:0] changeEndian40;
		input [39:0] value;
		changeEndian40 = {value[7 -: 8], value[15 -: 8], value[23 -: 8], value[31 -: 8], value[39 -: 8]};
	endfunction	
	
	function [47:0] changeEndian48;
		input [47:0] value;
		changeEndian48 = {value[7 -: 8], value[15 -: 8], value[23 -: 8], value[31 -: 8], value[39 -: 8], value [47 -: 8]};
	endfunction	
	
	function [55:0] changeEndian56;
		input [55:0] value;
		changeEndian56 = {value[7 -: 8], value[15 -: 8], value[23 -: 8], value[31 -: 8], value[39 -: 8], value [47 -: 8], value[55 -: 8]};
	endfunction
	
	function [63:0] changeEndian64;
		input [63:0] value;
		changeEndian64 = {value[7 -: 8], value[15 -: 8], value[23 -: 8], value[31 -: 8], value[39 -: 8], value [47 -: 8], value[55 -: 8], value[63 -: 8]};
	endfunction	
	
//	always @(posedge clk) begin
//		ACTION <= MESSAGE[193:192];
//		ENTRY_TYPE <= MESSAGE[185:184];
//		NUM_ORDERS <= MESSAGE[39:32];
//		QUANTITY <= {MESSAGE[47:40],MESSAGE[55:48]};
//		PRICE <= {MESSAGE[63:56], MESSAGE[71:64], MESSAGE[79:72], MESSAGE[87:80]
//					, MESSAGE[95:88], MESSAGE[103:96], MESSAGE[111:104], MESSAGE[119:112]};
//	end
endmodule