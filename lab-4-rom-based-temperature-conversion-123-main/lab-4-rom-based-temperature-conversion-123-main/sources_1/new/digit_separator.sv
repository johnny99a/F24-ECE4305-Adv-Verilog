`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 12:38:58 PM
// Design Name: 
// Module Name: digit_separator
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


module digit_separator(
    input logic [7:0] num_in,
    output logic [11:0] digit_out
    );
    
    assign digit_out[3:0] = num_in % 10;            // ones
    assign digit_out[7:4] = (num_in / 10) % 10;     // tens
    assign digit_out[11:8] = (num_in / 100) % 10;   // hundreds
    
endmodule
