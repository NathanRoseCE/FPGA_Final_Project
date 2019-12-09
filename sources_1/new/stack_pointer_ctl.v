`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2019 01:29:58 PM
// Design Name: 
// Module Name: stack_pointer_ctl
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

//bit 1 on stack ctl emphasizes whether or not jump control needs to get involved
//bit 0 on stacl ctl emphasizes whether data mem should be written or read
module stack_pointer_ctl(
        input stack_command,
        input [1:0] stack_ctl,
        output reg [7:0] stack_pointer
    );
    reg [2:0] incrament;
    reg [1:0] command;
    initial begin
        stack_pointer = 8'h3E;
        incrament = 0;
    end
    
    always@(posedge stack_command) begin
    //stack builds from 3E to 0 hence starting at 3E and building up to 0    
        command = stack_ctl;
        case(stack_ctl)
        2'h0: stack_pointer = stack_pointer + incrament - 2;//PUSH
        2'h2: stack_pointer = stack_pointer + incrament - 2;//CALL
        default: stack_pointer = stack_pointer + incrament;
        endcase
    end
    //this solves a problem with the stack where it would incrament before you needed it to
    always@(posedge ~stack_command) begin
        case(command)
        2'h1: incrament = 2;//POP
        2'h3: incrament = 2;//RETURN
        default: incrament = 0;
        endcase
    end
    
endmodule
