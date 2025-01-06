`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 11:16:16 AM
// Design Name: 
// Module Name: sqrwavgen_top
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


module sqrwavgen_top(
    input logic clk, rst,
    input logic [3:0] m,    // controls HIGH
    input logic [3:0] n,    // controls LOW
    output logic wave_out
    );
    
    logic [7:0] mn_wire;
    logic counter_out_wire;
    
    mux_2x1 MUX(
        .in0(m),
        .in1(n),
        .sel(wave_out),
        .out(mn_wire)
        );
    
    mn_upcount UPCOUNTER(
        .clk(clk),
        .rst(rst),
        .mn(mn_wire),
        .out(counter_out_wire)
        );
    
    t_ff T_FF(
        .clk(clk),
        .rst(rst),
        .t(counter_out_wire),
        .q(wave_out)
        );
    
endmodule
