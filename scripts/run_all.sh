#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p simulation/build simulation/results simulation/vcd

run_tb() {
    local top="$1"
    shift
    local log="simulation/results/${top}.log"
    iverilog -g2012 -Wall -s "$top" -o "simulation/build/$top" "$@"
    vvp "simulation/build/$top" > "$log"
    cat "$log"
}

run_tb tb_sequential rtl/sequential.v testbench/tb_sequential.v
run_tb tb_counters rtl/counters.v testbench/tb_counters.v
run_tb tb_parameterized rtl/parameterized.v testbench/tb_parameterized.v
run_tb tb_traffic_light rtl/fsm_controllers.v testbench/tb_traffic_light.v
run_tb tb_other_fsm rtl/fsm_controllers.v testbench/tb_other_fsm.v
run_tb tb_timing rtl/sequential.v testbench/tb_timing.v

echo "All Task 2 testbenches passed."
