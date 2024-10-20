
module cntrlr (   output reg memWrite_,
    input clk_,
    output reg buf88Write_, buf88Shift_, buf44Write_, buf8RegJmp_, muxBuf44Sel_, regBuf44Reset_,
    output reg buf16Write_, mux16Sel_, macReset_, macEnable_, shRegReset_, shRegEn_, shRegSh_,
    output reg count16MuxReset_, count16MuxEn_, XReset_, YReset_, ZReset_,
    output reg [1:0] memMuxSel_,
    output reg muxXSel_, muxYSel_, muxZSel_,
    output reg regBuf88Reset_,
    output reg [1:0] muxBuf88Sel_,
    output reg done_,
    input count16MuxCout_, start_
);



parameter [4:0] STATE1 = 5'b00000;
    parameter [4:0] STATE2 = 5'b00001;
    parameter [4:0] STATE3 = 5'b00010;
    parameter [4:0] STATE4 = 5'b00011;
    parameter [4:0] STATE9 = 5'b01000;
    parameter [4:0] STATE10 = 5'b01001;
    parameter [4:0] STATE11 = 5'b01010;
    parameter [4:0] STATE12 = 5'b01011;
    parameter [4:0] STATE13 = 5'b01100;
    parameter [4:0] STATE14 = 5'b01101;
    parameter [4:0] STATE15 = 5'b01110;
    parameter [4:0] STATE16 = 5'b01111;
    parameter [4:0] STATE17 = 5'b10000;
    parameter [4:0] STATE5 = 5'b00100;
    parameter [4:0] STATE6 = 5'b00101;
    parameter [4:0] STATE7 = 5'b00110;
    parameter [4:0] STATE8 = 5'b00111;
    parameter [4:0] STATE18 = 5'b10001;
    parameter [4:0] STATE19 = 5'b10010;
    parameter [4:0] STATE20 = 5'b10011;
    parameter [4:0] STATE21 = 5'b10111;
    parameter [4:0] STATE22 = 5'b10100;
    parameter [4:0] STATE23 = 5'b10101;
    parameter [4:0] HICH = 5'b11111;


  reg [1:0] counter4AddNewLine_ = 2'b00;
    reg [3:0] counter16MacMux_ = 4'b0000;
    reg [4:0] nextState_;
    reg [1:0] make8BufCounter4Line_ = 2'b00;
    reg [1:0] make8BufCounter3Shift_ = 2'b00;
   reg [1:0] make16BufCounter4Line_ = 2'b00;
    reg [4:0] state_ = 5'b00000;
    reg [4:0] counter4Result_ = 5'b00000;
    reg [3:0] counter13Buf8Ofoghi_ = 4'b0000;
    reg [3:0] counter13Buf8Amoodi_ = 4'b0000;

    always @(posedge clk_) begin
        if (start_)
            state_ <= nextState_;
    end

    always @* begin
        case (state_)
            5'b00000: nextState_ = (start_) ? 5'b00001 : 5'b00000;
            5'b00001: nextState_ = (start_) ? 5'b00001 : 5'b00010;
            5'b00010: nextState_ = (1 != &make8BufCounter4Line_) ? 5'b00011 : (3 != make8BufCounter3Shift_) ? 5'b00100 : 5'b00101;
            5'b00011: nextState_ = 5'b00010;
            5'b00100: nextState_ = 5'b00010;
            5'b00101: nextState_ = 5'b00110;
            5'b00110: nextState_ = (1 != &make16BufCounter4Line_) ? 5'b00101 : 5'b00111;
            5'b00111: nextState_ = (&counter16MacMux_ != 1) ? 5'b10100 : 5'b01000;
            5'b10100: nextState_ = 5'b00111;
            5'b01000: nextState_ = (&counter4Result_ != 1) ? 5'b01001 : 5'b01010;
            5'b01001: nextState_ = 5'b00111;

            5'b01010: nextState_ = (counter13Buf8Ofoghi_ == 4'd13) ? 5'b01011 : 5'b01001;
            5'b01011: nextState_ = (counter13Buf8Amoodi_ == 4'd12) ? 5'b01100 : 5'b10111;
            5'b10111: nextState_ = 5'b01101;
            5'b01100: nextState_ = 5'b00000;

            5'b01101: nextState_ = (&(counter4AddNewLine_ - 1)) ? 5'b10101 : 5'b01111;
            5'b10101: nextState_ = 5'b01110;
            5'b01110: nextState_ = 5'b10100;
            5'b01111: nextState_ = 5'b10101;
            default: nextState_ = 5'b00000;
        endcase
    end

    always @(posedge clk_) begin
mux16Sel_ = 0;
macReset_ = 0;
shRegSh_ = 0;
count16MuxReset_ = 0;
count16MuxEn_ = 0;
XReset_ = 0;
YReset_ = 0;
buf88Write_ = 0;
buf88Shift_ = 0;
buf44Write_ = 0;
ZReset_ = 0;
macEnable_ = 0;
shRegReset_ = 0;
shRegEn_ = 0;
muxBuf44Sel_ = 0;
memWrite_ = 0;
buf8RegJmp_ = 0;
regBuf44Reset_ = 0;
buf16Write_ = 0;
muxXSel_ = 0;
muxYSel_ = 0;
muxZSel_ = 0;
memMuxSel_ = 0;

regBuf88Reset_ = 0;
muxBuf88Sel_ = 0;
done_ = 0;
        if (start_) begin
		 
         case (state_)
    5'b00001: begin
        {macReset_, shRegReset_, count16MuxReset_, XReset_, YReset_, ZReset_, buf8RegJmp_, regBuf44Reset_} = 8'b11111111;
    end
    5'b00010: begin
        {buf88Write_, muxXSel_} = 2'b11; muxBuf88Sel_ = 2'b01;
    end
    5'b00011: begin
        make8BufCounter4Line_ = make8BufCounter4Line_ + 1;
    end
    5'b00100: begin
        {buf88Shift_, buf8RegJmp_} = 2'b11; make8BufCounter3Shift_ = make8BufCounter3Shift_ + 1;
        make8BufCounter4Line_ = 0;
    end
    5'b00101: begin
        {memMuxSel_, regBuf88Reset_} = 2'b11;
    end
    5'b00110: begin
        {muxYSel_, muxBuf44Sel_, buf16Write_, memMuxSel_, buf44Write_} = 6'b111111;
        make16BufCounter4Line_ = make16BufCounter4Line_ + 1;
    end
    5'b00111: begin
        {count16MuxEn_, macEnable_} = 2'b11;
    end
    5'b10100: begin
        counter16MacMux_ = counter16MacMux_ + 1;
    end
    5'b01000: begin
        {shRegEn_, macReset_} = 2'b11;
        counter4Result_ = counter4Result_ + 1;
        counter13Buf8Ofoghi_ = counter13Buf8Ofoghi_ + 1;
        muxBuf88Sel_ = 2'd2;
    end
    5'b01001: begin
        {buf16Write_, count16MuxReset_, shRegSh_} = 3'b111;
        counter16MacMux_ = 0;
    end
    5'b01010: begin
        {count16MuxReset_, memWrite_, buf16Write_, shRegReset_, muxZSel_} = 5'b11111;
        memMuxSel_ = 2;
        counter4Result_ = 0;
    end
    5'b01011: begin
        counter4AddNewLine_ = counter4AddNewLine_ + 1;
        counter13Buf8Ofoghi_ = 0;
        counter13Buf8Amoodi_ = counter13Buf8Amoodi_ + 1;
    end
    5'b01100: begin
        done_ = 1;
    end
    5'b10111: begin
        {buf8RegJmp_, buf88Shift_} = 2'b11;
    end
    5'b01101: begin
        {buf88Write_, muxXSel_} = 2'b11;
        muxBuf88Sel_ = 2'b01;
    end
    5'b10101: begin
        regBuf88Reset_ = 1;
    end
    5'b01110: begin
        {buf16Write_} = 1'b1;
        counter13Buf8Ofoghi_ = 0;
        counter4Result_ = 0;
        counter16MacMux_ = 0;
    end
    5'b01111: begin
        counter4AddNewLine_ = counter4AddNewLine_ + 1;
    end
endcase
        end
    end

endmodule