module seg_led_static(
    input               clk,
    input               rst_n,
    
    input               change_flag,
    output  reg [5:0]   wei_xuan,
    output  reg [7:0]   duan_xuan
);

reg [3:0] num;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        wei_xuan <= 6'b111111;
    else   
        wei_xuan <= 6'b000000;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        num <= 4'h0;
    else if(change_flag == 1'b1) begin
            if(num < 4'hf)
                num <= num + 1'b1;
            else
                num <= 4'h0;
        end
    else 
        num <= num;
end 

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        duan_xuan <= 8'b00000000;
    end
    else begin
        case(num)
            4'h0:       duan_xuan <= 8'b1100_0000;
            4'h1 :      duan_xuan <= 8'b1111_1001;
            4'h2 :      duan_xuan <= 8'b1010_0100;
            4'h3 :      duan_xuan <= 8'b1011_0000;
            4'h4 :      duan_xuan <= 8'b1001_1001;
            4'h5 :      duan_xuan <= 8'b1001_0010;
            4'h6 :      duan_xuan <= 8'b1000_0010;
            4'h7 :      duan_xuan <= 8'b1111_1000;
            4'h8 :      duan_xuan <= 8'b1000_0000;
            4'h9 :      duan_xuan <= 8'b1001_0000;
            4'ha :      duan_xuan <= 8'b1000_1000;
            4'hb :      duan_xuan <= 8'b1000_0011;
            4'hc :      duan_xuan <= 8'b1100_0110;
            4'hd :      duan_xuan <= 8'b1010_0001;
            4'he :      duan_xuan <= 8'b1000_0110;
            4'hf :      duan_xuan <= 8'b1000_1110;
            default :   duan_xuan <= 8'b1100_0000;   
        endcase
    end
end

endmodule
