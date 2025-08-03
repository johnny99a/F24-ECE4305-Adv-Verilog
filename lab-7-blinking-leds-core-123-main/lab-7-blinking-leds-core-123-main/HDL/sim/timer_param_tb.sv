`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 04:28:41 PM
// Design Name: 
// Module Name: timer_param_tb
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


module timer_param_tb();
    
    localparam FINAL_VALUE = 100_000;
    localparam T = 10;  // clock period
    
    logic clk;
    logic reset;
    logic enable;
    logic done;
    
    timer_param #(.FINAL_VALUE(FINAL_VALUE)) TB(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .done(done)
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
        enable = 1'b0;
//        @(posedge clk); 
        #1_000_000
        reset = 1'b0;
    end
    
    initial
    begin
        @(posedge clk);
        enable = 1'b1;
        
        #4_000_000
        $finish;
    end
    
endmodule
