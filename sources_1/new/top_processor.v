`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2019 01:01:48 PM
// Design Name: 
// Module Name: top_processor
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


module top_processor(
        input CLK,
        input [15:0] SW,
        input UART_TXD_IN,
        input [4:0] BTNS,
        output LED16_B,
        output [15:0] LED,
        output [7:0] CA,AN
    );
    wire SLCK;
    processor(
    .CLK(SLCK),
    .full_clk(CLK),
    .SW(SW),
    .UART_TXD_IN(UART_TXD_IN),
    .BTNS(BTNS),
    .LED16_B(LED16_B),
    .LED(LED),
    .CA(CA),.AN(AN)
    );
    
    adjustable_clock(
        .CLK(CLK),
        .SW(SW),
        
        .SCLK(SLCK)
    );
endmodule
