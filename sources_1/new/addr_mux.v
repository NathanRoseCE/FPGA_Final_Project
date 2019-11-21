`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 07:31:01 PM
// Design Name: 
// Module Name: addr_mux
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


module addr_mux(
        input reg_addr, 
        input PUSH, POP,
        input stack_pointer,
        input [15:0] addr,
        input [15:0] alu_result,
        output reg [15:0] true_addr
    );
    
    always@* begin
        if(reg_addr == 1) begin
            true_addr = alu_result;
        end
        else if( (PUSH == 1) || (POP == 1) ) begin
            true_addr = stack_pointer;
        end
        else begin
            true_addr = addr;
        end
    end
endmodule
