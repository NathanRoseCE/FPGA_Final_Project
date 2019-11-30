`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2019 03:16:16 PM
// Design Name: 
// Module Name: jump_address_mux
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


module jump_address_mux(
        input address_ctl,
        input [7:0] address_in,
        input [7:0] data_mem_val,
        output reg [7:0] address
    );
    
    always@* begin
        if(address_ctl == 0)  begin
            address = address_in;
        end
        else begin
            address = data_mem_val;
        end
    end
endmodule
