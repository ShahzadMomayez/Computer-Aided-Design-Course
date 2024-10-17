
module TopConv (
    input clk_, start_,
    input [8:0] x_, y_, z_,
    output done_
);

    wire memWrite_, buf88Write_, buf88Shift_, buf44Write_, buf8RegJmp_, muxBuf44Sel_, regBuf44Reset_
        , buf16Write_, mux161Sel_, macReset_, macEnable_, shRegReset_, shRegEn_, shRegSh_, count16MuxReset_
        , count16MuxEn_, XReset_, YReset_, ZReset_;
    wire [1:0] memMuxSel_;
    wire muxXSel_, muxYSel_, muxZSel_, regBuf88Reset_;
    wire [1:0] muxBuf88Sel_;
    wire count16MuxCout_;

    cntrlr c_(
        memWrite_, clk_,
        buf88Write_, buf88Shift_, buf44Write_, buf8RegJmp_, muxBuf44Sel_, regBuf44Reset_,
        buf16Write_, mux161Sel_, macReset_, macEnable_, shRegReset_, shRegEn_, shRegSh_,
        count16MuxReset_, count16MuxEn_, XReset_, YReset_, ZReset_,
        memMuxSel_,
        muxXSel_, muxYSel_, muxZSel_,
        regBuf88Reset_,
        muxBuf88Sel_,
        done_,
        count16MuxCout_, start_
    );

    dpath d_(
        memWrite_, clk_,
        buf88Write_, buf88Shift_, buf44Write_, buf8RegJmp_, muxBuf44Sel_, regBuf44Reset_,
        buf16Write_, mux161Sel_, macReset_, macEnable_, shRegReset_, shRegEn_, shRegSh_,
        count16MuxReset_, count16MuxEn_, XReset_, YReset_, ZReset_,
        memMuxSel_,
        muxXSel_, muxYSel_, muxZSel_,
        regBuf88Reset_,
        muxBuf88Sel_,
        x_, y_, z_,
        count16MuxCout_
    );

endmodule