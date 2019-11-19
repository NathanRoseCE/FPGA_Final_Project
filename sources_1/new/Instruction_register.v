`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 04:51:36 PM
// Design Name: 
// Module Name: Instruction_register
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


module Instruction_register(
        input CLK,
        input [3:0] a_addr_in, b_addr_in, c_addr_in,//c = a + b
        input [7:0] immediate_val_in,
        input [7:0] addr_in,
        input [2:0] alu_control_in,
        input [1:0] JCTL_in,
        input im_sel_in, reg_write_in, data_read_in, data_write_in, reg_addr_in,
        
        output reg [3:0] a_addr, b_addr, c_addr,//c = a + b
        output reg [7:0] immediate_val,
        output reg [7:0] addr,
        output reg [2:0] alu_control,
        output reg [1:0] JCTL,
        output reg im_sel, reg_write, data_read, data_write, reg_addr 
        
        
    );
    //I was told to do it at the folling edge so here it is
    assign CLK_INV = ~CLK;
    
    always@(posedge CLK_INV) begin
        a_addr = a_addr_in;
        b_addr = b_addr_in;
        c_addr = c_addr_in;
        immediate_val = immediate_val_in;
        addr = addr_in;
        alu_control = alu_control_in;
        JCTL = JCTL_in;
        im_sel = im_sel_in;
        reg_write = reg_write_in;
        data_read = data_read_in;
        data_write = data_write_in;
        reg_addr = reg_addr_in;
    end
    
endmodule
