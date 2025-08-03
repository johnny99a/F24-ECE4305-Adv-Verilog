`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 12:34:13 PM
// Design Name: 
// Module Name: upcounter
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


module upcounter
    #(parameter SIZE = 16)
    (
    input logic clk, rst, en,
    input logic [SIZE - 1:0] inp,
    output logic out
    );
    
    // signal declaration
    logic [SIZE - 1:0] count;
    
    always_ff @ (posedge clk, posedge rst)
    begin
        if (rst || (count > inp - 1))
            count <= 0;
        else if (en)
            count <= count + 1;
    end
    
    assign out = (count > inp - 1) ? 1 : 0;
    
endmodule
