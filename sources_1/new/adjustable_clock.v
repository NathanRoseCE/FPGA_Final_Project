`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 08:42:57 AM
// Design Name: 
// Module Name: adjustable_clock
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


module adjustable_clock(
        input CLK,
        input load_done,
        input [15:0] SW,
        
        output reg LED16_B,
        output reg SCLK
    );
    
    reg SCLK=1,PCLK=1;
    reg [31:0] count=0; 
    reg [15:0] counter=0;
    always @(posedge CLK) begin
        LED16_B<=load_done;
        counter<=counter+1;
        if (count<(50000000>>SW[14:12]))
            count<=count+SW[15];
        else
            begin
                SCLK<=!SCLK;
                count<=0;
            end                              
    end 
       
endmodule
