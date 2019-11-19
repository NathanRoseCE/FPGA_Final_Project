`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 05:15:19 PM
// Design Name: 
// Module Name: instruction_register_tester
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


module instruction_register_tester(
        
    );
    control_logic control(
        .operation(operation),
        .a_addr(a_addr_in), .b_addr(b_addr_in), .c_addr(c_addr_in),
        .immediate_val(immediate_val_in),
        .addr(addr_in),
        .alu_control(alu_control_in),
        .JCTL(JCTL_in),
        .im_sel(im_sel_in), .reg_write(reg_write_in), .data_read(data_read_in), 
        .data_write(data_write_in), .reg_addr(reg_addr_in) 
    );
    reg [15:0] operation;
    Instruction_register UUT(
        .CLK(CLK),
        .a_addr_in(a_addr_in), .b_addr_in(b_addr_in), .c_addr_in(c_addr_in),//c = a + b
        .immediate_val_in(immediate_val_in),
        .addr_in(addr_in),
        .alu_control_in(alu_control_in),
        .JCTL_in(JCTL_in),
        .im_sel_in(im_sel_in), .reg_write_in(reg_write_in), .data_read_in(data_read_in), 
        .data_write_in(data_write_in), .reg_addr_in(reg_addr_in),
        
        .a_addr(a_addr), .b_addr(b_addr), .c_addr(c_addr),//c = a + b
        .immediate_val(immediate_val),
        .addr(addr),
        .alu_control(alu_control),
        .JCTL(JCTL),
        .im_sel(im_sel), .reg_write(reg_write), .data_read(data_read), 
        .data_write(data_write), .reg_addr(reg_addr) 
        );
        
        reg CLK;
        wire [3:0] a_addr_in, b_addr_in, c_addr_in;
        wire [7:0] immediate_val_in;
        wire [7:0] addr_in;
        wire [2:0] alu_control_in;
        wire [1:0] JCTL_in;
        wire im_sel_in, reg_write_in, data_read_in, data_write_in, reg_addr_in;
        
        wire [3:0] a_addr, b_addr, c_addr;
        wire [7:0] immediate_val;
        wire [7:0] addr;
        wire [2:0] alu_control;
        wire [1:0] JCTL;
        wire im_sel, reg_write, data_read, data_write, reg_addr;
        
        initial begin
        CLK = 0;
        #1 operation = 16'h0000;//nop
                //all zeros
        #5 operation = 16'h1585;//Load direct
                //addr = 85
                //c = 5
                //data_read = 1
                //reg_write = 1
                //alu_ctl = 7
        #5 operation = 16'h2ABC;//Load register
                //b = B
                //immediate_val = C
                //c = A
                //im_sel = 1
                //data_read = 1
                //reg_write = 1
                //reg_addr = 1
                //alu_ctl = 0
        #5 operation = 16'h3543;//store direct
                //a = 5
                //addr_43
                //data_write = 1
                //alu_ctl = 7
        #5 operation = 16'h4975;//load immediate
                //c = 9
                //immediate_val = 75
                //reg_write = 1
                //alu_ctl = 7
                //im_sel = 1
        #5 operation = 16'h5DB4;//add
                //a = B
                //b = 4
                //c = D
                //reg_write = 1
                //alu_ctl = 0
        #5 operation = 16'h65FE;//sub
                //a = F
                //b = E
                //c = 5
                //reg_write = 1
                //alu_ctl = 1
        #5 operation = 16'h7654;//and
                //a = 5
                //b = 4
                //c = 6
                //reg_write = 1
                //alu_ctl = 5
        #5 operation = 16'h8549;//or
                //a = 4
                //b = 9
                //c = 5
                //reg_write = 1
                //alu_ctl = 6
        #5 operation = 16'h9000;//nop test 2
                //all zeros
        #5 operation = 16'hAE46;//Xor
                //a = 4
                //b = 6
                //c = E
                //reg_write = 1
                //alu_ctl = 3
        #5 operation = 16'hB354;//SR
                //a = 5
                //b = 4
                //c = 3
                //reg_write = 1
                //alu_ctl = 4
        #5 operation = 16'hC982;//SL
                //a = 8
                //b = 2
                //c = 9
                //reg_write = 1
                //alu_ctl = 2
        #5 operation = 16'hD257;//JZ
                //a = 2
                //addr = 57
                //jctl = 1
                //alu_ctl = 7
        #5 operation = 16'hE365;//JLT
                //a = 3
                //addr = 65
                //jctl = 2
                //alu_ctl = 7
        #5 operation = 16'hF075;//J
                //addr = 75
                //jctl = 3
                //alu_ctl = 7
        #5 operation = 16'hF100;//PUSH
                //noop for now all zeros
        #5 operation = 16'hF200;//POP 
                //noop for now all zeros
        #5 operation = 16'hF335;//ADD_I
                //B = 3
                //C = 3
                //im_vel = 5
                //im_sel = 1
                //alu_ctl = 0
        #5 operation = 16'hF48f;//SUB_I
                //B = 8
                //C = 8
                //im_vel = f
                //im_sel = 1
                //alu_ctl = 1
        #5 operation = 16'hF545;//AND_I
                //B = 4
                //C = 4
                //im_vel = 5
                //im_sel = 1
                //alu_ctl = 5
        #5 operation = 16'hF6DE;//OR_I
                //B = D
                //C = D
                //im_vel = E
                //im_sel = 1
                //alu_ctl = 6
        #5 operation = 16'hF7AB;//XOR_I
                //B = A
                //C = A
                //im_vel = B
                //im_sel = 1
                //alu_ctl = 3
        #5 operation = 16'hF825;//SRI
                //B = 2
                //C = 2
                //im_vel = 5
                //im_sel = 1
                //alu_ctl = 4
        #5 operation = 16'hF979;//SLI
                //B = 7
                //C = 7
                //im_vel = 9
                //im_sel = 1
                //alu_ctl = 2
        #5 operation = 16'hFA00;//improper test
                //all zeros
        $finish;
    end
    always begin
        #3 CLK = ~CLK;
    end
endmodule
