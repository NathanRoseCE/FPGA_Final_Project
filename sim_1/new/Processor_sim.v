`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 08:50:55 AM
// Design Name: 
// Module Name: Processor_sim
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


module Processor_sim(

    );
    //Processor IO
    reg CLK;
    reg [15:0] SW;
    reg UART_TXD_IN;
    reg [4:0] BTNS;
    wire LED16_B;
    wire [15:0] LED;
    wire [7:0] CA,AN;
    //this is copied and pasted from the processor, 
    //I_MEM is modified to make debugging easier
    
    /***************************Begin SOURCE*************************/
    
    //Instruction Fetch/Decode variables
    wire[15:0] operation;
    wire[7:0] PC_I;
    wire[3:0] a_addr_I, b_addr_I, c_addr_I;
    wire[7:0] immediate_val_I;
    wire[7:0] addr_I;
    wire[2:0] alu_ctl_I;
    wire[1:0] JCTL_I;
    wire[1:0] im_ctl_I;
    wire reg_write_I;
    wire data_read_I;
    wire data_write_I;
    wire reg_addr_I;
    wire [1:0] stack_ctl_I;
    wire stack_command_I;
    
    //write -> Instruction Fetch/Decode variables
    wire jump_en_W;
    wire load_done;
    wire [7:0] address_W;
    
    wire jump_en;
    AND jump_en_and(.out(jump_en), .a(CLK), .b(jump_en_W));
    
    //Instruction Fetch/Decode modules
    Instruction_memory i_mem(
    .CLK(CLK), //CLK for UART Reciever not rest of module
    .UART_TXD_IN(UART_TXD_IN),
    .program_counter(PC_I),
    .load_done(load_done),
    .instruction(operation),
    .debug(1)
    );
    
    PC_control pc_ctl(
    .CLK(CLK),
    .jump_address(address_W),
    .jump_en(jump_en),
    .load_done(load_done),
    .program_counter(PC_I)
    );
    
    control_logic ctl_logic(
    .operation(operation),
    .a_addr(a_addr_I), .b_addr(b_addr_I), .c_addr(c_addr_I),
    .immediate_val(immediate_val_I),
    .addr(addr_I),
    .alu_control(alu_ctl_I),
    .JCTL(JCTL_I),
    .im_ctl(im_ctl_I), .reg_write(reg_write_I), .data_read(data_read_I), 
    .data_write(data_write_I), .reg_addr(reg_addr_I), 
    .stack_ctl(stack_ctl_I), .stack_command(stack_command_I)
    );

    //execute variables
    wire [3:0] a_addr_E, b_addr_E, c_addr_E;
    wire [7:0] immediate_val_E;
    wire [2:0] alu_ctl_E;
    wire [1:0] im_ctl_E, JCTL_E;
    wire reg_write_E, data_read_E, data_write_E, reg_addr_E;
    wire [15:0] a_val_E, a_val_to_imm_E, b_val_E;
    wire[15:0] alu_result_E;
    wire[1:0] alu_flags_E;
    wire [1:0] stack_ctl_E;
    wire stack_command_E;
    wire [7:0] stack_pointer_E, PC_E;
    wire [7:0] addr_E;
    //Instruction / Execute register
    Instruction_register I_reg(
        .CLK(CLK),
        .a_addr_in(a_addr_I), .b_addr_in(b_addr_I), .c_addr_in(c_addr_I),//c = a + b
        .immediate_val_in(immediate_val_I),
        .addr_in(addr_I),
        .PC_in(PC_I),
        .alu_control_in(alu_ctl_I),
        .JCTL_in(JCTL_I),
        .im_ctl_in(im_ctl_I), .reg_write_in(reg_write_I), .data_read_in(data_read_I), 
        .data_write_in(data_write_I), .reg_addr_in(reg_addr_I),
        .stack_ctl_in(stack_ctl_I), .stack_command_in(stack_command_I),
      
        .a_addr(a_addr_E), .b_addr(b_addr_E), .c_addr(c_addr_E),//c = a + b
        .immediate_val(immediate_val_E),
        .addr(addr_E),
        .alu_control(alu_ctl_E),
        .JCTL(JCTL_E),
        .im_ctl(im_ctl_E), .reg_write(reg_write_E), .data_read(data_read_E), 
        .data_write(data_write_E), .reg_addr(reg_addr_E),
        .stack_ctl(stack_ctl_E), .stack_command(stack_command_E),
        .PC(PC_E)
    );
    
    //data_writeback -> execute
    wire[3:0] c_addr_W;
    wire [15:0] c_val_W;
    wire reg_write_W;
    
    wire reg_write_en;
    AND write_en_and(.out(reg_write_en), .a(reg_write_W), .b(CLK));
    
    //Execute modules
    registers reg_array(
        .rega_addr(a_addr_E), .regb_addr(b_addr_E), .write_addr(c_addr_W),
        .write_data(c_val_W),
        .write_enable(reg_write_en),
        .rega_data(a_val_to_imm_E), .regb_data(b_val_E)
    );
    
    immediate_mux imm_mux(
        .PC(PC_E),
        .imm_ctl(im_ctl_E),
        .reg_data(a_val_to_imm_E),
        .immediate(immediate_val_E),
        .data_to_alu(a_val_E)
    );
    
    
    ALU alu(
        .a(a_val_E),  //src1
        .b(b_val_E),  //src2
        .alu_control(alu_ctl_E), //function sel
 
        .result(alu_result_E),  //result 
        .zero(alu_flags_E[0]), .lt(alu_flags_E[1])
    );
    
    wire stack_command;
    AND stack_AND(.out(stack_command), .a(stack_command_E), .b(CLK));
    stack_pointer_ctl stack_ctl(
        .stack_command(stack_command),
        .stack_ctl(stack_ctl_E),
        .stack_pointer(stack_pointer_E)
    );
    
    //data writeback variables
    wire[15:0] alu_result_W;
    wire[15:0] data_result_W;
    wire[7:0] true_addr_W;
    wire data_read_W, data_write_W, reg_addr_W;
    wire [1:0] stack_ctl_W;
    wire [7:0] stack_pointer_W;
    wire [1:0] alu_flags_W, JCTL_W;
    wire[7:0] addr_W;
    wire stack_command_W;
    
    execution_register ex_reg(
        .CLK(CLK), 
        .result_in(alu_result_E),
        .c_addr_in(c_addr_E), 
        .addr_in(addr_E),
        .reg_write_in(reg_write_E), .data_read_in(data_read_E),
        .data_write_in(data_write_E),
        .reg_addr_in(reg_addr_E),
        .stack_ctl_in(stack_ctl_E),
        .stack_pointer_in(stack_pointer_E),
        .alu_flags_in(alu_flags_E),
        .j_ctl_in(JCTL_E),
        .stack_command_in(stack_command_E),
        
       .result(alu_result_W),
       .c_addr(c_addr_W), 
       .addr(addr_W),
       .reg_write(reg_write_W), .data_read(data_read_W),
       .data_write(data_write_W),
       .reg_addr(reg_addr_W),
       .stack_ctl(stack_ctl_W),
       .stack_pointer(stack_pointer_W),
       .alu_flags(alu_flags_W),
       .j_ctl(JCTL_W),
       .stack_command(stack_command_W)
    );
    addr_mux address_mux(
        .reg_addr(reg_addr_W), 
        .addr(addr_W),
        .stack_pointer(stack_pointer_W),
        .stack_command(stack_command_W),
        .alu_result(alu_result_W),
        .true_addr(true_addr_W)
    );
    
    wire data_write;
    wire write_en;
    wire stack_write;
    AND stack_write_and(.out(stack_write), .a(stack_command_W), .b(~stack_ctl_W[0]));
    OR data_write_or(.out(data_write), .a(data_write_W), .b(stack_write));
    AND data_write_en_and(.out(write_en), .a(data_write), .b(CLK));
    wire data_read;
    wire read_en;
    OR data_read_or(.out(data_read), .a(data_read_W), .b(stack_ctl_W[0]));
    AND data_read_en_or(.out(read_en), .a(data_read), .b(CLK));
    data_mem data_memory(
        .CLK(CLK),
        .address(true_addr_W),
        .read_en(read_en),
        .write_en(write_en),
        .input_data(alu_result_W),
        .output_data(data_result_W),
        .SW(SW),
        .BTNS(BTNS),
        .CA(CA), .AN(AN),
        .LED(LED),
        .debug_mode(1)
    );
    
    reg_write_mux reg_write_multi(
        .data_read(data_read),
        .alu_result(alu_result_W),
        .data_result(data_result_W),
        .w_data_to_reg(c_val_W)
    );  
    jump_control j_ctl(
        .alu_flags(alu_flags_W), .j_ctl(JCTL_W),
        .j_en(jump_en_W)
    );
    jump_address_mux j_addres_mux(
        .address_ctl(stack_ctl_W[1]),
        .address_in(addr_W),
        .data_mem_val(data_result_W),
        .address(address_W)
    );
            
    assign LED16_B = load_done;
    
    
    /***************************END SOURCE*************************/
    initial begin
        CLK = 0;
        SW=10;
        BTNS=1;
        #20
        SW=0;
        #180 $finish;
    end
    always begin
        #1 CLK = ~CLK;
    end
endmodule
