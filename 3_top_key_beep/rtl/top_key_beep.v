module top_key_beep(
	input       sys_clk,    // 时钟信号
    input       sys_rst_n,  // 复位信号
    
    input       key,        // 按键按下信号
    output      beep        // 蜂鸣器输出信号
);

wire    key_value;
wire    key_flag;

//例化按键消抖模块
key_debounce u_key_debounce(
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    
    .key            (key),
    .key_flag       (key_flag),
    .key_value      (key_value)
    );
  
//例化蜂鸣器控制模块
beep_control u_beep_control(
    .sys_clk        (sys_clk), 
    .sys_rst_n      (sys_rst_n),
    
    .key_flag       (key_flag),      
    .key_value      (key_value),
    .beep           (beep)
    );
    
endmodule 