`timescale 1ns / 1ps
module ALU(
 input  [15:0] a,  //src1
 input  [15:0] b,  //src2
 input  [2:0] alu_control, //function sel
 
 output reg [15:0] result,  //result 
 output zero,lt
    );

always @(*)
begin 
 case(alu_control)
 3'b000: result = a + b; // add
 3'b001: result = a - b; // sub
 3'b010: result = (a[0]^b[0])+(a[1]^b[1])+(a[2]^b[2])+(a[3]^b[3]);
 3'b011: result = a^b;
 3'b100: result = a>>b;
 3'b101: result = a & b; // and
 3'b110: result = a | b; // or
 3'b111: result = a;   //a 
 default:result = a + b; // add
 endcase
end
assign zero = (result==16'd0); 
assign lt = result[15];
endmodule
