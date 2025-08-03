`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 12:04:58 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div 
    #(parameter SIZE = 50000000) 
    (
    input logic clk,
    input logic rst,
    output logic clk_div
    );
    
    localparam int constantNumber = SIZE;
    
//    localparam constantNumber = 50000000;   // 1 Hz
//    localparam constantNumber = 30000000;
//    localparam constantNumber = 5000;       // 10 KHz for 7 seg

    integer count;
    
    always_ff @ (posedge clk or posedge rst) 
    begin
        if (rst)
            count <= 0;
        else if (count == constantNumber - 1)
            count <= 0;
        else
            count <= count + 1;
    end
    
    always_ff @ (posedge clk or posedge rst) 
    begin
        if (rst)
            clk_div <= 1'b0;
        else if (count == constantNumber - 1)
            clk_div <= ~clk_div;
    end
    
endmodule
