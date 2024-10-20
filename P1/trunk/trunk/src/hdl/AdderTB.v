`timescale 1ns/1ns
module Adder_Testbench;

  reg [31:0] a;
  reg [31:0] b;
  wire [31:0] result;
wire o;
  
  Adder uut (
    a,
    b,
    result,o
  );
  
  initial begin
    // Test case 1: Positive numbers
    a = 32'h3F800000; // 1.0
    b = 32'hbf19999a; // -0.6
    #10;
    $display("Result: %f", result);
    
    // Test case 2: Negative numbers
    a = 32'h3f800000; // 1.0
    b = 32'hbf8a3d71; // -1.08
    #10;
    $display("Result: %f", result);
    
    // Test case 3: Mixed sign numbers
    a = 32'h3F800000; // 1.0
    b = 32'hC0000000; // -2.0
    #10;
    $display("Result: %f", result);
    
    // Add more test cases as needed
    
    $stop;
  end
  
endmodule
