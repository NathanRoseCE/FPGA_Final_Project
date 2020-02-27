# FPGA_Final_Project
In my FPGA class at Embry-Riddle Aeronautical University, the code for a simplified Verilog microprocessor, called the Butka Proccessor after the Proffesor of the class Dr. Butka. This was given to us in order for us to learn to develop modular design in Verilog. 
For the final project we were tasked with coming up with a Project that would help illustrate understanding of Verilog. My choice was to improve the Butka Processor and upgrade it to the Rose Processor.
Several Features were added to this Proccesor in order to improve its performance and capabilties:
  1. A 3 stage Pipeline
  
In order to keep the processor simple and easily understandable, performance was sacrificed in the Butka Processor. One example of this is that in order to simplify some register operations, the Butka Processor executes one instruction every 2 clock cycles. This was improved in the Rose Processor by including a three stage pipeline in the processor, in order to give it an one instruction every clock cycle and to also improve the maximum speed the processor can run at. These three Pipeline instructions are: Instruction Fetch/Decode, Execute, and Writeback.

  2. IO Peripherials mapped to Data Memory
  
In the Butka Processor, IO is mapped to a specific command and set of hardware, however in order to simplify the number of commands and to make it easier to IO drivers, the Rose Processor has IO mapped to Data Memory so that only two commands: Store and Load are needed for both memory operations and IO access.

  3. Stack
  
For simplification and ease of use the Butka Processor does not support a stack, meaning that it is quite difficult to create a function. However in the Rose Processor this was included in order to add the capability of a functions.

  4. Other Assorted Changes
  
When developing and to support the testing and development on this system several other minor changes were made to the system that do not directly fall under any of the categories above these being: Instruction memory expanded, Variable Opcode System Created.


