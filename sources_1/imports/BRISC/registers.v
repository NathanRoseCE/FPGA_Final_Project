`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2019 08:59:36 PM
// Design Name: 
// Module Name: registers
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


module registers(
    input [3:0] rega_addr,regb_addr,write_addr,
    input [15:0] write_data,
    input write_enable,
    output reg [15:0] rega_data=0,regb_data=0
    );
    reg [15:0] reg_array [15:0];
//    reg [4:0] i;
// initial
//    begin
//        for (i=0;i<16;i=i+1)
//            reg_array[i]=i;
//    end        
        
 
 
    
    always @*  begin
        rega_data<=reg_array[rega_addr];
        regb_data<=reg_array[regb_addr];
        if (write_enable==1) begin
            reg_array[write_addr]<=write_data;
        end
    end
endmodule
