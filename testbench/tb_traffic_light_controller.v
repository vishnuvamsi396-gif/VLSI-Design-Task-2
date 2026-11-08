`timescale 1ns/1ps
module tb_traffic_light_controller;
    reg clk=0, reset=1;
    always #5 clk=~clk;
    wire red,yellow,green;
    traffic_light_controller #(.RED_CYCLES(2),.GREEN_CYCLES(3),.YELLOW_CYCLES(1))
        dut(clk,reset,red,yellow,green);

    task cycle;
        begin @(posedge clk); #1; end
    endtask
    initial begin
        $dumpfile("simulation/vcd/tb_traffic_light_controller.vcd");
        $dumpvars(0,tb_traffic_light_controller);
        cycle();
        if (!red || yellow || green) $fatal(1,"Reset must select red");
        reset=0;
        cycle(); if (!red) $fatal(1,"Red interval ended too early");
        cycle(); if (!green) $fatal(1,"Red interval should transition to green");
        cycle(); if (!green) $fatal(1,"Green interval ended too early");
        cycle(); if (!green) $fatal(1,"Green interval ended too early");
        cycle(); if (!yellow) $fatal(1,"Green interval should transition to yellow");
        cycle(); if (!red) $fatal(1,"Yellow interval should transition to red");
        $display("PASS: autonomous timed Moore traffic-light mini-project");
        $finish;
    end
endmodule
