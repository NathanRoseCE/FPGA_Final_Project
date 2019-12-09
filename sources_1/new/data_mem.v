


module data_mem (
        //control values
        input full_clk,
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
    reg old_write_en;
    reg [7:0] memory[255:0];
    reg[7:0] i;
    reg [15:0] dataToWrite;
    reg [7:0] addrToWrite;
    initial begin 
        for(i = 0; i < 255; i=i+1) begin
            memory[i] <= 0;
        end
        output_data <= 0;
    end
    //output stuff
    SevenSegment se(
        .CLK(full_clk),
        .VALUE({memory[8'h43], memory[8'h42], memory[8'h41], memory[8'h40]}),
        .AN(AN),
        .CA(CA)
    );
    assign LED = {memory[8'h45], memory[8'h44]};
    
    always@(posedge write_en) begin
        dataToWrite <= input_data;
        addrToWrite <= address;
    end
    
    always@(posedge full_clk) begin
        old_write_en <= write_en;
        //input stuff
        memory[8'h4F] <= SW[15:8];
        memory[8'h4E] <= SW[7:0];
        
        memory[8'h50] <= {4'h0, BTNS};
        
        if(read_en) begin
            output_data[15:8] <= memory[address + 1];
            output_data[7:0] <= memory[address];
        end
        if( (write_en ==0) && (old_write_en == 1) ) begin
            case(addrToWrite)
            8'h4F:;
            8'h4E:;
            8'h50:;
            default begin
                memory[addrToWrite + 1] <= dataToWrite[15:8];
                memory[addrToWrite] <= dataToWrite[7:0];
                end
            endcase
        end
    end
endmodule