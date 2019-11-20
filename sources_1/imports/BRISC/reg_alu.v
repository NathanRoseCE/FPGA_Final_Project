`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2019 09:50:39 PM
// Design Name: 
// Module Name: reg_alu
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


module processor(
    input CLK,
    input [15:0] SW,
    input UART_TXD_IN,
    input [4:0] BTNS,
    output reg LED16_B,
    output reg [15:0] LED=0,
    output [7:0] CA,AN
    );
    
    //Instruction Fetch/Decode variables
    wire[15:0] operation;
    wire[4:0] PC;
    wire[3:0] a_addr_I, b_addr_I, c_addr_I;
    wire[7:0] immediate_val_I;
    wire[7:0] addr_I;
    wire[2:0] alu_ctl_I;
    wire[1:0] JCTL_I;
    wire im_sel_I;
    wire reg_write_I;
    wire data_read_I;
    wire data_write_I;
    wire reg_addr_I;
    
    //exec -> Instruction Fetch/Decode variables
    wire jump_en_E;
    wire load_done;
    wire [7:0] addr_E;
    
    wire jump_en;
    AND jump_en_and(.out(jump_en), .a(CLK), .b(jump_en_E));
    
    //Instruction Fetch/Decode modules
    Instruction_memory i_mem(
    .CLK(CLK), //CLK for UART Reciever not rest of module
    .UART_TXD_IN(UART_TXD_IN),
    .program_counter(PC),
    .load_done(load_done),
    .instruction(operation),
    .debug(0)
    );
    
    PC_control pc_ctl(
    .CLK(CLK),
    .jump_address(addr_E),
    .jump_en(jump_en),
    .load_done(load_done),
    .program_counter(PC)
    );
    
    control_logic ctl_logic(
    .operation(operation),
    .a_addr(a_addr_I), .b_addr(b_addr_I), .c_addr(c_addr_I),
    .immediate_val(immediate_val_I),
    .addr(addr_I),
    .alu_control(alu_ctl_I),
    .JCTL(JCTL_I),
    .im_sel(im_sel_I), .reg_write(reg_write_I), .data_read(data_read_I), 
    .data_write(data_write_I), .reg_addr(reg_addr_I)
    );

    //execute variables
    wire [3:0] a_addr_E, b_addr_E, c_addr_E;
    wire [7:0] immediate_val_E;
    wire [2:0] alu_ctl_E;
    wire [1:0] JCTL_E;
    wire im_sel_E, reg_write_E, data_read_E, data_write_E, reg_addr_E;
    wire [15:0] a_val_E, a_val_to_imm_E, b_val_E;
    wire[15:0] alu_result_E;
    wire[1:0] alu_flags_E;
    
    //Instruction / Execute register
    Instruction_register I_reg(
        .CLK(CLK),
        .a_addr_in(a_addr_I), .b_addr_in(b_addr_I), .c_addr_in(c_addr_I),//c = a + b
        .immediate_val_in(immediate_val_I),
        .addr_in(addr_I),
        .alu_control_in(alu_ctl_I),
        .JCTL_in(JCTL_I),
        .im_sel_in(im_sel_I), .reg_write_in(reg_write_I), .data_read_in(data_read_I), 
        .data_write_in(data_write_I), .reg_addr_in(reg_addr_I),
        
        .a_addr(a_addr_E), .b_addr(b_addr_E), .c_addr(c_addr_E),//c = a + b
        .immediate_val(immediate_val_E),
        .addr(addr_E),
        .alu_control(alu_ctl_E),
        .JCTL(JCTL_E),
        .im_sel(im_sel_E), .reg_write(reg_write_E), .data_read(data_read_E), 
        .data_write(data_write_E), .reg_addr(reg_addr_E)
    );
    
    //data_writeback -> execute
    wire[3:0] c_addr_W;
    wire [15:0] c_val_W;
    wire reg_write_W;
    
    wire write_en;
    AND write_en_and(.out(write_en), .a(reg_write_W), .b(CLK));
    
    //Execute modules
    registers reg_array(
        .rega_addr(a_addr_E), .regb_addr(b_addr_E), .write_addr(c_addr_W),
        .write_data(c_val_W),
        .write_enable(write_en),
        .rega_data(a_val_to_imm_E), .regb_data(b_val_E)
    );
    
    immediate_mux imm_mux(
        .im_sel(im_sel_E),
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
    jump_control j_ctl(
        .alu_flags(alu_flags_E), .j_ctl(JCTL_E),
        .j_en(jump_en_E)
    );
    
    
    //data writeback variables
    wire[15:0] alu_result_W;
    wire[15:0] data_result_W;
    wire[7:0] addr_W;
    wire[7:0] true_addr_W;
    wire data_read_W, data_write_W, reg_addr_W;
    
    
    execution_register ex_reg(
        .CLK(CLK), 
        .result_in(alu_result_E),
        .c_addr_in(c_addr_E), 
        .addr_in(addr_E),
        .reg_write_in(reg_write_E), .data_read_in(data_read_E),
        .data_write_in(data_write_E),
        .reg_addr_in(reg_addr_E),
        
       .data_val(data_result_W), .result(alu_result_W),
       .c_addr(c_addr_W), 
       .addr(addr_W),
       .reg_write(reg_write_W), .data_read(data_read_W),
       .data_write(data_write_W),
       .reg_addr(reg_addr_W)
    );
    addr_mux address_mux(
        .reg_addr(reg_addr_W), 
        .addr(addr_W),
        .alu_result(alu_result_W),
        .true_addr(true_addr_W)
    );
    
    wire data_write_en;
    AND data_write_and(.out(data_write_en), .a(data_write_W), .b(CLK));
    
    data_mem data_memory(
        .CLK(CLK),
        .address(true_addr_W),
        .read_en(data_read_W),
        .write_en(data_write_en),
        .input_data(alu_result_W),
        .output_data(data_result_W),
        .SW(SW),
        .BTNS(BTNS),
        .CA(CA), .AN(AN),
        .LED(LED),
        .debug_mode(0)
    );
    
    reg_write_mux reg_write_multi(
        .data_read(data_read_W),
        .alu_result(alu_result_W),
        .data_result(data_result_W),
        .w_data_to_reg(c_val_W)
    );  
            
endmodule
