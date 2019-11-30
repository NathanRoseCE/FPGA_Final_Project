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
        input [1:0] stack_ctl_in,
        input [7:0] stack_pointer_in,
        input [1:0] j_ctl_in,
        input [1:0] alu_flags_in,
        input stack_command_in,
        
        output reg [15:0] result,
        output reg [7:0] addr,
        output reg [3:0] c_addr, 
        output reg reg_write, data_read, data_write, reg_addr,
        output reg [1:0] stack_ctl,
        output reg [7:0] stack_pointer,
        output reg [1:0] j_ctl,
        output reg [1:0] alu_flags,
        output reg stack_command
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
        stack_pointer = stack_pointer_in;
        stack_ctl = stack_ctl_in;
        j_ctl = j_ctl_in;
        alu_flags = alu_flags_in;
        stack_command = stack_command_in;
    end
    
endmodule
