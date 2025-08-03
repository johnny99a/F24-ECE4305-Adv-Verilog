`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 12:37:20 PM
// Design Name: 
// Module Name: digit_separator_tb
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


module digit_separator_tb();
    
    logic [7:0] num_in;
    logic [11:0] digit_out;
    
    digit_separator TB(
        .num_in(num_in),
        .digit_out(digit_out)
        );
    
    initial
    begin
        num_in = 8'b01001111;
        
        #10
        $finish;
    end
    
endmodule
