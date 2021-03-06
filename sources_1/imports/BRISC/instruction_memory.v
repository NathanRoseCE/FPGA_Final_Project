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
    input debug,
    input UART_TXD_IN,
    input [7:0] program_counter,
    output reg load_done=0,
    output reg [15:0] instruction
    );
    reg state=0;
    reg [7:0] write_addr=0;
    reg [15:0] instruction_array [255:0];
    wire [7:0] o_data;
    wire o_wr;
    rxuartlite uart (.i_clk(CLK),.i_uart_rx(UART_TXD_IN),.o_wr(o_wr), .o_data(o_data));
    always @* begin
        instruction = instruction_array[program_counter];
    end
    
initial begin
    if(debug == 1) begin
        instruction_array[0]  = 16'h1350;
        instruction_array[1]  = 16'h0000;
        instruction_array[2]  = 16'h0000;
        instruction_array[3]  = 16'hD300;
        instruction_array[4]  = 16'h104E;
        instruction_array[5]  = 16'h0000;
        instruction_array[6]  = 16'h0000;
        instruction_array[7]  = 16'hF70F;
        instruction_array[8]  = 16'h0000;
        instruction_array[9]  = 16'h0000;
        instruction_array[10] = 16'hF100;
        instruction_array[11] = 16'h0000;
        instruction_array[12] = 16'h0000;
        instruction_array[13] = 16'hF316;
        instruction_array[14] = 16'h0000;
        instruction_array[15] = 16'h0000;
        instruction_array[16] = 16'hF210;
        instruction_array[17] = 16'h0000;
        instruction_array[18] = 16'h0000;
        instruction_array[19] = 16'h3044;
        instruction_array[20] = 16'h3144;
        instruction_array[21] = 16'hFFFF;
        instruction_array[22] = 16'hF507;
        instruction_array[23] = 16'hF400;
        instruction_array[24] = 16'h0000;
        instruction_array[25] = 16'h0000;
        instruction_array[26] = 16'h0000;
        instruction_array[27] = 16'h0000;
        instruction_array[28] = 16'h0000;
        instruction_array[29] = 16'h0000;
        instruction_array[30] = 16'h0000;
        instruction_array[31] = 16'h0000;
        load_done = 1;
    end
    else begin
        load_done = 0;
    end
end
always @(posedge CLK)
    begin
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
                if (write_addr==255)
                    begin 
                      load_done<=1;  
                    end
               end    
            endcase  
        end
    end    
    
endmodule

