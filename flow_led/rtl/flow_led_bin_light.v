module flow_led(
    input               sys_clk  ,  //系统时钟
    input               sys_rst_n,  //系统复位，低电平有效
	 
    output  reg  [3:0]  led         //4个LED灯
);

//reg define
reg [23:0] counter;

//count define
reg [3:0] count;

//*****************************************************
//**                    main code
//流水灯按照二进制形式递增点亮
//***************************************************** 
                                                                                                                                                                                                                         
//计数器对系统时钟计数，计时0.2秒
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 1'b0;
    else if (counter < 24'd10000000)
        counter <= counter + 1'b1;
    else
        counter <= 24'd0;
end

//流水灯二进制形式点亮
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        led <= 4'b0000;
		  count <= 4'b0000;
    end
	 
    else if(counter == 24'd10000000) begin

		  if(count == 4'b1111) begin
				count <= 4'b0000;
				led <= 4'b0000;
		  end
		  led <= count;
		  count <= count + 1'b1;
	 end 
	 
    else
        led <= led;
end

endmodule 