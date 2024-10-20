module PU(input [31:0] a1 , a2 , a3 , a4 , output [31:0] a_new , input clk , input en1 , en2 );
	wire [31:0] mult_out1 ,mult_out2, mult_out3, mult_out4 , Xo1 , Xo2 , Xo3 , Xo4 ;
	Mult m1(a1 , 32'b00111111100000000000000000000000 , mult_out1);
	Mult m2(a2 , 32'b10111110010011001100110011001101, mult_out2);
	Mult m3(a3 , 32'b10111110010011001100110011001101, mult_out3);
	Mult m4(a4 , 32'b10111110010011001100110011001101 , mult_out4);
	Mem4PU mem4(mult_out1 ,mult_out2, mult_out3, mult_out4 , clk , en1 , Xo1,Xo2,Xo3,Xo4 );
	wire [31:0] add1_res , add2_res , add3_res , out;
	wire exception1 , exception2 , exception3;
	Adder ad1(Xo1,Xo2,add1_res,exception1);
	Adder ad2(Xo3,Xo4,add2_res,exception2);
	Adder ad3(add1_res,add2_res,add3_res,exception3);
	Mux2To1 m21(add3_res, 32'b00000000000000000000000000000000,add3_res[31],out);
	Mem1PU mem1pu(out , clk , en2 , a_new );
endmodule
