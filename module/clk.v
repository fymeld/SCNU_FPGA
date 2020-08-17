module CP_1kHz(input clk,output reg _1kHz,input rst_n);

	integer cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			_1kHz<=1'b0;
			cnt<=0;
		end
		else if(cnt==24999)
		begin
			cnt<=0;
			_1kHz<=!_1kHz;
		end
		else 
		begin
			cnt<=cnt+1;
		end
	end

endmodule

module CP_1Hz(input clk,output reg _1Hz,input rst_n);

	integer cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			_1Hz<=1'b0;
			cnt<=0;
		end
		else if(cnt==24999999)
		begin
			cnt<=0;
			_1Hz<=!_1Hz;
		end
		else 
		begin
			cnt<=cnt+1;
		end
	end


endmodule

module CP_100Hz(input clk,output reg _100Hz,input rst_n);

	integer cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			_100Hz<=1'b0;
			cnt<=0;
		end
		else if(cnt==249999)
		begin
			cnt<=0;
			_100Hz<=!_100Hz;
		end
		else 
		begin
			cnt<=cnt+1;
		end
	end


endmodule

module CP_250Hz(input clk,output reg _250Hz,input rst_n);

	integer cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			_250Hz<=1'b0;
			cnt<=0;
		end
		else if(cnt==99999)
		begin
			cnt<=0;
			_250Hz<=!_250Hz;
		end
		else 
		begin
			cnt<=cnt+1;
		end
	end


endmodule

module CP_125Hz(input clk,output reg _125Hz,input rst_n);

	integer cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			_125Hz<=1'b0;
			cnt<=0;
		end
		else if(cnt==49999)
		begin
			cnt<=0;
			_125Hz<=!_125Hz;
		end
		else 
		begin
			cnt<=cnt+1;
		end
	end


endmodule

module CP_2Hz(input clk,output reg _2Hz,input rst_n);

	integer cnt;
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		begin
			_2Hz<=1'b0;
			cnt<=0;
		end
		else if(cnt==12499999)
		begin
			cnt<=0;
			_2Hz<=!_2Hz;
		end
		else 
		begin
			cnt<=cnt+1;
		end
	end


endmodule