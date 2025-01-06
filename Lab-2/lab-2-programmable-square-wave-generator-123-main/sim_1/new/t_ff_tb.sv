`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 09:53:24 PM
// Design Name: 
// Module Name: t_ff_tb
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

`define clock_period 10

module t_ff_tb();
    
    logic clk, rst, t;
    logic q;
    
    // Generating clock 100 MHz
    initial
    begin:INIT_CLK
        clk = 1;
    end
    always
    begin:PERIODIC_UPDATE
        #(`clock_period/2)
        clk = ~clk;
    end
    
    t_ff TB(
        .clk(clk),
        .rst(rst),
        .t(t),
        .q(q)
        );
    
    initial
    begin
        rst = 1;
        t = 0;
        
        #(`clock_period)
        rst = 0;
        
        #(`clock_period)
        t = 1;
        
        #(`clock_period)
        t = 0;
        
        #(`clock_period)
        $finish;
    end
    
endmodule
