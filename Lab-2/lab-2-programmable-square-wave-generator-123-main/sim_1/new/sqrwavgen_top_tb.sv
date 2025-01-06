`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 11:32:21 AM
// Design Name: 
// Module Name: sqrwavgen_top_tb
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

module sqrwavgen_top_tb();
    
    logic clk, rst;
    logic [3:0] m, n;
    logic wave_out;
    
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
    
    sqrwavgen_top TB(
        .clk(clk),
        .rst(rst),
        .m(m),    // controls HIGH
        .n(n),    // controls LOW
        .wave_out(wave_out)
        );
    
    initial
    begin
        rst = 1;
        m = 4'd1;
        n = 4'd1;
        
        #(10 * `clock_period)
        rst = 0;
        
        #(40 * `clock_period)
        m = 4'd4;
        n = 4'd2;
        
        #(100 * `clock_period)
        $finish;
    end
    
endmodule
