`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 06:21:04 PM
// Design Name: 
// Module Name: mn_upcount
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



module mn_upcount(
    input logic clk, rst,
    input logic [7:0] mn,
    output logic out
    );
    
    // signal declaration
    logic [7:0] count;
    
    always_ff @ (posedge clk, posedge rst)
    begin
        if (rst)
            count <= 0;
        else if (count >= mn - 1)
            count <= 0;
        else
            count <= count + 1;
    end
    
    assign out = (count >= mn - 1) ? 1 : 0;
    
endmodule
