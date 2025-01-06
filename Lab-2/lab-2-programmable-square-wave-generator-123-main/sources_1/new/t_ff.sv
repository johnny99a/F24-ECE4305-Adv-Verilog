`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 04:39:40 PM
// Design Name: 
// Module Name: t_ff
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


module t_ff(
    input logic clk, rst, t,
    output logic q
    );
    
    always_ff @ (posedge clk, posedge rst)
    begin
        if (rst)
            q <= 0;
        else 
        begin
            if (t)
                q <= ~q;
            else
                q <= q;
        end
    end
    
endmodule
