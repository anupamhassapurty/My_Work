# Verification Plan for 4-Bit Synchronous Multiplier

This document outlines the objectives, features, and testing approach for this verification project.

## Simulating and Verifying

You can simulate and verify this 4-bit synchronous multiplier design online on EDA Playground.

👉 [Click Here](https://edaplayground.com/x/7ivv)

Feel free to explore the code and run your own simulations to verify the functionality of the multiplier.

## Objectives

The primary goal of this verification project is to thoroughly validate the functionality of the 4-bit synchronous multiplier. This includes ensuring that it correctly multiplies two 4-bit inputs (m and n) to produce a 16-bit output (mul). Additionally, the project aims to:

1. Verify proper functionality of the multiplier DUT under various scenarios.
2. Confirm that the design adheres to the specified behavior.
3. Detect and report any errors or discrepancies in multiplication results.
4. Facilitate easy simulation and verification using EDA Playground.

## Features

### 4-Bit Synchronous Multiplier (DUT)

- **Inputs**: Two 4-bit inputs, 'm' and 'n'.
- **Output**: A 16-bit output, 'mul'.
- **Clock**: Synchronous operation with a clock input.

## Verification Components

### UVM-Based Verification Environment

- **Sequence**: The 'sequence1' class generates random transactions to verify the multiplier.
- **Driver**: The 'driver' class sends transactions to the DUT and manages the interface.
- **Monitor**: The 'monitor' class captures signals and transactions for analysis.
- **Scoreboard**: The 'scoreboard' class checks the correctness of multiplication results.

## Testing Approach

1. **Random Stimulus Generation**: The 'sequence1' class generates 10 random transactions with random values for 'm' and 'n'.

2. **Driver**: The 'driver' class drives these transactions into the multiplier DUT through the interface.

3. **Monitor**: The 'monitor' class captures DUT signals, extracts transaction data, and sends it to the scoreboard for comparison.

4. **Scoreboard**: The 'scoreboard' class verifies if the multiplication results ('mul') match the expected results ('m * n') for each transaction.

5. **Result Reporting**: The scoreboard reports whether the multiplication data matched or if any errors occurred. Results are displayed in the simulation log.
---

This verification plan provides an overview of the objectives, features, and testing approach for the 4-bit synchronous multiplier design. For more details, explore the code and run simulations on EDA Playground. If you have any questions or encounter any issues, please don't hesitate to reach out.
