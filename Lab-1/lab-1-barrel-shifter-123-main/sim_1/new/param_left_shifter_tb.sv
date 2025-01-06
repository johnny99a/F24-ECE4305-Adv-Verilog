`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2024 10:33:58 AM
// Design Name: 
// Module Name: param_left_shifter_tb
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


module param_left_shifter_tb
    #(parameter N_TB = 8)
    ();
    
    logic [N_TB - 1:0] a_tb;
    logic [$clog2(N_TB) - 1:0] amt_tb;
    logic [N_TB - 1:0] y_tb;
    
    param_left_shifter #(.N(N_TB)) TB(
        .a(a_tb),
        .amt(amt_tb),
        .y(y_tb)
    );
    
    integer i;
    
    initial
    begin
        a_tb = 8'b11010010;
        
        for(i = 0; i < N_TB; i = i + 1)
        begin
            #10
            amt_tb = i;
        end
        
        #10
        $finish;
        
    end
    
endmodule