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
    wire[3:0] addr_I;
    wire[2:0] alu_ctl_I;
    wire[1:0] J_CTL;
    wire im_sel_I;
    wire reg_write_I;
    wire data_read_I;
    wire data_write_I;
    wire reg_addr_I;
    //exec -> Instruction Fetch/Decode variables
    wire[4:0] jump_address_E;
    wire jump_en_E;
    AND jump_en_and(jump_en, CLK, jump_en_E);
    //Instruction Fetch/Decode modules
    Instruction_memory(
    .CLK(CLK), //CLK for UART Reciever not rest of module
    .UART_TXD_IN(UART_TXD_IN),
    .program_counter(PC),
    .load_done(load_done),
    .instruction(instruction)
    );
    
    PC_control(
    .CLK(CLK),
    .jump_address(jump_address_E),
    .jump_en(jump_en),
    .load_done(load_done),
    .program_counter(PC)
    );
    
    control_logic(
    .operation(operation),
    .a_addr(a_addr_I), .b_addr(b_addr_I), .c_addr(c_addr_I),
    .immediate_val(immediate_val),
    .addr(addr_I),
    .alu_control(alu_ctl_I),
    .JCTL(J_CTL),
    .im_sel(im_sel_I), .reg_write(reg_write_I), .data_read(data_read_I), 
    .data_write(data_write_I), .reg_addr(reg_addr_I)
    );

    //data variables
    wire [3:0] a_addr_D, b_addr_D, c_addr_D;
    wire [7:0] immediate_val_D;
    wire [7:0] addr_D;
    wire [2:0] alu_ctl_D;
    wire [1:0] JCTL_D;
    wire im_sel_D, reg_write_D, data_read_D, data_write_D, reg_addr_D;
    wire [15:0] a_val_D, a_val_to_imm_D, b_val_D;
    
    //Instruction / Data register
    Instruction_register(
        .CLK(CLK),
        .a_addr_in(a_addr_I), .b_addr_in(b_addr_I), .c_addr_in(c_addr_I),//c = a + b
        .immediate_val_in(immediate_val_I),
        .addr_in(addr_I),
        .alu_control_in(alu_ctl_I),
        .JCTL_in(jctl_I),
        .im_sel_in(im_sel_I), .reg_write_in(reg_write_I), .data_read_in(data_read_I), 
        .data_write_in(data_write_I), .reg_addr_in(reg_addr_I),
        
        .a_addr(a_addr_D), .b_addr(b_addr_D), .c_addr(c_addr_D),//c = a + b
        .immediate_val(immediate_val_D),
        .addr(addr_D),
        .alu_control(alu_ctl_D),
        .JCTL(JCTL_D),
        .im_sel(im_sel_D), .reg_write(reg_write_D), .data_read(data_read_D), 
        .data_write(data_write_D), .reg_addr(reg_addr_D)
    );
    
    //data_writeback -> data
    wire[3:0] c_addr_W;
    wire [15:0] c_val_W;
    wire write_en_W;
    AND write_en_and(write_en, write_en_W, CLK);
    
    //data modules
    registers(
        .rega_addr(rega_addr_D), .regb_addr(regb_addr_D), .write_addr(regc_addr_W),
        .write_data(c_val_W),
        .write_enable(write_en),
        .rega_data(a_val_to_imm_D), .regb_data(b_val_D)
    );
    
    immediate_mux(
        .im_sel(im_sel_D),
        .reg_data(a_val_to_imm_D),
        .immediate(immediate_val),
        .data_to_alu(a_val_D)
    );

    //Execute Variables
    wire [15:0] a_val_E, b_val_E;
    wire [3:0] c_addr_E;
    wire [7:0] addr_E;
    wire [2:0] alu_ctl_E;
    wire [1:0] JCTL_E;
    wire data_read_E, data_write_E, reg_addr_E, reg_write_E;
    wire [15:0] data_result_E;
    
    wire[15:0] alu_result_E;
    wire[1:0] alu_flags_E;
    wire[15:0] true_addr_E;
    
    AND data_read_and(read_en, data_read_E, CLK);
    AND data_write_and(write_en, data_write_E, CLK);
    
    data_register(
        .CLK(CLK), 
        .a_val_in(a_val_D), .b_val_in(b_val_D),
        .c_addr_in(c_addr_D),
        .addr_in(addr_D),
        .alu_ctl_in(alu_ctl_D),
        .JCTL_in(JCTL_D), 
        .data_read_in(data_read_D), .data_write_in(data_write_D), 
        .reg_addr_in(reg_addr_D), .reg_write_in(reg_write_D),
        
        .a_val(a_val_E), .b_val(b_val_E),
        .c_addr(c_addr_E),
        .addr(addr_E),
        .alu_ctl(alu_ctl_E),
        .JCTL(JCTL_E), 
        .data_read(data_read_E), .data_write(data_write_E), 
        .reg_addr(reg_addr_E), .reg_write(reg_addr_E)
    );
    
    ALU(
        .a(a_val_E),  //src1
        .b(b_val_E),  //src2
        .alu_control(alu_ctl_E), //function sel
 
        .result(alu_result_E),  //result 
        .zero(alu_flags_E[0]), .lt(alu_flags_E[1])
    );
    
    addr_mux(
        .reg_addr(reg_addr_E), 
        .addr(addr_E),
        .alu_result(alu_result_E),
        .true_addr(true_addr_E)
    );
    
    jump_control(
        .alu_flags(alu_flags_E), .j_ctl(JCTL_E),
        .j_en(jump_en_E)
    );
    
    data_mem (
        .CLK(CLK),
        .address(true_addr),
        .read_en(data_read),
        .write_en(data_write),
        .input_data(alu_result_E),
        .output_data(data_result_E),
        .SW(SW),
        .BTNS(BTNS),
        .CA(CA), .AN(AN),
        .LED(LED),
        .debug_mode(0)
    );
    
    //data writeback variables
    wire[15:0] alu_result_W;
    wire[15:0] data_result_W;
    wire data_read_W;
    
    execution_register(
        .CLK(CLK),        
        .data_val_in(data_result_E), .result_in(alu_result_E),
        .c_addr_in(C_addr_E), 
        .reg_write_in(reg_write_E), .data_read_in(data_read_E),
        
       .data_val(data_result_W), .result(alu_result_W),
       .c_addr(c_addr_W), 
       .reg_write(reg_write_W), .data_read(data_read_W)
    );
    
    reg_write_mux(
        .data_read(data_read_W),
        .alu_result(alu_result_W),
        .data_result(data_result_W),
        .w_data_to_reg(c_val_W)
    );
    
    

wire load_done;
reg SCLK=1,PCLK=1;
reg [31:0] count=0; 
reg [15:0] counter=0;
always @(posedge CLK)
    begin
        LED16_B<=load_done;
        counter<=counter+1;
        LED[15]<=SCLK;
        LED[14]<=PCLK;
        if (count<(50000000>>SW[14:12]))
            count<=count+SW[15];
        else
            begin
                SCLK<=!SCLK;
                count<=0;
            end                              
    end 
                   
endmodule
