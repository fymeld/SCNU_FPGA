// 由于有多个数码管，只有一组seg_led端口，多个数码管同时显示不同内容时，需要动态扫描
// 数码管切换显示时间小于20ms时才会给人多个数码管同时显示的效果
// 按键消抖（防误触、抖动干扰...）：
// 1、延时消抖时间一般为5到10ms；
// 2、检测到按键低电平（按下），延时5到10ms在检测按键的电平，如果还是低电平，那么确认按键被按下，否则为误触发；
// 3、等待按键被释放（高电平），也会有抖动（消抖），电路再实现所需要的逻辑功能。

module testfpga(
	input				rst_n			,	// 异步复位key1
	input				clk				,	// 时钟CLK_50M
	input		[6 : 0]	keys			,	// 按键BUT[1]~BUT[7]
	output	reg	[7 : 0]	leds			,	// 共阳，led灯LED[1]~LED[8]
	output	wire	[5 : 0]	seg_nCS			,	// 6个数码管的片选（LOW），LSB对应最左边
	output	wire   [7 : 0]	seg_leds			// 共阳，bit0点、1中间、2左上、3左下、4下、5右下、6右上、7上
);


reg[23:0] num;
wire _250Hz,_2Hz,_125Hz,_100Hz,_1Hz;
wire key2,key3,key4,key5,key6,key7;
wire[15:0] result;

reg s2,s3,s4,s5,s6;
reg[7:0]x;
reg[7:0]y;

wire[8:0]minute;
wire[8:0]sec;
wire[8:0]ms;
wire EnM,EnS;

reg[2:0]cnt;
integer c;

CP_250Hz c1(clk,_250Hz,rst_n);
CP_2Hz  c2(clk,_2Hz,rst_n);
CP_125Hz c3(clk,_125Hz,rst_n);
CP_100Hz c4(clk,_100Hz,rst_n);
CP_1Hz   c5(clk,_1Hz,rst_n);
seg_display s(num,seg_leds,seg_nCS,_250Hz,rst_n);

always @(posedge _125Hz,negedge rst_n)
begin
	if(!rst_n)
	begin
		num<=24'h334021;
	end
	else 
	begin
		case({s6,s5,s3,s2})
			4'b0000:num<=24'h334021;
			4'b0001:num<=24'h334021;
			4'b0010:num<={x,y,8'h00};
			4'b0011:num<={8'h00,result};
			4'b0110:num<={8'h00,result};
			4'b1111:begin num[23:16]<=minute;num[15:8]<=sec;num[7:0]<=ms;end
			default:num<=num;
		endcase
	end
	
end

always@(posedge _2Hz,negedge rst_n)
begin
	if(!rst_n)begin
		leds[7:0]<=8'h00;
		cnt<=3'b000;
	end
	else begin
		if(s2 && !s3)begin
			case(cnt)
			3'b000:begin leds[7:0]<=8'b10000001;cnt<=cnt+1;end
			3'b001:begin leds[7:0]<=8'b11000011;cnt<=cnt+1;end
			3'b010:begin leds[7:0]<=8'b11100111;cnt<=cnt+1;end
			3'b011:begin leds[7:0]<=8'b11111111;cnt<=cnt+1;end
			3'b100:begin leds[7:0]<=8'b01111110;cnt<=cnt+1;end
			3'b101:begin leds[7:0]<=8'b00111100;cnt<=cnt+1;end
			3'b110:begin leds[7:0]<=8'b00011000;cnt<=cnt+1;end
			3'b111:begin leds[7:0]<=8'b00000000;cnt<=cnt+1;end
			default:begin leds[7:0]<=8'b11111111;cnt<=3'b000;end
			endcase
		end
		else
			leds[7:0]<=8'h00;
	end
end

always @(posedge _250Hz or negedge rst_n)
begin
	if(!rst_n) begin 
		{s2,s3,s4,s5,s6}<=5'b00000;
		x<=8'h00;
		y<=8'h00;
		c<=0;
	end
	else begin
		if(key2) begin
			s2<=!s2;
			{s3,s4,s5,s6}<=4'h0;
		end
		else if(key3) begin
			{s2,s3,s4,s5,s6}<=5'b01000;
			x<=x+1;
		end
		else if(key4) begin
			s3<=1'b1;
			{s2,s3,s4,s5,s6}<=5'b01000;
			y<=y+1;
		end
		else if(key5) begin
			{s2,s3,s4,s5,s6}<=5'b11000;
		end
		else if(key6) begin
			s4<=!s4;
			{s2,s3,s5,s6}<=4'b0100;
		end
		else if(key7) begin
			s6<=!s6;
			{s2,s3,s4,s5}<=4'b1101;
		end
		else begin
			if(s4)begin
				if(c==249) begin
					c<=0;
					s2<=1'b0;
					s3<=1'b1;
					s5<=!s5;
					if(s5) begin
						x<=x+1;
						y<=y+1;
					end
				end
				else 
					c<=c+1;
			end
		end
	end
end

assign EnS=(ms==8'h99);
assign EnM=(sec==8'h59)&(ms==8'h99);
counter100 u0(ms,rst_n,s6,_100Hz);
counter60  u1(sec,rst_n,EnS,_100Hz);
counter60  u2(minute,rst_n,EnM,_100Hz);

Mul_16 m(_250Hz,rst_n,x,y,result);

key_handle key2_u(
	.rst_n				(rst_n			),			// 复位key7(BUT[8])
	.clk_8ms				(_250Hz			),			
	.key					(keys[1]			),			// 单个按键
	.rst_sync			(key7				),
	.key_handled		(key2				)
);
key_handle key3_u(
	.rst_n				(rst_n			),			// 复位key7(BUT[8])
	.clk_8ms				(_250Hz			),			
	.key					(keys[2]			),			// 单个按键
	.rst_sync			(key7				),
	.key_handled		(key3				)
);
key_handle key4_u(
	.rst_n				(rst_n			),			// 复位key7(BUT[8])
	.clk_8ms				(_250Hz			),			
	.key					(keys[3]			),			// 单个按键
	.rst_sync			(key7				),
	.key_handled		(key4				)
);
key_handle key5_u(
	.rst_n				(rst_n			),			// 复位key7(BUT[8])
	.clk_8ms				(_250Hz			),			
	.key					(keys[4]			),			// 单个按键
	.rst_sync			(key7				),
	.key_handled		(key5				)
);
key_handle key6_u(
	.rst_n				(rst_n			),			// 复位key7(BUT[8])
	.clk_8ms				(_250Hz			),			
	.key					(keys[5]			),			// 单个按键
	.rst_sync			(key7				),
	.key_handled		(key6				)
);
key_handle key7_u(
	.rst_n				(rst_n			),			// 复位key7(BUT[8])
	.clk_8ms				(_250Hz			),			
	.key					(keys[6]			),			// 单个按键
	.rst_sync			(1'b0				),
	.key_handled		(key7				)
);

endmodule 