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
        
        input [15:0] result_in,
        input [7:0] addr_in,
        input [3:0] c_addr_in, 
        input reg_write_in, data_read_in, data_write_in, reg_addr_in,
        
        output reg [15:0] result,
        output reg [7:0] addr,
        output reg [3:0] c_addr, 
        output reg reg_write, data_read, data_write, reg_addr
    );
    assign CLK_INV = ~CLK;
    
    always@(posedge CLK_INV) begin
        result = result_in;
        addr = addr_in;
        c_addr = c_addr_in;
        reg_write = reg_write_in;
        data_read = data_read_in;
        data_write = data_write_in;
        reg_addr = reg_addr_in;
    end
    
endmodule
