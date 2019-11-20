


module data_mem (
        //control values
        input CLK,
        input [7:0] address,
        input read_en,
        input write_en,
        input [15:0] input_data,
        output reg [15:0] output_data,
        
        //values for IO hooked up to data memory
        input [15:0] SW,
        input [4:0] BTNS,
        output [7:0] CA, AN,
        output [15:0] LED,
        
        //debug variables
        input debug_mode
    );
    
    reg [7:0] memory[255:0];
    reg[7:0] i;
    initial begin 
        for(i = 0; i < 255; i=i+1) begin
            memory[i] = 0;
        end
    end
    //output stuff
    ssegx8 sevenSegment(
        .CLK(CLK),
        .VALUE({memory[40], memory[41], memory[42], memory[43]}),
        .SSEG_CA(CA),
        .SSEG_AN(AN),
        .debug(debug_mode)
    );
    assign LED = {memory[8'h44], memory[8'h45]};
    
    always@(*) begin
        //input stuff
        memory[8'h4E] <= SW[15:8];
        memory[8'h4F] <= SW[7:0];
        memory[8'h51] <= BTNS;//just act like its 50
        
        if(read_en) begin
            output_data[15:8] <= memory[address];
            output_data[7:0] <= memory[address + 1];
        end
        //Only a read operation or a write operation can be performed at
        //any given time
        else if(write_en) begin
            
            //accounts for read only sections of memory
            case(address)
            8'h4E:;
            8'h4F:;
            8'h50:;
            //write allowed here
            default: begin
                    //you can write two bytes at at time!
                    //but only two bytes at a time, so be careful.......
                    memory[address] <= input_data[15:8];
                    memory[address + 1] <= input_data[7:0];
                    end
            endcase
        end
    end
endmodule