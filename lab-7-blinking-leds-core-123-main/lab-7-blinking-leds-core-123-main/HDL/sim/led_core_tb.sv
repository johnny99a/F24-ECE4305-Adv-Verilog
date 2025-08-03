`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 04:27:54 PM
// Design Name: 
// Module Name: led_core_tb
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


module led_core_tb();
    
    localparam T = 10;  // clock period
    
    logic clk;
    logic reset;
    logic cs;
    logic read;
    logic write;
    logic [4:0] addr;
    logic [31:0] wr_data;
    logic [31:0] rd_data;
    logic [3:0] dout;
    
    led_core TB(.*);
    
    // 10 ns clock running forever
    always
    begin
        clk = 1'b1;
        #(T / 2);
        clk = 1'b0;
        #(T / 2);
    end
    
    // reset for the first clk cylce
    initial
    begin
        reset = 1'b1;
        cs = 1'b0;
        write = 1'b0;
        addr = 1'b0;
        wr_data = 32'd0;
        #1_000_000
        reset = 1'b0;
    end
    
    initial
    begin
        cs = 1'b1;
        write = 1'b1;
        
        // blinker 0
        addr = 5'd0;
        wr_data = 32'd1;
        
        // blinker 1
        #5_000_000
        addr = 5'd1;
        wr_data = 32'd5;
        
        // blinker 2
        #25_000_000
        addr = 5'd2;
        wr_data = 32'd10;
        
        // blinker 3
        #50_000_000
        addr = 5'd3;
        wr_data = 32'd15;
        
        #75_000_000;        
        $finish;
    end
    
endmodule
