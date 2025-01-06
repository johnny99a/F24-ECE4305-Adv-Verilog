`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 11:30:21 AM
// Design Name: 
// Module Name: multi_barrel_shifter_reverser
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


module multi_barrel_shifter_reverser
    #(parameter N = 8)
    (
    input [N - 1:0] a,
    input [$clog2(N) - 1:0] amt,
    input lr,
    output [N - 1:0] y
    );
    
    logic [N - 1:0] reverse_a, right_shift_out, left_shift_out;
    
    // reverse input bits
    reverser #(.SIZE(N)) reverse_in(
        .inp(a),
        .out(reverse_a)
    );
    
    // right shift: lr = 1, reverse_a   lr = 0, a
    param_right_shifter #(.N(N)) right_shifter(
        .a(lr ? reverse_a : a),
        .amt(amt),
        .y(right_shift_out)
    );
    
    // reverse right shift
    reverser #(.SIZE(N)) reverse_out(
        .inp(right_shift_out),
        .out(left_shift_out)
    );
    
    // lr = 0, lr = 1, left_shift_out   lr = 0, right_shift_out
    assign y = lr ? left_shift_out : right_shift_out;
    
endmodule