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
//流水灯每次顺序熄灭一个；
//当所有灯全部熄灭时，点击RESET按钮，流水灯全部点亮再次循环。
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

//流水灯递减熄灭
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        led <= 4'b0000;
		  count <= 4'b1111;
    end
	 
    else if(counter == 24'd10000000) begin
		  led <= count;
		  count <= count >> 1'b1;
	 end 
	 
    else
        led <= led;
end

endmodule 