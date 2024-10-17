module Reg (
  input clk_,
  input rst_,input jmp_,
  input [8:0] In_,input [8:0] beforeVal_,
  output reg [8:0] Out_
);

  always @(posedge clk_ or posedge rst_) begin
    if (rst_) begin
      Out_ <= beforeVal_;
    end else if (!jmp_) begin
Out_ <= In_;
      
    end else begin
      Out_ <= 48;
    end
  end

endmodule

module shReg (
  input clk,
  input rst, input sh, input w,
  input [7:0] in,
  output [31:0] out
);

  reg [31:0] regis;

  always @(posedge clk) begin
    case ({rst, sh, w})
      3'b001: regis <= 0; // reset
      3'b010: regis <= { regis[23:0], 8'b0 }; // shift
      3'b100: regis <= { regis[31:8], in }; // write
      // no change
    endcase
  end

  assign out = regis;

endmodule

module mem (  input [31:0] in,  input writeE, clk,  input [8:0] address,  output reg [31:0] res);
  reg [31:0] m[0:511];
  initial begin
    $readmemh("file/test1234.txt", m);
  end

  always @(posedge clk) begin
    if (writeE) begin
      m[address] <= in;
    end
    res <= m[address];
  end
endmodule