

module buf44 ( input [31:0] in, input writeEnable, clk, input [8:0] adr, output reg [127:0] out);
  integer i;
  reg [127:0] d;
  always @(posedge clk) begin
    if (writeEnable) begin
      for ( i = 0; i < 32; i = i + 1) begin
        d[44 * adr + i] <= in[i];
      end
    end
  end

  assign out = d;

endmodule


module buf16 (  input [127:0] in,  input writeEnable,input clk,  output reg [127:0] out);
 integer i; reg [127:0] data;
	
  always @(posedge clk) begin
    if (writeEnable) begin
      for ( i = 0; i < 128; i = i + 1) begin
        data[i] <= in[i];
      end
    end
  end

  assign out = data;

endmodule


module buf16to4 ( input [31:0] in, input writeEnable, input clk,input  sh_up, input [8:0] adr, output reg [127:0] out);
	integer i;
  reg [31:0] temp_reg [3:0];
  reg [31:0] temp;
  reg [127:0] data [3:0];

  always @(posedge clk) begin
    if (sh_up) begin
      for ( i = 3; i > 0; i = i - 1) begin
        temp_reg[i] <= temp_reg[i - 1];
      end
    end

    if (writeEnable) begin
      temp_reg[0] <= in;
    end
  end

  always @(*) begin
    for ( i = 0; i < 32; i = i + 1) begin
      data[0][8 * adr + i] = temp_reg[0][i];
      data[1][8 * adr + i] = temp_reg[1][i];
      data[2][8 * adr + i] = temp_reg[2][i];
      data[3][8 * adr + i] = temp_reg[3][i];
    end

    for ( i = 0; i < 32; i = i + 1) begin
      out[i] = data[0][i];
      out[i + 32] = data[1][i];
      out[i + 64] = data[2][i];
      out[i + 96] = data[3][i];
    end
  end

endmodule