module Decoder(input [31:0] a0 , a1 , a2 , a3 ,  output reg [1:0] idx , output reg done);
assign done = 0;
always@(*)begin
if(a0 == 32'b0 && a1 == 32'b0 && a2 == 32'b0 && a3!=32'b0)begin
	done = 1;
	idx = 2'b11;
end
else if(a0 == 32'b0 && a1 == 32'b0  && a2!=32'b0)begin
	done = 1;
	idx = 2'b10;
end
else if(a0 == 32'b0 && a2 == 32'b0  && a1!=32'b0)begin
	done = 1;
	idx = 2'b01;
end
else if(a1 == 32'b0 && a2 == 32'b0  && a0!=32'b0)begin
	done = 1;
	idx = 2'b00;
end

end
endmodule