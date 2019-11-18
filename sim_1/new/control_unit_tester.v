`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 11:43:23 AM
// Design Name: 
// Module Name: control_unit_tester
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


module control_unit_tester(
        
    );
    control_logic uut(
        .operation(operation),
        .a_addr(a_addr), .b_addr(b_addr), .c_addr(c_addr),
        .immediate_val(immediate_val),
        .addr(addr),
        .alu_control(alu_control),
        .JCTL(JCTL),
        .im_sel(im_sel), .reg_write(reg_write), .data_read(data_read), 
        .data_write(data_write), .reg_addr(reg_addr) 
    );
    reg [15:0] operation;
    wire[3:0] a_addr, b_addr, c_addr;
    wire [7:0] immediate_val;
    wire [7:0] addr;
    wire [2:0] alu_control;
    wire [1:0] JCTL;
    wire im_sel, reg_write, data_read, data_write, reg_addr;
    
    
    initial begin
        #10 operation = 16'h0000;//nop
                //all zeros
        #10 operation = 16'h1585;//Load direct
                //addr = 85
                //c = 5
                //data_read = 1
                //reg_write = 1
                //alu_ctl = 7
        #10 operation = 16'h2ABC;//Load register*********
                //b = B
                //immediate_val = C
                //c = A
                //im_sel = 1
                //data_read = 1
                //reg_write = 1
                //reg_addr = 1
                //alu_ctl = 0
        #10 operation = 16'h3543;//store direct
                //a = 5
                //addr_43
                //data_write = 1
                //alu_ctl = 7
        #10 operation = 16'h4975;//load immediate
                //c = 9
                //immediate_val = 75
                //reg_write = 1
                //alu_ctl = 7
                //im_sel = 1
        #10 operation = 16'h5DB4;//add
                //a = B
                //b = 4
                //c = D
                //reg_write = 1
                //alu_ctl = 0
        #10 operation = 16'h65FE;//sub
                //a = F
                //b = E
                //c = 5
                //reg_write = 1
                //alu_ctl = 1
        #10 operation = 16'h7654;//and
                //a = 5
                //b = 4
                //c = 6
                //reg_write = 1
                //alu_ctl = 5
        #10 operation = 16'h8549;//or
                //a = 4
                //b = 9
                //c = 5
                //reg_write = 1
                //alu_ctl = 6
        #10 operation = 16'h9000;//nop test 2
                //all zeros
        #10 operation = 16'hAE46;//Xor
                //a = 4
                //b = 6
                //c = E
                //reg_write = 1
                //alu_ctl = 3
        #10 operation = 16'hB354;//SR
                //a = 5
                //b = 4
                //c = 3
                //reg_write = 1
                //alu_ctl = 4
        #10 operation = 16'hC982;//SL
                //a = 8
                //b = 2
                //c = 9
                //reg_write = 1
                //alu_ctl = 2
        #10 operation = 16'hD257;//JZ
                //a = 2
                //addr = 57
                //jctl = 1
                //alu_ctl = 7
        #10 operation = 16'hE365;//JLT
                //a = 3
                //addr = 65
                //jctl = 2
                //alu_ctl = 7
        #10 operation = 16'hF075;//J
                //addr = 75
                //jctl = 3
                //alu_ctl = 7
        #10 operation = 16'hF100;//PUSH
                //noop for now all zeros
        #10 operation = 16'hF200;//POP 
                //noop for now all zeros
        #10 operation = 16'hF335;//ADD_I
                //B = 3
                //C = 3
                //im_vel = 5
                //im_sel = 1
                //alu_ctl = 0
        #10 operation = 16'hF48f;//SUB_I
                //B = 8
                //C = 8
                //im_vel = f
                //im_sel = 1
                //alu_ctl = 1
        #10 operation = 16'hF545;//AND_I
                //B = 4
                //C = 4
                //im_vel = 5
                //im_sel = 1
                //alu_ctl = 5
        #10 operation = 16'hF6DE;//OR_I
                //B = D
                //C = D
                //im_vel = E
                //im_sel = 1
                //alu_ctl = 6
        #10 operation = 16'hF7AB;//XOR_I
                //B = A
                //C = A
                //im_vel = B
                //im_sel = 1
                //alu_ctl = 3
        #10 operation = 16'hF825;//SRI
                //B = 2
                //C = 2
                //im_vel = 5
                //im_sel = 1
                //alu_ctl = 4
        #10 operation = 16'hF979;//SLI
                //B = 7
                //C = 7
                //im_vel = 9
                //im_sel = 1
                //alu_ctl = 2
        #10 operation = 16'hFA00;//improper test
                //all zeros
        $finish;
    end
    
    
    
endmodule
