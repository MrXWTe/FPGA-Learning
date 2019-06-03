module touch_key_beep(
	input               sys_clk,
    input               sys_rst_n,
    
    input               touch_key,
    output reg          beep,
    output reg [3:0]    led
);

reg             touch_key_d0;
reg             touch_key_d1;
reg [23:0]      led_cnt;

// 0.2秒计时器
always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        led_cnt <= 24'd0;
    end
    else begin 
        if(led_cnt <= 24'd10_000_000)
            led_cnt <= led_cnt + 1'd1;
        else 
            led_cnt <= 24'd0;
    end
end

// 流水灯闪烁
always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        led <= 4'b0001;
    end
    else if( (led_cnt == 24'd10_000_000) && beep)
        led[3:0] = {led[2:0], led[3]};
    else 
        led <= led;
end

// 检测上升沿
assign touch_en = touch_key_d0 & (~touch_key_d1);
always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin 
        touch_key_d0 <= 1'd0;
        touch_key_d1 <= 1'd1;
    end
    else begin 
        touch_key_d0 <= touch_key;
        touch_key_d1 <= touch_key_d0;
    end
end

// 一旦检测到上升沿，touch_en被使能，蜂鸣器被赋予信号
always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        beep <= 1'b0;
    end
    else begin 
        if(touch_en) begin
            beep = ~beep;
        end
    end
end



endmodule
