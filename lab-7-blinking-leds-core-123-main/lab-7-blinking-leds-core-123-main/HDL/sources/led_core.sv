`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 05:18:49 PM
// Design Name: 
// Module Name: led_core
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


module led_core
    #(parameter SIZE = 16)  // SIZE of blinker register
    (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port
    output logic [3:0] dout
    );
    
    // declaration
    logic [SIZE-1:0] delay_reg[0:3];    // registers for each blinker
    logic wr_en;
    
    // output buffer register
    always_ff @(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            delay_reg[0] <= 0;
            delay_reg[1] <= 0;
            delay_reg[2] <= 0;
            delay_reg[3] <= 0;
        end
        else
        begin
            // write into reg for addresses 0,1,2,3
            if (wr_en)
            begin
                case (addr)
                    5'd0:   delay_reg[0] <= wr_data[SIZE-1:0];
                    5'd1:   delay_reg[1] <= wr_data[SIZE-1:0];
                    5'd2:   delay_reg[2] <= wr_data[SIZE-1:0];
                    5'd3:   delay_reg[3] <= wr_data[SIZE-1:0];
                    default: ;  // null
                endcase
            end
        end
    end
    
    // decoding logic
    assign wr_en = cs && write;
    // slot read interface
    assign rd_data =  0;
    
    // 4 blinkers
    blinker #(.SIZE(SIZE)) blinker_0(
        .clk(clk),
        .reset(reset),
        .inp(delay_reg[0]),
        .led_out(dout[0])
        );
    
    blinker #(.SIZE(SIZE)) blinker_1(
        .clk(clk),
        .reset(reset),
        .inp(delay_reg[1]),
        .led_out(dout[1])
        );
    
    blinker #(.SIZE(SIZE)) blinker_2(
        .clk(clk),
        .reset(reset),
        .inp(delay_reg[2]),
        .led_out(dout[2])
        );
    
    blinker #(.SIZE(SIZE)) blinker_3(
        .clk(clk),
        .reset(reset),
        .inp(delay_reg[3]),
        .led_out(dout[3])
        );
    
endmodule
