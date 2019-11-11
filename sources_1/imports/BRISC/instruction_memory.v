`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2019 01:16:31 PM
// Design Name: 
// Module Name: instruction_memory
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

module Instruction_memory(
    input CLK,
    input UART_TXD_IN,
    input [4:0] program_counter,
    output reg load_done=0,
    output reg [15:0] instruction
    );
    reg state=0;
    reg [4:0] write_addr=0;
    reg [15:0] instruction_array [31:0];
    wire [7:0] o_data;
    wire o_wr;
    rxuartlite uart (.i_clk(CLK),.i_uart_rx(UART_TXD_IN),.o_wr(o_wr), .o_data(o_data));
always @(posedge CLK)
    begin
       instruction<=instruction_array[program_counter];
       if (o_wr==1 &&load_done==0)
        begin
            
            case (state)
            0:begin
                instruction_array[write_addr][15:8]<=o_data;
                state<=1;
              end
            1: begin
                instruction_array[write_addr][7:0]<=o_data;
                state<=0;     
                write_addr<=write_addr+1;
                if (write_addr==31)
                    begin 
                      load_done<=1;  
                    end
               end    
            endcase  
        end
    
    end    
    
endmodule

