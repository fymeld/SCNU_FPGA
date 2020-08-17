
module SEG7_LUT(output reg[7:0] oSEG,input wire [3:0] iDIG);
	//wire [3:0] iDIG;
	//reg[7:0] oSEG;
	
	always @(iDIG)
	begin
		case(iDIG)
		4'h1:oSEG<=8'b1001_1111;
		4'h2:oSEG<=8'b0010_0101;
		4'h3:oSEG<=8'b0000_1101;
		4'h4:oSEG<=8'b1001_1001;
		4'h5:oSEG<=8'b0100_1001;
		4'h6:oSEG<=8'b0100_0001;
		4'h7:oSEG<=8'b0001_1111;
		4'h8:oSEG<=8'b0000_0001;
		4'h9:oSEG<=8'b0000_1001;
		4'ha:oSEG<=8'b0001_1001;
		4'hb:oSEG<=8'b1100_0001;
		4'hc:oSEG<=8'b0110_0011;
		4'hd:oSEG<=8'b1000_0101;
		4'he:oSEG<=8'b0110_0001;
		4'hf:oSEG<=8'b0111_0001;
		4'h0:oSEG<=8'b0000_0011;
		endcase
	end

endmodule