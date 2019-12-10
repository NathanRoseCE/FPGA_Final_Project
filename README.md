# FPGA_Final_Project
This project is an improvement on a microprocessor done in class.

Features of this project
  1. Data Memory seperated from Instruction Memory
  2. All IO peripherials mapped to Data Memory
  3. Data Memory contains a stack and room for an interupt vector
  3. 3 stage pipelined processor(Instruction Fetch/Decode, Execute, Writeback)
  
Future Goals of this project
  1. Improve Pipeline to optimize for most common case(register on register operations)
  2. Combine Instruction and Data Memory into a main memory with two L1 caches for data and instructions
  3. Ensure the processor can run on the 50MHz clock
  4. Expand to a more common 32 or 64 bit.
