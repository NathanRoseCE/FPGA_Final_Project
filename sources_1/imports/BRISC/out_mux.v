`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2019 01:19:45 PM
// Design Name: 
// Module Name: out_mux
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


module out_mux(
    input CLK,
    input [3:0] port_sel,
    input out_write_en,
    input [15:0] data_out,
    output reg [15:0] port0=0,
    output reg [15:0] port1=0,
    output reg [15:0] port2=0
    );
    always @(posedge CLK)
        begin
        if (out_write_en==1)
            begin
                case(port_sel)
                0: begin
                   port0=data_out;
                   port1=port1;
                   port2=port2;
                   end
                1: begin
                   port0=port0;
                   port1=data_out;
                   port2=port2;
                   end
                2: begin
                   port0=port0;
                   port1=port1;
                   port2=data_out;
                   end       
                default: begin
                   port0=port0;
                   port1=port1;
                   port2=port2;
                   end   
                endcase 
           end
        else 
            begin
                port0=port0;
                port1=port1;
                port2=port2;
            end                  
    end                    
endmodule
