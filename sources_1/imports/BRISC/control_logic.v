`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2019 08:21:44 PM
// Design Name: 
// Module Name: control_logic
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


module control_logic(
    input [3:0] operation,
    input zero,lt,
    output reg [2:0] alu_control,
    output reg im_sel,write_enable,out_write_en,in_mux_en,jump_en
    );
    always @*
        begin
        case (operation)
        4'b0000:begin   //NOP
                    alu_control=3'b001;
                    write_enable=0;
                    im_sel=0;
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                 end 
        4'b0001:begin   //ADD
                    alu_control=3'b000;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                end
        4'b0010:begin   //LDI
                    alu_control=3'b111;
                    write_enable=1;
                    im_sel=1;
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                end 
        4'b0011:begin  //SUB
                    alu_control=3'b001;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                end     
        4'b0100:begin  //cnt 1's
                    alu_control=3'b010;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0;
                  end     
        4'b0101:begin  //AND  
                    alu_control=3'b101;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                end     
        4'b0110:begin  //OR  
                    alu_control=3'b110;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0;
                 end    
        4'b0111:begin  //INV  
                    alu_control=3'b010;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                 end   
        4'b1000:begin  //xor
                    alu_control=3'b011;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0; 
                 end    
        4'b1001:begin  //SR 
                    alu_control=3'b100;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0;
                end                   
        4'b1010:begin  //SL 
                    alu_control=3'b011;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=0;
                end                                                                         
       4'b1011:begin  //IN
                    alu_control=3'b111;
                    write_enable=1;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=1;
                    jump_en=0; 
                end      
       4'b1100:begin  //OUT
                    alu_control=3'b111;
                    write_enable=0;
                    im_sel=0; 
                    out_write_en=1;
                    in_mux_en=0;
                    jump_en=0;
                end                
        4'b1101:begin  //JZ
                    alu_control=3'b111;
                    write_enable=0;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=zero;   
                 end    
        4'b1110:begin  //JLT
                    alu_control=3'b111;
                    write_enable=0;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=lt;
                 end      
        4'b1111:begin  //J
                    alu_control=3'b111;
                    write_enable=0;
                    im_sel=0; 
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=1;
                 end                                                 
        default: begin   //NOP
                    alu_control=3'b001;
                    write_enable=0;
                    im_sel=0;
                    out_write_en=0;
                    in_mux_en=0;
                    jump_en=1;
                end 
       endcase
   end              
endmodule
