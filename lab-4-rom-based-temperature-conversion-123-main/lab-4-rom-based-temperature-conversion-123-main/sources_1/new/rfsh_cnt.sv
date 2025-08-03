`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 12:04:58 PM
// Design Name: 
// Module Name: rfsh_cnt
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


// refresh counter
module rfsh_cnt(
    input logic clk,
    output logic [2:0] out = 0
    );
    
    always_ff @(posedge clk)
        out <= out + 1;
        
endmodule
