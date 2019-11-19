`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 07:28:24 PM
// Design Name: 
// Module Name: reg_write_mux
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


module reg_write_mux(
        input data_read,
        input alu_result,
        input data_result,
        output reg w_data_to_reg
    );
    
    always@* begin
        if(data_read == 1) begin
            w_data_to_reg = data_result;
        end
        else begin
            w_data_to_reg = alu_result;
        end
    end
endmodule
