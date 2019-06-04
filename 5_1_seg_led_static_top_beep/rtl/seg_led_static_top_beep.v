module seg_led_static_top_beep(
    input               sys_clk,
    input               sys_rst_n,
    
    output  [5:0]       wei_xuan,
    output  [7:0]       duan_xuan,
    output              beep            
);

wire change_flag;

time_count u_time_count(
    .clk        (sys_clk),
    .rst_n      (sys_rst_n),
    
    .change_flag    (change_flag)
);

seg_led_static u_seg_led_static(
    .clk            (sys_clk),
    .rst_n          (sys_rst_n),
    
    .change_flag    (change_flag),
    .wei_xuan       (wei_xuan),
    .duan_xuan      (duan_xuan)
);

beep u_beep(
    .clk            (sys_clk),
    .rst_n          (sys_rst_n),
    
    .change_flag    (change_flag),
    .beep           (beep)
);

endmodule
