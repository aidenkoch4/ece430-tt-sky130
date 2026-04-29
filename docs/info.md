<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This design implements a 32×32-bit serial-parallel multiplier using a shift-and-add style architecture.

The core multiplier (pm32) uses:

A serial multiplication algorithm
A 32-bit shift register (Y)
A bit-serial partial product generator (spm)
A simple FSM with three states:
IDLE – waits for start
RUNNING – performs 64-cycle multiplication
DONE – signals completion

Each clock cycle:

The multiplier shifts operands
The spm module computes partial products
The result accumulates into a 64-bit register p

The design is fully synchronous and resets asynchronously.

## How to test

The design is verified using a cocotb testbench.

Basic test flow:

Apply reset (rst_n = 0 → 1)
Load test operands through the wrapper interface
Assert start
Wait for done
Check output against expected multiplication result

Example test case:

mc = 7
mp = 3
Expected result: 21

Because only 8-bit outputs are exposed in simulation, the testbench checks the lower bits of the result.

Run tests with:

make -B

## External hardware

This design does not require external hardware for simulation or normal operation.

For future physical implementation:

Inputs (mc, mp) would need to be serialized over limited I/O pins
Output (p) would be streamed out over time due to pin constraints
A simple microcontroller or FPGA could be used to interface with the design

No external peripherals are required for standalone operation.
