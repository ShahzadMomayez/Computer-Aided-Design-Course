module datapath #(parameter P = 0)(input clk , done , 
	input muxX_sel, muxY_sel , muxZ_sel, mem_mux_sel,mux_buf44_sel, input[1:0] mux_buf4x16_sel ,
	input[8:0] X, Y, Z,
	input mem_write, buf4x16_write , buf16_write, count16_mux_en, count_PE_en , MAC_en , ofm_write, shift_reg_we , input[P-1 : 0] buf4x4_we, 
	input reg_buf4x16_reset, X_reset, Y_reset , Z_reset , buf4x16_reg_jmp, count16_mux_reset , MAC_rst, counter_PE_rst , shift_reg_rst , reg_buf44_reset,
	buf4x16_shift , reg_shift , 
	output count16_mux_cout , count_PE_cout );

	wire [8:0] adderX_in,adderY_in , adderZ_in;
	wire [31:0] mem_out ;
	wire [8:0] Y_out , X_out , Z_out;
	wire [8:0] Y_in , X_in , Z_in;
	wire [8:0] mem_adr;
	wire [8:0] adder_buf4x16_in;
	wire [8:0] buf4x16_adr , adder_buf4x16_out , adder_buf44_in , buf44_adr , adder_buf44_out;
	wire[127:0] buf4x16_out , buf16_out;
	wire [3:0] mux16_sel;
	wire [7:0] mac2Input;
	wire jmp;

	mux2_1_9bit muxX(.in0(9'd0),.in1(9'd1),.sel(muxX_sel),.out(adderX_in));
	mux2_1_9bit muxY(.in0(9'd0),.in1(9'd1),.sel(muxY_sel),.out(adderY_in));
	Adder adderY(.A(adderY_in),.B(Y_out),.Sum(Y_in));
	Adder adderX(.A(adderX_in),.B(X_out),.Sum(X_in));
	register X_reg(.clk(clk),.rst(X_reset),.jmp(),.data_in(X_in),.default_val(X),.data_out(X_out));
	register Y_reg(.clk(clk),.rst(Y_reset),.jmp(),.data_in(Y_in),.default_val(Y),.data_out(Y_out));
	mux2_1_9bit mem_mux(.in0(X_out),.in1(Y_out),.sel(mem_mux_sel),.out(mem_adr));
	Memory mem(.inp() , .we() , .clk(clk) , .adr(mem_adr) ,.out(mem_out));

	mux4_1_9bit buf4x16_mux(.in0(9'd0),.in1(9'd4),.in2(9'd1),.in3(9'b0),.sel(mux_buf4x16_sel),.out(adder_buf4x16_in));
	Adder adder_buf4x16(.A(adder_buf4x16_in), .B(buf4x16_adr),.Sum(adder_buf4x16_out));
	register reg_buf4x16(.clk(clk),.rst(reg_buf4x16_reset),.jmp(buf4x16_reg_jmp),.data_in(adder_buf4x16_out),.default_val(9'b0),.data_out(buf4x16_adr));
	Buffer_16x4 buf4x16(.data_in(mem_out),.we(buf4x16_write), .clk(clk), .shift_up(buf4x16_shift),.address(buf4x16_adr),.data_out(buf4x16_out));

	Buffer_16 buf16(.data_in(buf4x16_out),.we(buf16_write), .clk(clk),.data_out(buf16_out));
	counter #(.N(16) , .M(4)) Counter_buf16(.clk(clk),.rst(count16_mux_reset),.en(count16_mux_en),.cout(count16_mux_cout),.count(mux16_sel));
	mux_16to1 mux16_1_16(.data_inputs(buf16_out),.select(mux16_sel),.out(mac2Input));

	mux2_1_9bit muxZ(.in0(9'd0),.in1(9'd1),.sel(muxZ_sel),.out(adderZ_in));
	Adder adderZ(.A(adderZ_in),.B(Z_out),.Sum(Z_in));
	register Z_reg(.clk(clk),.rst(Z_reset),.jmp(),.data_in(Z_in),.default_val(Z),.data_out(Z_out));

	Adder adder_buf44(adder_buf44_in, buf44_adr,adder_buf44_out);
	mux2_1_9bit mux_buf44(9'b0,9'd32,mux_buf44_sel,adder_buf44_in);
	register reg_buf44(clk,reg_buf44_reset,jmp,adder_buf44_out,9'b0,buf44_adr);

	genvar i;
    	generate
        for (i = 0; i < P; i = i + 1)
        begin
		PE pe(.clk(clk),.bufferInput(mem_out),.buf4x4_we((buf4x4_we[i])),.sel(mux16_sel),.mac2Input(mac2Input),
	.Mac_en(MAC_en),.Mac_rst(MAC_rst),.shif_shift(reg_shift),.counter_en(count_PE_en),.counter_rst(counter_PE_rst),.wr(ofm_write),
	.addr(Z_out),.counter_cout(count_PE_cout),.done(done),.number(i) , .shift_rst(shift_reg_rst) , .shift_write(shift_reg_we) , .buf_addr(buf44_adr) );
        end
    endgenerate
endmodule

