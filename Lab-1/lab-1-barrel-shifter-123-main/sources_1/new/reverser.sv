`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 10:54:02 AM
// Design Name: 
// Module Name: reverser
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


module reverser
    #(parameter SIZE = 8)
    (
    input logic [SIZE - 1:0] inp,
    output logic [SIZE - 1:0] out
    );
    
    genvar i;
    
    generate
        for(i = 0; i < SIZE; i = i + 1)
        begin
            assign out[i] = inp[SIZE - 1 - i];
        end
    endgenerate
    
endmodule