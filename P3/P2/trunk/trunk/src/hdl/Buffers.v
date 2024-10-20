module buffer4x4 (clk,in,en,out);
    input wire clk;
    input wire [7:0] in [0:15];
    input wire [15:0] en;
    output reg [7:0] out [0:15];
    integer i;

    always @(posedge clk) begin
        for (i = 0; i < 16; i = i + 1) begin
            if (en[i]) begin
                out[i] <= in[i];
            end
        end
    end
endmodule


module buffer4x16(clk,shift,en,in,adr,out);
	input [31:0] in;
	input clk, shift;
	input [15:0] en;
	input [3:0] adr;
	output reg [7:0] out[0:15];

	reg [7:0] buffer [0:3][0:15];
	wire [7:0] data_splited[0:3];
	assign data_splited[0] = in[31:24];
	assign data_splited[1] = in[23:16];
	assign data_splited[2] = in[15:8];
	assign data_splited[3] = in[7:0];


	integer i,j;
	always@(posedge clk)begin
		 for (i = 0; i < 4; i = i + 1) begin
    			out[i*4] 	 <= buffer[i][adr];
    			out[i*4 + 1] <= buffer[i][adr + 1];
   				out[i*4 + 2] <= buffer[i][adr + 2];
    			out[i*4 + 3] <= buffer[i][adr + 3];
  		end
	end
	always@(posedge clk)begin
		if(shift)
		begin
			for (i = 0; i < 3; i = i + 1) 
			begin
        			for (j = 0; j < 16; j = j + 1)
				begin
          				buffer[i][j] <= buffer[i+1][j];
        			end
      			end
		end
		else begin
			for(i=0;i<16;i=i+1)begin
				if(en[15-i])
				begin
					buffer[3][i] = data_splited[0];
					buffer[3][i+1] = data_splited[1];
					buffer[3][i+2] = data_splited[2];
					buffer[3][i+3] = data_splited[3];
					i = 16;
				end
			end
		end
	end
	
endmodule


module test(clk,dataIn,en,dataOut);
	input clk;
	input [31:0] dataIn ;
	input [15:0] en;
	output reg [127:0] dataOut ;

	wire [31:0] data_splited;
	assign data_splited = dataIn;



	integer i , j;
	always @(posedge clk) 
	begin
		for (i = 0; i < 16; i = i + 1) 
		begin
			if(en[15-i])
			begin
				for (j = 0; j < 32; j = j + 1)
				begin
					dataOut[32 * i + j] = data_splited[j];
					
				end
				i = 16;
			end
      		end
  	end
endmodule

module filterBuffer(clk,in,en,out);
	input clk;
	input [31:0] in ;
	input [15:0] en;
	output reg [7:0] out [0:15];
	wire [7:0] data_splited[0:3];
	assign data_splited[0] = in[31:24];
	assign data_splited[1] = in[23:16];
	assign data_splited[2] = in[15:8];
	assign data_splited[3] = in[7:0];
	
	integer i , j;
	always @(posedge clk) 
	begin
		for (i = 0; i < 16; i = i + 1) 
		begin
			if(en[15-i])
			begin
				for (j = 0; j < 8; j = j + 1)
				begin
					out[i][j] = data_splited[0][j];
					out[i+1][j]= data_splited[1][j];
					out[i+2][j] = data_splited[2][j];
					out[i+3][j] = data_splited[3][j];
					
				end
				i = 16;
			end
      		end
  	end

endmodule


module buffer13x13(clk,shift,en,in, adr,out);
	input [7:0] in[0:12][0:12]  ;
	input clk , shift;
	input en;
	input [3:0] adr ;
	output reg [7:0] out[0:15];

	reg [7:0] buffer [0:12][0:12];
	


	integer i,j;
	always@(posedge clk)begin
		 for (i = 0; i < 4; i = i + 1) begin
    			out[i*4] 	 <= buffer[i][adr];
    			out[i*4 + 1] <= buffer[i][adr + 1];
   				out[i*4 + 2] <= buffer[i][adr + 2];
    			out[i*4 + 3] <= buffer[i][adr + 3];
  		end
	end
	always@(posedge clk)begin
		if(shift)
		begin
			for (i = 0; i < 12; i = i + 1) 
			begin
        			for (j = 0; j < 16; j = j + 1)
				begin
          				buffer[i][j] <= buffer[i+1][j];
        			end
      			end
		end
		else begin
			/*for(i=0;i<13;i=i+1)begin
				if(en[12-i])
				begin
					if(i < 10)begin
					buffer[12][i] = data_splited[0];
					buffer[12][i+1] = data_splited[1];
					buffer[12][i+2] = data_splited[2];
					buffer[12][i+3] = data_splited[3];
					end
					else if (i == 10)begin 
					buffer[12][i] = data_splited[0];
					buffer[12][i+1] = data_splited[1];
					buffer[12][i+2] = data_splited[2];
					end
					else if (i == 11)begin 
					buffer[12][i] = data_splited[0];
					buffer[12][i+1] = data_splited[1];
					end
					else if (i == 12)begin 
					buffer[12][i] = data_splited[0];
					end
					i = 13;
				end
			end*/
			if(en)begin
				for(i =0 ; i < 13 ; i = i + 1)begin
					for(j =0 ; j <13 ; j = j + 1) begin
						buffer[i][j] = in[i][j];
					end
				end
			end
		end
				
	end
	
endmodule


////everything is OK!



