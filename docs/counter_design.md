# Counter design documentation

## Common implementation

All five counters are positive-edge-triggered and use an active-high synchronous reset. The RTL uses nonblocking assignments. Once reset is deasserted, each counter advances on every rising clock edge; these five stand-alone counters have no enable input.

## Counter behavior

| Counter | Reset value | Next-state rule | Sequence from reset |
|---|---:|---|---|
| 4-bit up counter | `0000` | `count + 1` modulo 16 | 0, 1, 2, ... 15, 0, repeat |
| 4-bit down counter | `1111` | `count - 1` modulo 16 | 15, 14, ... 0, 15, repeat |
| Mod-10 counter | `0000` | If count is 9, load 0; otherwise add 1 | 0, 1, ... 9, 0, repeat |
| 4-bit ring counter | `0001` | Rotate left: `{count[2:0], count[3]}` | 0001, 0010, 0100, 1000, repeat |
| 4-bit Johnson counter | `0000` | Shift left and feed back inverted MSB: `{count[2:0], ~count[3]}` | 0000, 0001, 0011, 0111, 1111, 1110, 1100, 1000, repeat |

The binary up and down counters wrap naturally because their registers are four bits wide. The Mod-10 counter explicitly wraps after decimal 9. The ring counter circulates a single set bit; the Johnson counter circulates the inverted last bit and produces eight states from four flip-flops.

## Verification

`testbench/tb_counters.v` checks the reset values of all five counters, then checks their expected values over 16 clock cycles. This covers a full up/down wrap, a Mod-10 wrap, four complete ring-counter states, and two complete Johnson-counter sequences. A mismatch ends the simulation with `$fatal`; a successful run prints a PASS message. The recorded run output is in `simulation/results/tb_counters.log`, and its waveform is in `simulation/vcd/tb_counters.vcd`.

See [counter architecture](diagrams/counter_architecture.svg) for the five RTL blocks and their shared clock/reset inputs.
