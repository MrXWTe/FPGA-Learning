module fifo_rd(
	input 		clk,				//时钟信号
	input 		rst_n,			//复位信号
	
	input [7:0] data,				//从FIFO输出的数据
	input 		rdfull,			//读满信号
	input 		rdempty,			//读空信号
	
	output reg	rdreq				//读请求
);

// reg define
reg		[7:0]	data_info;		//读取的fifo数据
reg		[1:0]	flow_cnt;		//状态流转信号


always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		rdreq <= 1'b0;
		data_info <= 8'd0;
	end
	
	else begin
		case(flow_cnt)
			2'd0:	begin
				if(rdfull) begin
					rdreq <= 1'b1;
					flow_cnt <= flow_cnt + 1'b1;
				end
				else
					flow_cnt <= flow_cnt;
			end
			
			2'd1:	begin
				if(rdempty) begin
					rdreq <= 1'b0;
					data_info <= 8'd0;
					flow_cnt <= 2'd0;
				end
				else begin
					rdreq <= 1'b1;
					data_info <= data;
				end
			end
			default:	flow_cnt <= 2'd0;
		endcase
	end
end

endmodule
