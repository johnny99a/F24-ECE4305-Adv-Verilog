`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 05:17:04 PM
// Design Name: 
// Module Name: blinker_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blinker_tb();
    
    localparam SIZE = 16;
    localparam T = 10;  // clock period
    
    logic clk, reset;
    logic [SIZE - 1:0] inp;
    logic led_out;
    
    blinker #(.SIZE(SIZE)) TB(
        .clk(clk),
        .reset(reset),
        .inp(inp),
        .led_out(led_out)
        );
    
    // 10 ns clock running forever
    always
    begin
        clk = 1'b1;
        #(T / 2);
        clk = 1'b0;
        #(T / 2);
    end
    
    // reset for the first clk cylce
    initial
    begin
        reset = 1'b1;
        inp = 0;
        #1_000_000
        reset = 1'b0;
    end
    
    initial
    begin
        inp = 16'h0001;
        
        #10_000_000
        inp = 16'h0005;
        
        #20_000_000
        inp = 16'h000A;
        
        #40_000_000
        $finish;
    end
    
endmodule
