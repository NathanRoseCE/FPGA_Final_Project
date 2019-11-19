`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 06:23:41 PM
// Design Name: 
// Module Name: data_register
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


module data_register(
        input CLK, 
        input[15:0] a_val_in, b_val_in,
        input[3:0] c_addr_in,
        input[7:0] addr_in,
        input[2:0] alu_ctl_in,
        input[1:0] JCTL_in, 
        input data_read_in, data_write_in, reg_addr_in, reg_write_in,
        
        output reg [15:0] a_val, b_val,
        output reg [3:0] c_addr,
        output reg [7:0] addr,
        output reg [2:0] alu_ctl,
        output reg [1:0] JCTL, 
        output reg  data_read, data_write, reg_addr, reg_write
    );
    assign CLK_INV = ~CLK;
   
   always@(posedge CLK_INV) begin
        a_val =  a_val_in;
        b_val = b_val_in;
        c_addr = c_addr_in;
        addr = addr_in;
        alu_ctl = alu_ctl_in;
        JCTL = JCTL_in;
        data_read = data_read_in;
        data_write = data_write_in;
        reg_addr = reg_addr_in;
        reg_write = reg_write_in;
   end
    
endmodule
