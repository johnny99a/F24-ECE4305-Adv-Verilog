`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 11:16:05 AM
// Design Name: 
// Module Name: rom
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


module rom
    #(parameter MEM_FILE = "c2f.mem", parameter ROWS = 213)
    (
        input logic clk,
        input logic [7:0] addr,     // # of bits for total rows
        output logic [7:0] data     // output
    );
    
    //                          # of bits   # of rows
    (*rom_style = "block"*) logic [7:0] rom [0:ROWS - 1];
    
    initial
        $readmemb(MEM_FILE, rom);
    
    always_ff @ (posedge clk)
        data <= rom[addr];
    
endmodule
