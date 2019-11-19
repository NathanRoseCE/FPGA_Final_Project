`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 10:21:36 AM
// Design Name: 
// Module Name: data_mem_tester
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      The following tests need to be performed:
//          Can read and write to memory
//          write to LED address creates an automatic change in LED
//          cannot write to read only
//          a read from SW address outputs the current value of the switches
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mem_tester(

    );
    reg CLK;
    
    reg [7:0] address;
    reg read_en, write_en;
    reg [15:0] input_data;
    wire [15:0] output_data;
    
    reg [15:0] SW;
    reg [4:0] BTNS;
    wire [7:0] CA, AN;
    wire [15:0] LED;
    
    
    data_mem uut(
        .address(address),
        .read_en(read_en),
        .write_en(write_en),
        .input_data(input_data),
        .output_data(output_data),
        .SW(SW),
        .BTNS(BTNS),
        .CA(CA), 
        .AN(AN),
        .LED(LED),
        .debug_mode(1)
    );
    initial begin
    
        //initialize variables
        address = 8'h00;
        read_en = 0;
        write_en = 0;
        input_data = 16'h0000;
    
        SW = 16'h0000;
        BTNS = 5'b00000;
        
        //run tests
//          Can read and write to memory
        #10;
            address = 8'h74;
            input_data = 16'hABCD;
            write_en = 1;
        #10
            write_en = 0;
            read_en = 1;
        #10
            read_en = 0;
        //output_data should be ABCD
            
//          write to LED address creates an automatic change in LED
        #10
            address = 8'h44;
            input_data = 16'h1234;
            write_en = 1;
        #10
            write_en = 0;
        //LEDs display 0x1234
        
//          cannot write to read only
        #10
            address = 8'h4E;
            input_data = 16'h9876;
            write_en = 1;
        #10
            write_en = 0;
            read_en = 1;
        #10
            read_en = 0;
        //output_data should read 0x0000 because SW have not been changed
//          a read from SW address outputs the current value of the switches
        #10
            SW = 16'h9876;
            address = 8'h4E;
            read_en = 1;
        #10
            read_en = 0;
        //output data should read 9876
        $finish;
    end
    always begin
        #1 CLK = ~CLK;
    end
endmodule
