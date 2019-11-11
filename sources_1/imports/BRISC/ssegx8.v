`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2019 08:32:33 PM
// Design Name: 
// Module Name: ssegx8
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

module ssegx8(
    input CLK,
    input [31:0] VALUE,
    output reg [7:0] SSEG_CA,
    output reg [7:0] SSEG_AN
    );
reg [20:0] digit_counter;
reg [3:0] digits;
always @(posedge CLK)
begin
	digit_counter<=digit_counter+1;
	case (digits)
				    // pgfedcba
		0:SSEG_CA = 8'b11000000;
		1:SSEG_CA = 8'b11111001;
		2:SSEG_CA = 8'b10100100; 
		3:SSEG_CA = 8'b10110000;
		4:SSEG_CA = 8'b10011001; 
		5:SSEG_CA = 8'b10010010; 
		6:SSEG_CA = 8'b10000010; 
		7:SSEG_CA = 8'b11111000; 
		8:SSEG_CA = 8'b10000000;
		9:SSEG_CA = 8'b10010000;
		10:SSEG_CA=~8'b11110111; 
		11:SSEG_CA=~8'b11111100; 
		12:SSEG_CA=~8'b10111001; 
		13:SSEG_CA=~8'b11011110; 
		14:SSEG_CA=~8'b11111001; 
		15:SSEG_CA=~8'b11110001; 
		
	 endcase
 
	case (digit_counter[16:14])
		0 : begin
				SSEG_AN=8'b01111111;
				digits<=VALUE[31:28];
			end
		1 : begin
				SSEG_AN=8'b10111111;
				digits<=VALUE[27:24];
			end
		2 : begin
				SSEG_AN=8'b11011111;
				digits<=VALUE[23:20];
			end
		3 : begin
				SSEG_AN=8'b11101111;
				digits<=VALUE[19:16];
			end		
        4 : begin
                SSEG_AN=8'b11110111;
                digits<=VALUE[15:12];
            end
        5 : begin
                SSEG_AN=8'b11111011;
                digits<=VALUE[11:8];
            end
        6 : begin
                SSEG_AN=8'b11111101;
                digits<=VALUE[7:4];
            end
        7 : begin
                SSEG_AN=8'b11111110;
                digits<=VALUE[3:0];
            end        		
	endcase	

end
endmodule


