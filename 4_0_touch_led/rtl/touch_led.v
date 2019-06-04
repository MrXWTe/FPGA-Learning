module touch_led(
	input				clk,
	input 			rst_n,
	
	input				touch_key,
	output reg 		led
);

reg touch_key_d0;
reg touch_key_d1;

wire touch_key_flag;

//检测上升沿
//assign touch_key_flag = (~touch_key_d1) & touch_key_d0;

//检测下降沿
assign touch_key_flag = touch_key_d1 | (~touch_key_d0);

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		touch_key_d0 <= 1'b0;
		touch_key_d1 <= 1'b0;
	end
	
	else begin
		touch_key_d0 <= touch_key;
		touch_key_d1 <= touch_key_d0;
	end
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		led <= 1'b1;
	else
		if(!touch_key_flag)
			led <= ~led;
		else
			led <= led;
end

endmodule
