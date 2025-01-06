`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 09:35:16 PM
// Design Name: 
// Module Name: mn_upcount_tb
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

module mn_upcount_tb();
    
    logic clk, rst;
    logic [7:0] mn;
    logic out;
    
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
    
    mn_upcount TB(
        .clk(clk),
        .rst(rst),
        .mn(mn),
        .out(out)
        );
    
    initial
    begin
        rst = 1;
        mn = 8'd20;
        
        #(10 * `clock_period)
        rst = 0;
        
        #(100 * `clock_period)
        $finish;
    end
    
endmodule
