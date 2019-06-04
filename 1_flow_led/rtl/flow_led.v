module flow_led(
    input               sys_clk  ,  //系统时钟
    input               sys_rst_n,  //系统复位，低电平有效
	 
    output  reg  [3:0]  led         //4个LED灯
);

//reg define
reg [23:0] counter;

//*****************************************************
//**                    main code
//流水灯循环点亮
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

//流水灯循环点亮
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led <= 4'b0001;
    else if(counter == 24'd10000000)
		  led <= {led[2:0], led[3]};
    else
        led <= led;
end

endmodule 