`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 07:47:41 PM
// Design Name: 
// Module Name: jump_control
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


module jump_control(
    input PCLK,
    input [4:0] jump_address,
    input jump_en,
    input load_done,
    output reg [4:0] program_counter=0
    );
    
    always @(posedge PCLK)
    if (load_done==1 && program_counter!=31)
        if (jump_en==1)
            program_counter<=jump_address;
        else    
            program_counter<=program_counter+1; 
endmodule
