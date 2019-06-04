module beep(
    input           clk,
    input           rst_n,
    
    input           change_flag,
    output  reg     beep
);

reg [3:0] cnt;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin 
        cnt <= 4'h0;
        beep <= 1'b0;
    end
    else if(change_flag == 1'b1) begin
        if(cnt < 4'hf) begin
            cnt <= cnt + 1'b1;
            beep <= 1'b0;
        end
        else begin 
            cnt <= 4'h0;
            beep <= 1'b1;
        end
    end
    else 
        cnt <= cnt;
end


endmodule
