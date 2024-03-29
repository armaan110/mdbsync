/*
 * Avalon memory-mapped peripheral for the VGA LED Emulator
 *
 * Stephen A. Edwards
 * Columbia University
 */

module VGA_LED(input logic        clk,
	       input logic 	  reset,
	       input logic [7:0]  writedata,
	       input logic 	  write,
	       input 		  chipselect,
	       input logic [2:0] address,

	       output logic [7:0] VGA_R, VGA_G, VGA_B,
	       output logic 	  VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_n,
	       output logic 	  VGA_SYNC_n);

	 
   logic [7:0] 			  hex0, hex1, hex2, hex3,
				  hex4, hex5, hex6, hex7;

   VGA_LED_Emulator led_emulator(.clk50(clk), .*);
	logic [295:0] writedata1 = 296'hC0C21C023D0100006803800100007B0000000C000000A0475F3B000000000F0002C9000000;
	logic [3:0] NUM_MD_ENTRIES1, NUM_MD_ENTRIES2, MD_UPDATE_ACTION1, MD_UPDATE_ACTION2, MD_ENTRY_TYPE1, MD_ENTRY_TYPE2,
					NUM_ORDERS1, NUM_ORDERS2;
	logic [7:0] HEX_NUM_MD_ENTRIES1, HEX_NUM_MD_ENTRIES2, HEX_MD_UPDATE_ACTION1, HEX_MD_UPDATE_ACTION2, HEX_MD_ENTRY_TYPE1, HEX_MD_ENTRY_TYPE2,
					HEX_NUM_ORDERS1, HEX_NUM_ORDERS2;
					
					
					
					

	
   hex7seg h0( .a(NUM_MD_ENTRIES1),         .y(HEX_NUM_MD_ENTRIES1) ),
           h1( .a(NUM_MD_ENTRIES2), .y(HEX_NUM_MD_ENTRIES2) ),
           h2( .a(MD_UPDATE_ACTION1), .y(HEX_MD_UPDATE_ACTION1) ),
           h3( .a(MD_UPDATE_ACTION2), .y(HEX_MD_UPDATE_ACTION2) ),
           h4( .a(MD_ENTRY_TYPE1), .y(HEX_MD_ENTRY_TYPE1) ),
           h5( .a(MD_ENTRY_TYPE2), .y(HEX_MD_ENTRY_TYPE2) ),
           h6( .a(NUM_ORDERS1), .y(HEX_NUM_ORDERS1) ),
           h7( .a(NUM_ORDERS2), .y(HEX_NUM_ORDERS2));
			  
	
   always_ff @(posedge clk)begin 
     if (reset) begin
	  		NUM_MD_ENTRIES1 <= writedata1[207:204];
			NUM_MD_ENTRIES2 <= writedata1[203:200];
			MD_UPDATE_ACTION1 <= writedata1[199:196];
			MD_UPDATE_ACTION2 <= writedata1[195:192];
			MD_ENTRY_TYPE1 <= writedata1[191:188];
			MD_ENTRY_TYPE2 <= writedata1[187:184];
			NUM_ORDERS1 <= writedata1[39:36];
			NUM_ORDERS2 <= writedata1[35:32];
     	 hex0 <= HEX_NUM_MD_ENTRIES1;
	    hex1 <= HEX_NUM_MD_ENTRIES2;
	    hex2 <= HEX_MD_UPDATE_ACTION1;
	    hex3 <= HEX_MD_UPDATE_ACTION2;
    	 hex4 <= HEX_MD_ENTRY_TYPE1;
	    hex5 <= HEX_MD_ENTRY_TYPE2;
	    hex6 <= HEX_NUM_ORDERS1;
	    hex7 <= HEX_NUM_ORDERS2;
     end else if (chipselect && write) begin
//		   NUM_MD_ENTRIES1 <= writedata[207:204];
//			NUM_MD_ENTRIES2 <= writedata[203:200];
//			MD_UPDATE_ACTION1 <= writedata[199:196];
//			MD_UPDATE_ACTION2 <= writedata[195:192];
//			MD_ENTRY_TYPE1 <= writedata[191:188];
//			MD_ENTRY_TYPE2 <= writedata[187:184];
//			NUM_ORDERS1 <= writedata[39:36];
//			NUM_ORDERS2 <= writedata[35:32];
//		   hex0 <= HEX_NUM_MD_ENTRIES1;
//	      hex1 <= HEX_NUM_MD_ENTRIES2;
//	      hex2 <= HEX_MD_UPDATE_ACTION1;
//	      hex3 <= HEX_MD_UPDATE_ACTION2;
//	      hex4 <= HEX_MD_ENTRY_TYPE1;
//	      hex5 <= HEX_MD_ENTRY_TYPE2;
//	      hex6 <= HEX_NUM_ORDERS1;
//	      hex7 <= HEX_NUM_ORDERS2;


	 end
	end //end always block
endmodule
module hex7seg(input logic [3:0] a,
	  output logic [7:0] y);
	always_comb
				case(a)
					4'd0: y = 7'b0011_1111;
					4'd1: y = 7'b0000_0110;
					4'd2: y = 7'b0101_1011;
					4'd3: y = 7'b0100_1111;
					4'd4: y = 7'b0110_0110;
					4'd5: y = 7'b0110_1101;
					4'd6: y = 7'b0111_1101;
					4'd7: y = 7'b0000_0111;
					4'd8: y = 7'b0111_1111;
					4'd9: y = 7'b0110_1111;
					4'd10: y = 7'b0111_0111;
					4'd11: y = 7'b0111_1100;
					4'd12: y = 7'b0011_1001;
					4'd13: y = 7'b0101_1110;
					4'd14: y = 7'b0111_1001;
					4'd15: y = 7'b0111_0001;
					default: y = 7'b0111_1110;
				endcase
endmodule
