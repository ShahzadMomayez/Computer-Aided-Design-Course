


module adder(  input [8:0] inp1,  input [8:0] inp2,  output [8:0] result);

  reg [8:0] carry;
  reg [8:0] temp_sum;

  always @(inp1 or inp2) begin
    temp_sum = inp1 ^ inp2 ^ carry;
    carry = (inp1 & inp2) | ((inp1 ^ inp2) & carry);
  end

  assign result = temp_sum;

endmodule

module counter (  input clk, rst, enable,  output reg cout,  output reg [3:0] count);

  always@( posedge rst,posedge clk ) begin
    if (rst) begin
      count <= 4'b0;
      cout <= 1'b0;
    end else if (enable) begin
      count <= count + 1;
      cout <= (count == 4'b1111) ? 1'b1 : 1'b0; 
    end
  end

endmodule




module mac (
  input clk, rst,
  input [7:0] inp1,
  input [7:0] inp2,
  input en,
  output [7:0] out
);
  reg [15:0] mult;
  reg [11:0] temp_reg;

  always @(posedge clk , posedge rst) begin
    if (rst) begin
      temp_reg <= 0;
    end else if (en) begin
      mult <= inp1 * inp2;
      temp_reg <= temp_reg + mult[15:8];
    end
  end

  assign out = temp_reg[11:4];
endmodule