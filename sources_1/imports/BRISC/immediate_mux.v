`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2019 07:25:23 PM
// Design Name: 
// Module Name: immediate_mux
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


module immediate_mux(
    input [1:0] imm_ctl,
    input [15:0] reg_data,
    input [7:0] immediate,
    input [7:0] PC,
    output reg [15:0] data_to_alu
    );
    always @*
        begin
           if (imm_ctl==1) begin
                data_to_alu={8'h00, immediate};
           end
           else if(imm_ctl == 2) begin
                data_to_alu={8'h00, PC};
           end  
           else begin
                data_to_alu=reg_data;
           end
        end          
endmodule
