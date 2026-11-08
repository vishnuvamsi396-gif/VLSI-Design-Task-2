# VLSI Design and Semiconductor Engineering - Task 2

This repository is for Task 2: combinational and sequential RTL design, counters, parameterized modules, finite state machines, timing concepts, and simulation.

## Project scope

- Sequential logic: D flip-flops, registers, and shift registers with synchronous and asynchronous reset.
- Counters: 4-bit up/down, Mod-10, ring, and Johnson counters.
- Reusable RTL: parameterized registers, counters, and shift registers.
- FSM controllers: Moore and Mealy traffic lights, vending machine, and elevator.
- Mini-project: a clocked Moore traffic-light controller with timed state transitions.
- Verification: self-checking testbenches, simulation logs, VCD traces, and GTKWave screenshots.
- Documentation: block diagrams, state diagrams, timing diagrams, counter notes, and a project report.

## Tools

Ubuntu or WSL, Icarus Verilog (iverilog and vvp), GTKWave, Git, and Visual Studio Code with a Verilog extension.

## Run the simulations

From the repository root:

```sh
chmod +x scripts/run_all.sh
./scripts/run_all.sh
```

The script will compile and run each testbench, save output logs under simulation/results/, and VCD traces under simulation/vcd/.

To open a waveform:

```sh
gtkwave simulation/vcd/tb_traffic_light.vcd
```

## Repository layout

- rtl/ - synthesizable Verilog modules
- testbench/ - self-checking simulation testbenches
- scripts/ - simulation automation
- simulation/results/ - captured simulator output
- simulation/vcd/ - waveform traces
- waveforms/ - GTKWave screenshots
- docs/ - design notes, diagrams, timing analysis, checklist, and report
- progress_log/ - dated work log

## Status

Task 2 work is being developed in sections. Simulation results and screenshots will be added after the corresponding RTL and testbenches have been run and reviewed.