# VLSI Design and Semiconductor Engineering - Task 2

This repository contains the Task 2 RTL designs, self-checking testbenches, simulation evidence, diagrams, and project notes.

## Project scope

- Sequential logic: D flip-flops, registers, and shift registers with synchronous and asynchronous reset.
- Counters: 4-bit up/down, Mod-10, ring, and Johnson counters.
- Reusable RTL: parameterized registers, counters, and shift registers.
- FSM controllers: Moore and Mealy traffic lights, vending machine, and elevator.
- Mini-project: a clocked Moore traffic-light controller with timed state transitions.
- Verification: self-checking testbenches, simulator logs, and VCD traces. GTKWave screenshots are still to be captured.
- Documentation: block diagrams, FSM diagrams, timing notes, counter design notes, requirements checklist, and final project report PDF (pending).

## Tools

Ubuntu or WSL, Icarus Verilog (iverilog and vvp), GTKWave, Git, and Visual Studio Code with a Verilog extension.

## Run the simulations

From the repository root:

```sh
bash scripts/run_all.sh
```

The script compiles and runs each testbench, saves output logs under `simulation/results/`, and VCD traces under `simulation/vcd/`.

To open a waveform:

```sh
gtkwave simulation/vcd/tb_traffic_light.vcd
```

## Repository layout

- `rtl/` - synthesizable Verilog modules
- `testbench/` - self-checking simulation testbenches
- `scripts/` - simulation automation
- `simulation/results/` - captured simulator output
- `simulation/vcd/` - waveform traces
- `waveforms/` - GTKWave screenshots (to be captured)
- `docs/` - design notes, diagrams, timing analysis, checklist, and report
- `progress_log/` - dated work log

## Verification status

The seven self-checking testbenches were run in Ubuntu/WSL with Icarus Verilog 12.0 on 2026-11-08 and all passed. The corresponding logs and VCD traces are committed. GTKWave screenshot capture and the final project PDF remain pending.
