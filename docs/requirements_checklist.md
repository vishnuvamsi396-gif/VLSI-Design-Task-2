# Task 2 requirements checklist

Status is based on files present in this public repository and the recorded WSL simulation run.

| PDF requirement | Repository location | Status |
|---|---|---|
| Sequential logic: D flip-flop, register, shift register; synchronous/asynchronous reset | rtl/sequential.v | Implemented; testbench passes |
| 4-bit up/down, Mod-10, ring, Johnson counters | rtl/counters.v | Implemented; testbench passes |
| Parameterized N-bit register/counter/shift register at multiple widths | rtl/parameterized.v | Implemented; 4-bit and 8-bit tests pass |
| Moore and Mealy traffic-light FSMs | rtl/fsm_controllers.v | Implemented; testbench passes |
| Vending machine and elevator controllers | rtl/fsm_controllers.v | Implemented; testbench passes |
| Clock/reset timing and setup/hold discussion | docs/design_notes.md, docs/diagrams/timing_reset.svg, waveforms/timing.png | Explanation and illustration included; reset timing test passes; GTKWave timing capture included |
| Automated testbenches and simulation output | testbench/, scripts/run_all.sh, simulation/results/ | Seven testbenches pass; seven actual logs included |
| Traffic-light Moore FSM mini-project | rtl/fsm_controllers.v | Timed autonomous controller and testbench pass |
| FSM transition diagrams | docs/diagrams/ | Traffic-light, vending-machine, and elevator diagrams included |
| RTL block diagram | docs/diagrams/task2_rtl_overview.svg | Included and embedded in diagram index |
| Counter design documentation | docs/design_notes.md | Included |
| VCD simulation traces | simulation/vcd/ | Seven actual traces included |
| GTKWave screenshots | waveforms/ | Four GTKWave PNG captures included: sequential logic, counters, traffic-light controller, and reset timing |
| README and project report PDF | README.md, docs/task2_project_report.pdf | Both included; report is a 3-page PDF |
| Daily progress log | progress_log/progress.md and dated evidence addendum | Included |
| GitHub repository | https://github.com/vishnuvamsi396-gif/VLSI-Design-Task-2 | Public repository on main |
