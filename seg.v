module SEG8_LUT
(
	output reg[7:0] oSEG,
	input wire [3:0] iDIG
);
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
		4'ha:oSEG<=8'b0000_0101;
		4'hb:oSEG<=8'b1100_0001;
		4'hc:oSEG<=8'b0110_0011;
		4'hd:oSEG<=8'b1000_0101;
		4'he:oSEG<=8'b0110_0001;
		4'hf:oSEG<=8'b0111_0001;
		4'h0:oSEG<=8'b0000_0011;
		endcase
	end

endmodule


module seg_display
(
    input   wire[23:0]  num,
    output  wire[7:0]   seg_leds,
    output  reg [5:0]   seg_ncs,
    input   wire        clk,rst_n
);

reg     [3:0]   iseg;
reg     [2:0]   cnt=0;

SEG8_LUT s(seg_leds,iseg);

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 3'b0;
        iseg <= 4'h1;
    end
    else
        case (cnt)
            3'h0: begin 
                seg_ncs <= 6'b011111; 
                iseg <= num[3:0];   
                cnt <= cnt+1; 
					 end
            3'h1: begin 
                seg_ncs <= 6'b101111; 
                iseg <= num[7:4];   
                cnt <= cnt+1; 
					 end
            3'h2: begin 
                seg_ncs <= 6'b110111; 
                iseg <= num[11:8];  
                cnt <= cnt+1; 
					 end
            3'h3: begin 
                seg_ncs <= 6'b111011; 
                iseg <= num[15:12]; 
                cnt <= cnt+1; 
					 end
            3'h4: begin 
                seg_ncs <= 6'b111101; 
                iseg <= num[19:16]; 
                cnt <= cnt+1; 
					 end
            3'h5: begin 
                seg_ncs <= 6'b111110; 
                iseg <= num[23:20]; 
                cnt <= 0;     
					 end
            default: begin 
					 seg_ncs <= 6'b111111;
					 cnt <= 0;
					 end
        endcase
end

endmodule