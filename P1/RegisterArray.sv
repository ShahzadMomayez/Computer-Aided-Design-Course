module RegisterArray(
    input wire [31:0] data_in [0:15],
    input wire write_en,
    input wire clk,
    output reg [31:0] data_out [0:15]
);

reg [31:0] registers [0:15];

always @(posedge clk) begin
    if (write_en) begin
        for (integer i = 0; i < 16; i = i + 1) begin
            registers[i] <= data_in[i];
        end
    end
end

// Assign the output to the stored data
assign data_out = registers;

endmodule
