`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 11:24:39 AM
// Design Name: 
// Module Name: multi_barrel_shifter_mux
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


module multi_barrel_shifter_mux
    #(parameter N = 8)
    (
    input [N - 1:0] a,
    input [$clog2(N) - 1:0] amt,
    input lr,
    output [N - 1:0] y
    );
    
    logic [N - 1:0] right_shift_out, left_shift_out;
    
    // right barrel shifter
    param_right_shifter #(.N(N)) right_shifter(
        .a(a),
        .amt(amt),
        .y(right_shift_out)
    );
    
    // left barrel shifter
    param_left_shifter #(.N(N)) left_shifter(
        .a(a),
        .amt(amt),
        .y(left_shift_out)
    );
    
    // mux: lr = 1, left_shift_out      lr = 0, right_shift_out
    assign y = lr ? left_shift_out : right_shift_out;
    
endmodule
