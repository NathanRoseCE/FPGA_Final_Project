`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 06:50:41 PM
// Design Name: 
// Module Name: execution_register
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


module execution_register(
        input CLK,
        
        input [15:0] data_val_in, result_in,
        input [3:0] c_addr_in, 
        input reg_write_in, data_read_in,
        
        output reg [15:0] data_val, result,
        output reg [3:0] c_addr, 
        output reg reg_write, data_read
    );
    assign CLK_INV = ~CLK;
    
    always@(posedge CLK_INV) begin
        data_val = data_val_in;
        result = result_in;
        c_addr = c_addr_in;
        reg_write = reg_write_in;
        data_read = data_read_in;
    end
    
endmodule