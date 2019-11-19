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
wire [15:0] write_data,rega_data,regb_data,data_to_alu,instruction,result; 
wire im_sel,write_enable,load_done,out_write_en,in_mux_en,zero,lt,jump_en;
wire [2:0] alu_control;  
wire [4:0] program_counter;
wire[15:0] port0,port1,port2;
reg SCLK=1,PCLK=1;
reg [31:0] count=0; 
reg [15:0] counter=0;

Instruction_memory imem (.CLK(CLK),.UART_TXD_IN(UART_TXD_IN),.program_counter(program_counter),
                         .load_done(load_done),.instruction(instruction));

control_logic control(.operation(instruction[15:12]),.alu_control(alu_control),.im_sel(im_sel),
                       .write_enable(write_enable),.out_write_en(out_write_en),.in_mux_en(in_mux_en),
                       .zero(zero),.lt(lt),.jump_en(jump_en));
                       
registers r_array (.CLK(SCLK),.rega_addr(instruction[11:8]),.regb_addr(instruction[7:4]),.write_addr(instruction[11:8]),
                   .write_data(write_data),.write_enable(write_enable),.rega_data(rega_data),
                   .regb_data(regb_data));
                   
immediate_mux imux (.im_sel(im_sel),.reg_data(rega_data),.immediate(instruction[7:0]),
                    .data_to_alu(data_to_alu)); 
                                       
ALU alu_unit (.a(data_to_alu),.b(regb_data),.alu_control(alu_control),.result(result),
              .zero(zero),.lt(lt));    
               
ssegx8 display ( .CLK(CLK), .VALUE({port1,port0}),.SSEG_CA(CA),.SSEG_AN(AN));    

out_mux omux (.port_sel(instruction[7:4]),.out_write_en(out_write_en),.data_out(rega_data),
             .port0(port0),.port1(port1),.port2(port2),.CLK(PCLK));
             
input_mux inmux(.port_sel(instruction[7:4]),.SW(SW),.Buttons(BTNS),.in_mux_en(in_mux_en),
               .alu_result(result),.data_to_registers(write_data),.counter(counter));                             

PC_control pccntr (.PCLK(PCLK),.jump_address(instruction[4:0]),.jump_en(jump_en),
                     .load_done(load_done),.program_counter(program_counter));




always @(posedge CLK)
    begin
        LED16_B<=load_done;
        counter<=counter+1;
        LED[15]<=SCLK;
        LED[14]<=PCLK;
        LED[4:0]<=program_counter; 
        if (count<(50000000>>SW[14:12]))
            count<=count+SW[15];
        else
            begin
                SCLK<=!SCLK;
                count<=0;
            end                              
    end  
always @(posedge SCLK)    
        PCLK<=PCLK+1;
                   
endmodule
