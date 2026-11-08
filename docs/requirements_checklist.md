# Task 2 requirements checklist

Status is based on files present in this public repository and the recorded WSL simulation run.

| PDF requirement | Repository location | Status |
|---|---|---|
| Sequential logic: D flip-flop, register, shift register; synchronous/asynchronous reset | `rtl/sequential.v` | Implemented; testbench passes |
| 4-bit up/down, Mod-10, ring, Johnson counters | `rtl/counters.v`, `docs/counter_design.md` | Implemented and documented; testbench passes |
| Parameterized N-bit register/counter/shift register at multiple widths | `rtl/parameterized.v` | Implemented; 4-bit and 8-bit tests pass |
| Moore and Mealy traffic-light FSMs | `rtl/fsm_controllers.v` | Implemented; testbench passes and compares emergency behavior |
| Vending machine and elevator controllers | `rtl/fsm_controllers.v` | Implemented; testbench passes |
| Clock/reset timing and setup/hold discussion | `docs/design_notes.md`, `docs/diagrams/timing_reset.svg`, `waveforms/timing.png` | Explanation and illustration included; reset timing test passes |
| Automated testbenches and simulation output | `testbench/`, `scripts/run_all.sh`, `simulation/results/` | Seven testbenches pass; seven actual logs included |
| Traffic-light Moore FSM mini-project | `rtl/fsm_controllers.v` | Timed autonomous controller and testbench pass |
| FSM transition diagrams | `docs/diagrams/` | Traffic-light, vending-machine, and elevator diagrams included |
| RTL block diagrams | `docs/diagrams/` | Project overview, sequential blocks, counter architecture, and traffic-light RTL diagrams included |
| Timing diagrams | `docs/diagrams/timing_reset.svg` | Clock and synchronous/asynchronous reset timing illustrated |
| Truth tables | `docs/truth_tables.md` | Sequential, counter-control, and traffic-light output tables included |
| Counter design documentation | `docs/counter_design.md` | Reset values, next-state behavior, sequences, and test coverage documented |
| VCD simulation traces | `simulation/vcd/` | Seven actual traces included |
| GTKWave screenshots | `waveforms/` | Four representative PNG captures included; the PDF does not set a screenshot count |
| README and project report PDF | `README.md`, `docs/task2_project_report.pdf` | Both included; report is a 3-page PDF |
| Daily progress log | `progress_log/progress.md` and dated evidence addendum | Included |
| GitHub repository | https://github.com/vishnuvamsi396-gif/VLSI-Design-Task-2 | Public repository on main |
