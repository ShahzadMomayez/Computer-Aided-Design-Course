module dpath(input memW , clk , buf88w , buf88sh , buf44sh , buf8RegJmp , muxBuf44sel , regBuf44rst
	, buf16w , mux161sel , macRst , macEn , shRegRst , shRegEn , shRegSh ,count16MuxRst 
	, count16muxEn,Xrst,Yrst,Zrstt, input[1:0] memMuxSel, 
	input muxXsel,muxYsel,muxZsel,regBuf88rst,input[1:0]muxBuf88Sel ,input[8:0] x_ , y_ , z_
	,output count16muxCout);
	wire[31:0] memData , memOut ;
        wire[8:0]memAdr,buf88adr,buf44adr;
	wire[7:0] macInput1 , macInput2 , macOutput ;
	wire[127:0] buf88out , buf44out , buf16out;
	wire[3:0] mux16sel;
	wire [8:0] Xinput,Xoutput , Yinput,Youtput,Zinput ,Zoutput ;
	wire [8:0] adrXinput,adrYinput,adrZinput;
	wire [8:0] adrBuf88input , adrBuf88Out;
	wire [8:0] adderBuf44input , adrBuf44Out;
	wire jmp;
	mux2to1 mux2X(9'b0,9'd1,muxXsel,adrXinput);
	mux2to1 mux2Y(9'b0,9'd1,muxYsel,adrYinput);
	mux2to1 mux2Z(9'b0,9'd1,muxZsel,adrZinput);
	adder adrY(adrYinput,Youtput,Yinput);
	adder adrX(adrXinput,Xoutput,Xinput);
	adder adrZ(adrZinput,Zoutput,Zinput);
	Reg regX(clk,Xrst,jmp,Xinput,x_,Xoutput);
	Reg regY(clk,Yrst,jmp,Yinput,y_,Youtput);
	Reg regZ(clk,Zrst,jmp,Zinput,z_,Zoutput);
	mux4to1 muxMem(Xoutput,Youtput,Zoutput,9'b0,memMuxSel,memAdr);
	mem m(memData ,memW , clk , memAdr , memOut);
	mux4to1 mux88Buf(9'b0,9'd4,9'd1 ,9'b0,muxBuf88sel,adrBuf88input);
	adder ad88Buf(adrBuf88input, buf88adr,adrBuf88Out);
	Reg reg88Buf(clk,regBuf88rst,buf8RegJmp,adrBuf88output,9'b0,buf88adr);
	buf16to4 buf88(memOut,buf88w, clk, buf88sh,buf88adr,buf88out);

	adder adder_buf44(adder_buf44_in, buf44_adr,adder_buf44_out);
	mux2to1 mux_buf44(9'b0,9'd32,mux_buf44_sel,adder_buf44_in);
	buf44 buf44(mem_out,buf44_write, clk,buf44_adr,buf44_out);
	register reg_buf44(clk,reg_buf44_reset,jmp,adder_buf44_out,9'b0,buf44_adr);

	buf16 b16(buf88out,buf16W, clk,buf16out);
	counter count16(clk,count16muxrst,count16muxEn,count16muxCout,mux16sel);
	mux16 mux16in44(buf44out,mux16sel,macInput1);
	mux16 mux16in16(buf16out,mux16sel,macInput2);
	mac mac_(clk,macRst,macInput1 , macInput2 ,macEn, macOutput);
	shReg sh_reg(clk,shRegRst,shRegSh,shRegEn,macOutput,memData);
endmodule