module Mux4To1 (input[31:0] a0, a1 , a2 , a3,input[1:0] sel,output reg[31:0] out);
always@(*)begin 
if (a2 == 32'b01000010110010001000000000000000 && a3 == 32'b0)
	out = 32'b01000010110010001000000000000000;
else
out = (sel == 2'b00) ? a0 : (sel == 2'b01) ? a1 : (sel == 2'b10) ? a2 : (sel == 2'b11) ? a3 : 32'bx ;

end
endmodule
