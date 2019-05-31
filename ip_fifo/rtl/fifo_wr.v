module fifo_wr(
	input							clk,		//时钟信号
	input							rst_n,	//复位信号
	
	input							wrempty,	//写空信号
	input							wrfull,	//写满信号
	output	reg	[7:0]		data,		//写入fifo的数据
	output	reg				wrreq		//写请求
);

// reg define	
reg	[1:0]		flow_cnt;				//状态流转计数
	
// 向FIFO中写数据
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		wrreq <= 1'b0;
		data <= 8'd0;
		flow_cnt <= 2'd0;
	end
	
	else begin
		case(flow_cnt)
			2'd0:	begin
				if(wrempty) begin			//写空时，写请求信号拉高，跳到下一个状态
					wrreq <= 1'b1;
					flow_cnt <= flow_cnt + 1'b1;
				end
				else
					flow_cnt <= flow_cnt;
			end
			
			2'd1: begin               //写满时，写请求拉低，跳回上一个状态
				 if(wrfull) begin
					  wrreq <= 1'b0;
					  data  <= 8'd0;
					  flow_cnt <= 2'd0;
				 end
				 else begin            //没有写满的时候，写请求拉高，继续输入数据
					  wrreq <= 1'b1;
					  data  <= data + 1'd1;
				 end
			end 
			
			default: flow_cnt <= 2'd0;
	  endcase
  end
end

endmodule
