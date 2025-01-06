`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 10:56:22 AM
// Design Name: 
// Module Name: reverser_tb
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


module reverser_tb
    #(parameter SIZE_TB = 8)
    ();
    
    logic [SIZE_TB - 1:0] inp_tb;
    logic [SIZE_TB - 1:0] out_tb;
    
    reverser #(.SIZE(SIZE_TB)) TB(
        .inp(inp_tb),
        .out(out_tb)
    );
    
    initial
    begin
        inp_tb = 8'b11010010;
        
        #10
        $finish;
    end
    
endmodule