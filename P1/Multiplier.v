module Mult2(
  input [31:0] a,
  input [31:0] b,
  output reg [31:0] result
);
  
  reg sign_a, sign_b;
  reg [7:0] exp_a, exp_b;
  reg [22:0] mant_a, mant_b;
  reg [47:0] mant_res;
  reg [23:0] exp_res;

  always @(a, b) begin
    sign_a = a[31];
    sign_b = b[31];

    exp_a = a[30:23];
    exp_b = b[30:23];

    mant_a = {1'b1, a[22:1]};
    mant_b = {1'b1, b[22:1]};

    mant_res = mant_a * mant_b;

    exp_res = exp_a + exp_b - 127;

    result = {sign_a^sign_b, exp_res, mant_res[43:21]};
  end

endmodule

module Mult #(parameter XLEN=32)
                                (input [XLEN-1:0]A,
                                 input [XLEN-1:0]B,
                                 output reg  [XLEN-1:0] result);

reg [23:0] A_Mantissa,B_Mantissa;
reg [22:0] Mantissa;
reg [47:0] Temp_Mantissa;
reg [7:0] A_Exponent,B_Exponent,Temp_Exponent,diff_Exponent,Exponent;
reg A_sign,B_sign,Sign;
reg [32:0] Temp;
reg [6:0] exp_adjust;
always@(*)
begin
if(A == 32'b0 || B==32'b0)
result = 32'b0;
else begin
A_Mantissa = {1'b1,A[22:0]};
A_Exponent = A[30:23];
A_sign = A[31];
  
B_Mantissa = {1'b1,B[22:0]};
B_Exponent = B[30:23];
B_sign = B[31];

Temp_Exponent = A_Exponent+B_Exponent-127;
Temp_Mantissa = A_Mantissa*B_Mantissa;
Mantissa = Temp_Mantissa[47] ? Temp_Mantissa[46:24] : Temp_Mantissa[45:23];
Exponent = Temp_Mantissa[47] ? Temp_Exponent+1'b1 : Temp_Exponent;
Sign = A_sign^B_sign;
result = {Sign,Exponent,Mantissa};
end
end
endmodule
