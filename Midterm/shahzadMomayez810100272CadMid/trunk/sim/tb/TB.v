`timescale 1ns/1ns
module testBench();

reg clk;
reg strt;
reg [8:0] _x, _y, _z;
wire dn;

TopConv cn (
  .clk(clk),
  .strt(strt),
  .x_(_x),
  .y_(_y),
  .z_(_z),
  .dn(dn)
);

initial begin
  clk = 0;
  strt = 0;
  _x= 6;
  _y = 72;
  _z= 77;
  #30 strt = 1;
  #30 strt = 0;
	#210000 ;
	$stop;
end

always begin
  #5 clk = ~clk;
end

endmodule

