# 4-Bit Synchronous Adder Verification Plan

## Simulation
To simulate online and verify the 4-bit synchronous adder, you can [Click Here](https://edaplayground.com/x/v554)
## Module Description
The 4-bit synchronous adder (DUT) is implemented in System Verilog. It performs binary addition of two 4-bit inputs (a and b) with an optional carry input. The module outputs the sum of the inputs along with a carry-out signal.

## Verification Goals
1. Verify the correct addition operation of the 4-bit synchronous adder.
2. Ensure that the carry-out signal is generated accurately.
3. Test the adder module with various input combinations
4. Validate the design with a total of 10 random transactions.

## Test Environment
- **Clock Signal:** Provide a clock signal to the module.
- **Inputs:** Randomly generate or manually set input values for a and b.
- **Carry Input:** Optionally provide a carry input.
- **Expected Outputs:** Calculate the expected sum and carry-out based on the provided inputs.

## Test Cases :
   - Generate 10 random transactions as stimulus to the adder module.
   - Calculate and compare the expected outputs.
   - If correct addition, display "Adder Data Matched."
   - If addition is incorrect, display "Error In Addition."
