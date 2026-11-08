`timescale 1ns/1ps
module tb_traffic_light;
    reg clk=0;
    always #5 clk=~clk;
    reg reset=1, tick=0, emergency=0;
    wire mr,my,mg, er,ey,eg;
    traffic_light_moore moore(clk,reset,tick,mr,my,mg);
    traffic_light_mealy mealy(clk,reset,tick,emergency,er,ey,eg);

    task step;
        begin tick=1; @(posedge clk); #1; tick=0; end
    endtask
    initial begin
        $dumpfile("simulation/vcd/tb_traffic_light.vcd");
        $dumpvars(0,tb_traffic_light);
        @(posedge clk); #1;
        if (!mr || !er) $fatal(1,"Reset state should be red");
        reset=0; step();
        if (!mg || !eg) $fatal(1,"Red should advance to green");
        emergency=1; #1;
        if (!er || eg || ey) $fatal(1,"Mealy emergency response failed");
        if (!mg) $fatal(1,"Moore output should remain tied to its state");
        emergency=0; step();
        if (!my || !ey) $fatal(1,"Green should advance to yellow");
        step();
        if (!mr || !er) $fatal(1,"Yellow should advance to red");
        $display("PASS: Moore/Mealy traffic-light FSM behavior");
        $finish;
    end
endmodule
