`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 11:39:10 AM
// Design Name: 
// Module Name: top
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


module top(
    input logic clk,
    input logic format,             // choose between celsius or fahrenheit
    input logic [7:0] inp,
    output logic [6:0] cc_out,
    output logic [7:0] an_out
    );
    
    // signal declaration
    logic [7:0] c2f_out, f2c_out;
    logic [7:0] c2f_or_f2c;
    logic [11:0] temp_digit_sep, inp_digit_sep;
    logic clk_div_out;
    logic [2:0] rc_out;
    logic [3:0] bcd_out;
    
    // Celsius to Fahrenheit ROM
    rom #(.MEM_FILE("c2f.mem")) C2F_ROM(
        .clk(clk),
        .addr(inp),         // input
        .data(c2f_out)      // output
        );
    
    // Fahrenheit to Celsius ROM
    rom #(.MEM_FILE("f2c.mem")) F2C_ROM(
        .clk(clk),
        .addr(inp),         // input
        .data(f2c_out)      // output
        );
    
    // format == 1 -> c2f_out;  format == 0 -> f2c_out
    assign c2f_or_f2c = format ? c2f_out : f2c_out;
    
    // temperature digit sepearator into [11:0]
    digit_separator DIGIT_SEP_TEMP(
        .num_in(c2f_or_f2c),
        .digit_out(temp_digit_sep)
        );
    
    // input digit sepearator into [11:0]
    digit_separator DIGIT_SEP_INP(
        .num_in(inp),
        .digit_out(inp_digit_sep)
        );
    
    // 7 SEG DISPLAY CODE //
    // clock divider
    clk_div #(.SIZE(5000)) CLK_DIV(
        .clk(clk),
        .clk_div(clk_div_out)
        );
        
    // refresh counter
    rfsh_cnt RC(
        .clk(clk_div_out),
        .out(rc_out)
        );    
    
    // anode control
    an_ctrl AN(
        .rc_in(rc_out),     // from refresh counter
        .out(an_out)
        );
    
    // bcd control
    bcd_ctrl BCD(
        .rc_in(rc_out),             // from refresh counter
        .inp(inp_digit_sep),     // input
        .convert(temp_digit_sep),   // conversion output
        .out(bcd_out)
        );
    
    // seven seg driver
    ssd_driver SSD(
        .inp(bcd_out),      // input
        .cc_out(cc_out)     // 7 segments making up the display
        );
    
endmodule
