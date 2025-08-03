`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 12:04:58 PM
// Design Name: 
// Module Name: ssd_driver
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


module ssd_driver(
    input logic [3:0] inp,                  // input
    //input logic ssd_driver_port_idp,              // input decimal point
    //output logic [3:0] ssd_driver_port_led,
    output logic [6:0] cc_out               // 7 segments making up the display
    //output logic ssd_driver_port_odp,             // output decimal point
    );
    
//    assign ssd_driver_port_odp = ~ssd_driver_port_idp;
//    assign ssd_driver_port_led = inp;
    
    logic [6:0] ssd_driver_tmp_cc;
    logic [3:0] ssd_driver_digit;
    
    assign ssd_driver_digit = inp;
    
    always_ff @ (ssd_driver_digit)
    begin
        case (ssd_driver_digit)
            4'h0:   ssd_driver_tmp_cc = 7'b1000000;
            4'h1:   ssd_driver_tmp_cc = 7'b1111001;
            4'h2:   ssd_driver_tmp_cc = 7'b0100100;
            4'h3:   ssd_driver_tmp_cc = 7'b0110000;
            4'h4:   ssd_driver_tmp_cc = 7'b0011001;
            4'h5:   ssd_driver_tmp_cc = 7'b0010010;
            4'h6:   ssd_driver_tmp_cc = 7'b0000010;
            4'h7:   ssd_driver_tmp_cc = 7'b1111000;
            4'h8:   ssd_driver_tmp_cc = 7'b0000000;
            4'h9:   ssd_driver_tmp_cc = 7'b0010000;
            //4'hA:   ssd_driver_tmp_cc = 7'b0001000;
            //4'hB:   ssd_driver_tmp_cc = 7'b0000011;
            //4'hC:   ssd_driver_tmp_cc = 7'b1000110;
            //4'hD:   ssd_driver_tmp_cc = 7'b0100001;
            //4'hE:   ssd_driver_tmp_cc = 7'b0000110;
            //4'hF:   ssd_driver_tmp_cc = 7'b0001110;

            default: ssd_driver_tmp_cc = 7'hZZ;
        endcase
    end
    
    assign cc_out = ssd_driver_tmp_cc;
    
endmodule
