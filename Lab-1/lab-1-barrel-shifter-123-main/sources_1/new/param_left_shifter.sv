`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 10:21:48 AM
// Design Name: 
// Module Name: param_left_shifter
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


module param_left_shifter
    #(parameter N = 8)
    (
    input logic [N - 1:0] a,
    input logic [$clog2(N) - 1:0] amt,
    output logic [N - 1:0] y
    );
    
    logic [N - 1:0] reverse_a, shift, reverse_outp;
    
    // reverse input a bits
    reverser #(.SIZE(N)) reverse_in(
        .inp(a),
        .out(reverse_a)
    );
    
    // right shift
    param_right_shifter #(.N(N)) right_shifter(
        .a(reverse_a),
        .amt(amt),
        .y(reverse_outp)
    );
    
    // reverse right shift
    reverser #(.SIZE(N)) reverse_out(
        .inp(reverse_outp),
        .out(y)
    );
    
endmodule