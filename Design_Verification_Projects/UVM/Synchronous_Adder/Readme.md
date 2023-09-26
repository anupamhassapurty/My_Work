# Verification Plan for 4-bit Synchronous Adder

This document outlines the key aspects of our verification strategy for this design.

## Simulation and Verification

You can simulate and verify this design [Click Here](https://edaplayground.com/x/gqyK)

## Design Overview

- **Module:** 4-bit Synchronous Adder
- **Inputs:** a (4 bits), b (4 bits)
- **Outputs:** sum (4 bits), carry (1 bit)

## Testbench Architecture

Our verification environment is built using the Universal Verification Methodology (UVM). It consists of the following components:

- **Sequence:** The `sequence1` class generates random transactions to test the adder.
- **Driver:** The `driver` class drives the input transactions into the DUT.
- **Monitor:** The `monitor` class captures DUT outputs for analysis.
- **Scoreboard:** The `scoreboard` class checks the correctness of the DUT's output.

## Verification Plan

1. **Random Test Generation:**
   - We use sequences to generate 10 random test transactions.
   - For each transaction, we randomize inputs `a` and `b`.
   
2. **Driver Execution:**
   - The driver drives the randomized transactions into the DUT.
   - It waits for 2 clock cycles to account for the DUT's response.
3. **Monitor and Scoreboard:**
   - The monitor captures the DUT's outputs (sum and carry).
   - The scoreboard compares the DUT's results with the expected results.
   - If the DUT's output matches the expected output, the test passes.
   - If there is a mismatch, the test fails, and an error message is displayed.
