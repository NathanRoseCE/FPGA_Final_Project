`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2019 09:41:01 AM
// Design Name: 
// Module Name: SevenSegment
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


module SevenSegment(
        input [31:0] VALUE,
        input CLK,
        output reg [7:0] AN,
        output reg [7:0] CA
    );
    reg [24:0] clkCounter;
    reg SLWCLK;
    reg [5:0] counter;
    reg [3:0] val [8:0];
    
    
    
    initial begin 
        clkCounter = 0;
        SLWCLK = 0;
        counter = 0;
    end
    
    always@(posedge CLK)
        begin
        if(clkCounter == 24'hFFFF) begin
            SLWCLK <= ~SLWCLK;
            clkCounter <= 0;
            end
        else begin
            clkCounter <= clkCounter + 1;
            end
        end
    
    always@(posedge SLWCLK) begin
    
        val[7] = VALUE[3:0];
        val[6] = VALUE[7:4];
        val[5] = VALUE[11:8];
        val[4] = VALUE[15:12];
        val[3] = VALUE[19:16];
        val[2] = VALUE[23:20];
        val[1] = VALUE[27:24];
        val[0] = VALUE[31:28];
        
        
        if(counter == 7) begin
            counter <= 0;
            end
        else begin
            counter <= counter + 1;
            end
        
        case(val[counter])
         0:  CA <= ~8'h3F;
         1:  CA <= ~8'h06;
         2:  CA <= ~8'h5b;
         3:  CA <= ~8'h4F;
         4:  CA <= ~8'h66;
         5:  CA <= ~8'h6D;
         6:  CA <= ~8'h7D;
         7:  CA <= ~8'h07;
         8:  CA <= ~8'h7F;
         9:  CA <= ~8'h67;
         10: CA <= ~8'h77;
         11: CA <= ~8'h7C;
         12: CA <= ~8'h39;
         13: CA <= ~8'h5E;
         14: CA <= ~8'h79;
         15: CA <= ~8'h71;
        endcase
        
        case(counter)
        0   : AN <= ~8'h80;
        1   : AN <= ~8'h40;
        2   : AN <= ~8'h20;
        3   : AN <= ~8'h10;
        4   : AN <= ~8'h08;
        5   : AN <= ~8'h04;
        6   : AN <= ~8'h02;
        7   : AN <= ~8'h01;
        endcase 
        
        end
    
    
endmodule
