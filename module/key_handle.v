module key_handle(
	input							rst_n				,			
	input							clk_8ms			,			
	input							key				,			// 单个按键
	input							rst_sync			,
	
	output	reg				key_handled
);
reg					key1, key2, key_sync		;			// key同步
reg					key_sync_temp				;
wire					key_rise						;			// key_sync的上升沿

assign key_rise = !key_sync_temp && key_sync;

// 对key使用clk_8ms进行三级同步
always @(posedge clk_8ms or negedge rst_n)
begin
	if(!rst_n) {key_sync, key2, key1} <= 3'b111;
	else if(rst_sync) {key_sync, key2, key1} <= 3'b111;
	else {key_sync, key2, key1} <= {key2, key1, key};
end
// 用于key_sync边沿检测
always @(posedge clk_8ms or negedge rst_n)
begin
	if(!rst_n) key_sync_temp <= 1'b1;
	else if(rst_sync) key_sync_temp <= 1'b1;
	else key_sync_temp <= key_sync;
end
// 处理之后的按键
always @(posedge clk_8ms or negedge rst_n) begin
	if(!rst_n) key_handled <= 1'b0;
	else if(rst_sync) key_handled <= 1'b0;
	else if(key_rise) key_handled <= 1'b1;
	else key_handled <= 1'b0;
end

endmodule 