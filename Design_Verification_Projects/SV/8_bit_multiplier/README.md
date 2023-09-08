# 8-Bit Synchronous Multiplier Verification Plan

## EDA Playground Simulation

You can explore and simulate this verification project online [Click Here](https://edaplayground.com/x/iGVL).

## Project Overview

This project focuses on the verification of an 8-bit synchronous multiplier (DUT) written in System Verilog. The DUT has two 8-bit inputs and produces a 16-bit output. The goal is to ensure that the multiplier performs correct multiplications.

## Verification Environment

### Testbench Architecture

The verification environment consists of the following components:
- **Testbench:** Generates stimuli and manages the verification flow.
- **DUT (Design Under Test):** The 8-bit synchronous multiplier to be verified.
- **Scoreboard:** Compares the DUT's output with the expected results.
- **Monitor:** Observes and collects data from the DUT for analysis.
- **Random Transaction Generator:** Generates random test cases.

### Verification Process

1. **Test Case Generation:** Random transactions are generated using the Random Transaction Generator, creating various input scenarios.

2. **Stimulus Generation:** The testbench applies 10 random transactions as stimuli to the DUT's inputs.

3. **DUT Operation:** The DUT performs multiplication based on the given inputs.

4. **Scoreboard Verification:** The Scoreboard checks the DUT's output against expected results.

5. **Result Reporting:** Based on the comparison:
   - If correct multiplication occurs, the message "Multiplication Data Matched" is sent.
   - If multiplication is incorrect, the message "Error In Multiplication" is sent.
