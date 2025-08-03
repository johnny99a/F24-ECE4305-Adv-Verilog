`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 12:22:15 PM
// Design Name: 
// Module Name: blinker
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


module blinker
    #(parameter SIZE = 16)
    (
    input logic clk,
    input logic reset,
    input logic [SIZE - 1:0] inp,
    output logic led_out
    );
    
    // signal declaration
    logic timer_1ms;
    logic uc_out;
    
    // blinker logic
    timer_param #(.FINAL_VALUE(100_000)) timer(
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .done(timer_1ms)
        );
    
    upcounter #(.SIZE(SIZE)) counter(
        .clk(clk),
        .rst(reset),
        .en(timer_1ms),
        .inp(inp),
        .out(uc_out)
        );
    
    t_ff tff(
        .clk(clk),
        .rst(reset),
        .t(uc_out),
        .q(led_out)
        );
    
endmodule
