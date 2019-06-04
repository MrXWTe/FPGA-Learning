module key_led(
	input					clk,		//系统时钟
	input					rst_n,	//复位信号
	
	input	 [3:0]		key,		//按键信号
	output reg [3:0]	led		//led信号
);

//reg define
reg [23:0] cnt;				//时钟计数器
reg [1:0]  led_ctrl;			//led状态控制器

//0.2s计数器
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		cnt <= 24'd0;
	else
		if(cnt < 24'd1000_0000)
			cnt <= cnt + 1'd1;
		else
			cnt <= 24'd0;
end

//每隔0.2s改变状态计数器
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		led_ctrl <= 2'd0;
	else
		if(cnt == 24'd1000_0000)
			led_ctrl <= led_ctrl + 1'b1;
		else
			led_ctrl <= led_ctrl;
end

//根据按键改变led状态
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		led <= 4'b0000;
	else
		if(key[0] == 1'b0)					//从右向左的流水灯
			case(led_ctrl)
				2'd0:		led <= 4'b1000;
				2'd1:		led <= 4'b0100;
				2'd2:		led <= 4'b0010;
				2'd3:		led <= 4'b0001;
			endcase
			
		else if(key[1] == 1'b0)				//从左向右的流水灯
			case(led_ctrl)
				2'd0:		led <= 4'b0001;
				2'd1:		led <= 4'b0010;
				2'd2:		led <= 4'b0100;
				2'd3:		led <= 4'b1000;
			endcase
			
		else if(key[2] == 1'b0)begin
		
		/* 间隔0.2s全灯闪烁
			case(led_ctrl)
				2'd0:		led <= 4'b1111;
				2'd1:		led <= 4'b0000;
				2'd2:		led <= 4'b1111;
				2'd3:		led <= 4'b0000;
			endcase
		*/
			if(cnt == 24'd1000_0000)		//这两行代码与上述实现相同功能
				led = ~led;
		end	
		
		else if(key[3] == 1'b0)
			led <= 4'b1111;
			
		else
			led <= 4'b0000;
end

endmodule
