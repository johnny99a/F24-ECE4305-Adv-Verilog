`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 12:04:58 PM
// Design Name: 
// Module Name: bcd_ctrl
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


module bcd_ctrl(
    input logic [2:0] rc_in,        // from refresh counter
    input logic [11:0] inp,         // input
    input logic [11:0] convert,     // conversion output
    output logic [3:0] out
    );
    
    always_comb
    begin
        case (rc_in)
            3'd0:  out = inp[3:0]; 
            3'd1:  out = inp[7:4];
            3'd2:  out = inp[11:8];
            //3'd3:  out = inp[15:12];
            3'd4:  out = convert[3:0];
            3'd5:  out = convert[7:4];
            3'd6:  out = convert[11:8];
            //3'd7:  out = convert[15:12];
            
            default: out = 4'd0;
        endcase
    end
    
endmodule
