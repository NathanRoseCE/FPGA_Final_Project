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
    input im_sel,
    input [15:0] reg_data,
    input [7:0] immediate,
    output reg [15:0] data_to_alu
    );
    always @*
        begin
            if (im_sel==1)
                data_to_alu={reg_data[15:8],immediate};
           else
                data_to_alu=reg_data;
        end          
endmodule
