module time_count(
    input           clk,
    input           rst_n,
    
    output  reg     change_flag
);


reg [27:0] cnt;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt <= 28'd0;
    else if(cnt < 28'd25_000_000) begin
        cnt <= cnt + 1'b1;
        change_flag <= 1'b0;
    end
    else begin
        cnt <= 28'd0;
        change_flag <= 1'b1;
    end         
end

endmodule
