module Memory(input [31:0] inp , input we , clk , input[8:0] adr , output reg[31:0] out);
	reg[31:0] memory[0:511];
	initial $readmemh("input.txt" , memory);
	always@(posedge clk)begin
	out <= memory[adr];
	if (we) 
		memory[adr ] <= inp;
	end
endmodule
