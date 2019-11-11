`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2019 10:49:39 AM
// Design Name: 
// Module Name: input_mux
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


module input_mux(
    input [3:0] port_sel,
    input [15:0] alu_result,counter,
    input [15:0] SW,
    input [4:0] Buttons,
    input in_mux_en,
    output reg [15:0] data_to_registers
    );
 always@(*)
        begin
          if (in_mux_en==1)
                case(port_sel)  
                         4'b0000: //SW
                        begin
                            data_to_registers=SW;
                        end     
                        4'b0001: //BTNR
                        begin
                            data_to_registers={15'h0000,Buttons[3]};
                        end
                        4'b0010: //BTNC
                        begin
                            data_to_registers={15'h0000,Buttons[0]};
                        end
                        4'b0011: //counter
                        begin
                            data_to_registers=counter;
                        end
                        default: //rega
                        begin
                            data_to_registers=alu_result;
                        end
                 endcase   
          else
             data_to_registers=alu_result;           
        end
endmodule        