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

/**
        a_addr=0;           //reg read addresss
        b_addr=0;           //reg read address
        c_addr=0;           //reg write address
        immediate_val=0;    //immediate value, overwrites a_val
        alu_control=3'b000; //alu operation
        addr = 0;      //address for data or instruction memory, instruction user lower half
        JCTL=0;             //paramaters for jump 0 = no, 1 = JZ, 2 = JLT, 3 = uncondititional
        im_sel=0;           //use the immediate value and overwrite A
        reg_write=0;     //write to register C
        data_read=0;        //read data at address in data mem
        data_write=0;       //write data at address in data mem
        reg_addr = 0;       //address is from reg not immediate val
        */
module control_logic(
    input [15:0] operation,
    output reg [3:0] a_addr, b_addr, c_addr,//c = a + b
    output reg [7:0] immediate_val,
    output reg [7:0] addr,
    output reg [7:0] j_addr,
    output reg [2:0] alu_control,
    output reg [1:0] JCTL, im_ctl,
    output reg reg_write, data_read, data_write, reg_addr,
    output reg stack_command,
    output reg [1:0] stack_ctl,
    output reg halt = 0
    );
    always @*
        begin
        case (operation[15:12])
        4'h0:begin   //NOP
                    a_addr=0;
                    b_addr=0;
                    c_addr=0;
                    immediate_val=0;
                    alu_control=3'b111;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=0;
                    data_read=0;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                 end 
        4'h1:begin  //LDD
                    a_addr=0;
                    b_addr=0;
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b111;
                    addr = operation[7:0];
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=1;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end
        4'h2:begin   //LD
                    a_addr=0;
                    b_addr=operation[7:4];
                    c_addr=operation[11:8];
                    immediate_val=operation[3:0];                    
                    alu_control=3'b000;
                    addr=0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=1;
                    reg_write=1;
                    data_read=1;
                    data_write=0;
                    reg_addr = 1;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end 
        4'h3:begin  //STR
                    a_addr=operation[11:8];
                    b_addr=0;
                    c_addr=0;
                    immediate_val=0;                    
                    alu_control=3'b111;
                    addr = operation[7:0];
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=0;
                    data_read=0;
                    data_write=1;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end     
        4'h4:begin  //LDIm
                    a_addr=0;
                    b_addr=0;
                    c_addr=operation[11:8];
                    immediate_val=operation[7:0];                    
                    alu_control=3'b111;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=1;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                  end     
        4'h5:begin  //MV
                    a_addr=operation[7:4];
                    b_addr=0;
                    c_addr=operation[11:8];
                    immediate_val=0;
                    alu_control=3'b111;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end 
        4'h6:begin  //ADD  
                    a_addr=operation[7:4];
                    b_addr=operation[3:0];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b000;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end     
        4'h7:begin  //SUB  
                    a_addr=operation[3:0];
                    b_addr=operation[7:4];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b001;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                 end    
        4'h8:begin  //AND  
                    a_addr=operation[7:4];
                    b_addr=operation[3:0];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b101;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                 end   
        4'h9:begin  //OR
                    a_addr=operation[7:4];
                    b_addr=operation[3:0];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b110;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                 end       
        4'hA:begin  //XOR 
                    a_addr=operation[7:4];
                    b_addr=operation[3:0];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b011;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end                                                                         
       4'hB:begin  //SR
                    a_addr=operation[3:0];
                    b_addr=operation[7:4];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b100;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end      
       4'hC:begin  //SL
                    a_addr=operation[3:0];
                    b_addr=operation[7:4];
                    c_addr=operation[11:8];
                    immediate_val=0;                    
                    alu_control=3'b010;
                    addr = 0;
                    j_addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=1;
                    data_read=0;
                    data_write=0;
                    reg_addr=0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end                
        4'hD:begin  //JZ
                    a_addr=operation[11:8];
                    b_addr=0;
                    c_addr=0;
                    immediate_val=0;
                    alu_control=3'b111;
                    addr = 0;
                    j_addr = operation[7:0];
                    JCTL=1;
                    im_ctl=0;
                    reg_write=0;
                    data_read=0;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0; 
                    halt = 0; 
                 end    
        4'hE:begin  //JLT
                    a_addr=operation[11:8];
                    b_addr=0;
                    c_addr=0;
                    immediate_val=0;
                    alu_control=3'b111;
                    addr = 0;
                    j_addr = operation[7:0];
                    JCTL=2;
                    im_ctl=0;
                    reg_write=0;
                    data_read=0;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                 end      
        4'hF:begin  //more commands
                    case(operation[11:8]) 
                    4'h0:begin //J
                                a_addr=0;
                                b_addr=0;
                                c_addr=0;
                                immediate_val=0;
                                alu_control=3'b111;
                                addr = 0;
                                j_addr = operation[7:0];
                                JCTL=3;
                                im_ctl=0;
                                reg_write=0;
                                data_read=0;
                                data_write=0;
                                reg_addr = 0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'h1:begin //PUSH
                                a_addr=operation[7:4];
                                b_addr=0;
                                c_addr=0;
                                immediate_val=0;
                                alu_control=3'b111;
                                addr = 0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=0;
                                reg_write=0;
                                data_read=0;
                                data_write=0;
                                reg_addr = 0;
                                stack_ctl = 0;
                                stack_command=1;
                                halt = 0;
                            end
                    4'h2:begin //POP
                                a_addr=0;
                                b_addr=0;
                                c_addr=operation[7:4];
                                immediate_val=0;
                                alu_control=3'b111;
                                addr = 0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=0;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr = 0;
                                stack_ctl = 1;
                                stack_command=1;
                                halt = 0;
                            end
                    4'h3:begin //Call
                                a_addr=0;
                                b_addr=0;
                                c_addr=operation[7:4];
                                immediate_val=0;
                                alu_control=3'b111;
                                addr = 0;
                                j_addr = operation[7:0];
                                JCTL=3;
                                im_ctl=2;
                                reg_write=0;
                                data_read=0;
                                data_write=0;
                                reg_addr = 0;
                                stack_ctl = 2;
                                stack_command=1;
                                halt = 0;
                            end
                    4'h4:begin //return
                                a_addr=0;
                                b_addr=0;
                                c_addr=operation[7:4];
                                immediate_val=0;
                                alu_control=3'b111;
                                addr = 0;
                                j_addr = 0;
                                JCTL=3;
                                im_ctl=0;
                                reg_write=0;
                                data_read=0;
                                data_write=0;
                                reg_addr = 0;
                                stack_ctl = 3;
                                stack_command=1;
                                halt = 0;
                            end
                    4'h5:begin //ADD_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b000;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'h6:begin //SUB_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b001;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'h7:begin //AND_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b101;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'h8:begin //OR_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b110;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'h9:begin //XOR_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b011;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'hA:begin //SR_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b100;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    4'hB:begin //SL_I
                                a_addr=0;
                                b_addr=operation[7:4];
                                c_addr=operation[7:4];
                                immediate_val=operation[3:0];                    
                                alu_control=3'b010;
                                addr=0;
                                j_addr = 0;
                                JCTL=0;
                                im_ctl=1;
                                reg_write=1;
                                data_read=0;
                                data_write=0;
                                reg_addr=0;
                                stack_ctl = 0;
                                stack_command=0;
                                halt = 0;
                            end
                    default: begin //improper command so noop
                                if(operation == 16'hFFFF) begin
                                    a_addr=0;
                                    b_addr=0;
                                    c_addr=0;
                                    immediate_val=0;
                                    alu_control=3'b111;
                                    addr = 0;
                                    j_addr = 0;
                                    JCTL=0;
                                    im_ctl=0;
                                    reg_write=0;
                                    data_read=0;
                                    data_write=0;
                                    reg_addr = 0;
                                    stack_ctl = 0;
                                    stack_command=0;
                                    halt = 1;
                                end
                                else begin
                                    a_addr=0;
                                    b_addr=0;
                                    c_addr=0;
                                    immediate_val=0;
                                    alu_control=3'b111;
                                    addr = 0;
                                    j_addr = 0;
                                    JCTL=0;
                                    im_ctl=0;
                                    reg_write=0;
                                    data_read=0;
                                    data_write=0;
                                    reg_addr = 0;
                                    stack_ctl = 0;
                                    stack_command=0;
                                    halt = 0;
                                end
                            end
                    endcase
                 end                                                 
        default: begin   //noop, no idea how you would get here but juuuuuust in case
                    a_addr=0;
                    b_addr=0;
                    c_addr=0;
                    immediate_val=0;
                    alu_control=3'b111;
                    addr = 0;
                    JCTL=0;
                    im_ctl=0;
                    reg_write=0;
                    data_read=0;
                    data_write=0;
                    reg_addr = 0;
                    stack_ctl = 0;
                    stack_command=0;
                    halt = 0;
                end 
       endcase
   end              
endmodule
