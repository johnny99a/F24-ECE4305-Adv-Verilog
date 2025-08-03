`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 12:38:27 PM
// Design Name: 
// Module Name: timer_param
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


module timer_param
    #(parameter FINAL_VALUE = 100_000)  // 100000 for 1 ms
    (
    input logic clk,
    input logic reset,
    input logic enable,
    //    output [BITS - 1:0] Q, // we don't care about the value of the counter
    output logic done
    );
    
    localparam BITS = $clog2(FINAL_VALUE);
    
    logic [BITS - 1:0] Q_reg, Q_next;
    
    always_ff @(posedge clk, posedge reset)
    begin
        if (reset)
            Q_reg <= 'b0;
        else if (enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    // Next state logic
    assign done = Q_reg == FINAL_VALUE;
    
    always_comb
        Q_next = done ? 'b0 : Q_reg + 1;
    
endmodule
