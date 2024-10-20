`timescale 1ns/1ns
module MultTB;
  
  reg [31:0] number1;
  reg [31:0] number2;
  wire [31:0] product;
  
  // Instantiate the module
  Mult dut (
    number1,
    number2,
    product
  );
  
  // Test inputs
  initial begin
    number1 = 32'h3e4ccccd; // 0.2
    number2 = 32'h4083288d; // 4.0987
    
    #10;
    
    number1 = 32'h3f800000; // 1
    number2 = 32'h4083288d; // 4.0987

    #10
    $stop;
  end
endmodule
