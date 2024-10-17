

module mux16 (
    input [127:0] in,
    input [3:0] sel,
    output reg [7:0] res
);

parameter state0 = 0;
parameter state1 = 1;
parameter state2 = 2;
parameter state3 = 3;
parameter state4 = 4;
parameter state5 = 5;
parameter state6 = 6;
parameter state7 = 7;
parameter state8 = 8;
parameter state9 = 9;
parameter state10 = 10;
parameter state11 = 11;
parameter state12 = 12;
parameter state13 = 13;
parameter state14 = 14;
parameter state15 = 15;

always @(sel or in) begin
    case (sel)
        state0: res = in[7 : 0];
        state1: res = in[15 : 8];
        state2: res = in[23 : 16];
        state3: res = in[31 : 24];
        state4: res = in[39 : 32];
        state5: res = in[47 : 40];
        state6: res = in[55 : 48];
        state7: res = in[63 : 56];
        state8: res = in[71 : 64];
        state9: res = in[79 : 72];
        state10: res = in[87 : 80];
        state11: res = in[95 : 88];
        state12: res = in[103 : 96];
        state13: res = in[111 : 104];
        state14: res = in[119 : 112];
        state15: res = in[127 : 120];
        default: res = 0;
    endcase
end

endmodule





module mux2to1 (
  input [8:0] a, b,
  input sel,
  output reg [8:0] res
);

  always @* begin
    res = (sel) ? a : b;
  end

endmodule


module mux4to1(input [8:0] a,b,c,d,input [1:0]sel,output reg [8:0]out);

always @(a or b or c or d or sel) begin
if (sel == 0)
out = a;
else if (sel == 1)
out = b;
else if (sel == 2)
out = c;
else
out = 0;
end

endmodule
