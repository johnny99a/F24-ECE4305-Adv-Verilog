`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 04:06:39 PM
// Design Name: 
// Module Name: param_right_shifter
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


module param_right_shifter
    #(parameter N = 8)
    (
    input logic [N - 1:0] a,
    input logic [$clog2(N) - 1:0] amt,
    output logic [N - 1:0] y
    );
    
    localparam x = $clog2(N);
    
    // x stages
    logic [N - 1:0] sN[0:x - 1];
    
    // stage 0, shift 0 or 1 bit
    assign sN[0] = amt[0] ? {a[0], a[N - 1:1]} : a;
    
    // shift x stages
    genvar i;
    generate
        for(i = 1; i < x; i = i + 1)
        begin
            assign sN[i] = amt[i] ? {sN[i - 1][2**i - 1:0], sN[i - 1][N - 1:2**i]} : sN[i - 1];
        end
    endgenerate
    
    assign y = sN[x - 1];
    
endmodule
