# Task 2 design notes

## Sequential logic

Sequential circuits store state and update it on a clock edge. The RTL uses nonblocking assignments (`<=`) in edge-triggered blocks.

- A D flip-flop captures D on the rising clock edge.
- A synchronous active-high reset clears state only at a rising edge.
- An asynchronous active-high reset clears state as soon as reset rises, independently of the clock.
- The shift registers move bits left by one on each rising edge; the serial input enters bit 0.

## Counter designs

| Circuit | Reset value | Sequence |
|---|---:|---|
| 4-bit up counter | 0 | 0 through 15, then wrap to 0 |
| 4-bit down counter | 15 | 15 through 0, then wrap to 15 |
| Mod-10 counter | 0 | 0 through 9, then return to 0 |
| 4-bit ring counter | 0001 | 0001, 0010, 0100, 1000, repeat |
| 4-bit Johnson counter | 0000 | 0000, 0001, 0011, 0111, 1111, 1110, 1100, 1000, repeat |

## Parameterized modules

The parameterized register, counter, and shift register use WIDTH to set their data width. The testbench instantiates 4-bit and 8-bit variants. The counter direction input selects increment or decrement; enable holds the current value when low.

## FSM controllers

### Traffic light

The Moore controller cycles RED -> GREEN -> YELLOW -> RED when tick is asserted. Outputs depend only on the registered state. Reset selects RED. The Mealy example has the same timed phase sequence, with an emergency input that forces the red output immediately; its outputs therefore depend on both state and input.

### Vending machine

The vending FSM accepts 5-unit and 10-unit coins. The product costs 15 units. It asserts vend for one clock cycle after sufficient credit and indicates a 5-unit overpayment through change5.

### Elevator

The three-floor elevator accepts a target floor request while idle and moves one floor per asserted tick. Its simplified outputs indicate motor direction and whether the car is idle with the door open.

## Timing concepts

Setup time is the minimum time data must be stable before a capturing clock edge. Hold time is the minimum time data must remain stable after that edge. Ideal RTL simulation with zero-delay assignments demonstrates clock-edge and reset behavior, but does not measure physical setup/hold margins. Those depend on cell and path delays and require timing constraints and static timing analysis.

The timing diagram in `diagrams/timing_reset.svg` illustrates the observable difference between synchronous and asynchronous reset. It is a conceptual diagram; simulator traces will be added after the test suite is run.
