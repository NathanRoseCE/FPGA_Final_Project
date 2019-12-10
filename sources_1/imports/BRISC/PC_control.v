`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 07:47:41 PM
// Design Name: 
// Module Name: jump_control
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


module PC_control(
    input CLK,
    input [7:0] jump_address,
    input jump_en,
    input load_done,
    input halt,
    output reg [7:0] program_counter=0
    );
    reg jumped;;
    reg jump_ack;
    reg [4:0] nextAddr = 0;
    initial begin
        jumped = 0;
        jump_ack = 0;
    end
    always@(*) begin
        if(jump_ack == 1) begin
            jumped <= 0;
        end
        else if (jump_en==1) begin
            nextAddr<=jump_address;
            jumped <= 1;
        end
    end
    always @(posedge ~CLK)
    if ( (load_done==1) && (program_counter!=255) && (halt==0) ) begin
        if(jumped == 0 ) begin
            program_counter<=program_counter+1; 
            jump_ack <= 0;
        end
        else begin
            program_counter <= nextAddr;
            jump_ack <= 1;
        end
    end 
    
endmodule
