# VLSI Design and Semiconductor Engineering - Task 2

This repository contains the Task 2 RTL designs, self-checking testbenches, simulation evidence, diagrams, and project report.

## Project scope

- Sequential logic: D flip-flops, registers, and shift registers with synchronous and asynchronous reset.
- Counters: 4-bit up/down, Mod-10, ring, and Johnson counters.
- Reusable RTL: parameterized registers, counters, and shift registers.
- FSM controllers: Moore and Mealy traffic lights, vending machine, and elevator.
- Mini-project: a clocked Moore traffic-light controller with timed state transitions.
- Verification: seven self-checking testbenches, simulator logs, VCD traces, and four GTKWave screenshots.
- Documentation: RTL block diagrams, FSM diagrams, timing diagram, truth tables, counter design documentation, and project report PDF.

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
- `waveforms/` - GTKWave screenshot previews and image files
- `docs/` - counter design, truth tables, diagrams, timing notes, and report
- `progress_log/` - dated work log

The Task 2 PDF lists GTKWave screenshots as a deliverable but does not specify a required number. Four representative screenshots are included; all seven testbenches also have committed simulator logs and VCD traces.

## Verification status

The seven self-checking testbenches were run in Ubuntu/WSL with Icarus Verilog 12.0 on 2026-11-08 and all passed. The corresponding logs and VCD traces are committed. The three-page project report PDF is in `docs/task2_project_report.pdf`.
