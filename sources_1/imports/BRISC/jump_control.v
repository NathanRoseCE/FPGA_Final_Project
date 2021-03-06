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
        input [1:0] alu_flags, j_ctl,
        output reg j_en
    );
    
    always @* begin
        case(j_ctl)
        0: begin
            j_en = 0;
            end
        1: begin
            j_en = alu_flags[0]; //j_en = zero flag
            end
        2: begin
            j_en = alu_flags[1]; //j_en = negative flag
            end
        3: begin
            j_en = 1;
            end
        endcase
    end
    
endmodule
