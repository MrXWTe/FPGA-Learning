module beep_control(
    input           sys_clk,
    input           sys_rst_n,
    
    input           key_flag,
    input           key_value,
    output  reg     beep
);

always @ (posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        beep <= 1'd1;
    else begin 
        if(key_flag && (~key_value)) begin
            beep <= ~beep;
        end
    end
end

endmodule
