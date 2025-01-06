`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 09:28:17 PM
// Design Name: 
// Module Name: mux_2x1_tb
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


module mux_2x1_tb();
    
    logic [3:0] in0, in1;
    logic sel;
    logic [7:0] out;
    
    mux_2x1 TB(
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)  
        );
    
    initial
    begin
        in0 = 4'd1;
        in1 = 4'd1;
        sel = 0;
        
        #10
        in0 = 4'd4;
        in1 = 4'd2;
        
        #10
        sel = 1;
        
        #10
        $finish;
    end
    
endmodule
