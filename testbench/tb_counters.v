`timescale 1ns/1ps
module tb_counters;
    reg clk = 0;
    always #5 clk = ~clk;
    reg reset = 1;
    wire [3:0] up, down, mod10, ring, johnson;

    up_counter_4bit u0(clk, reset, up);
    down_counter_4bit d0(clk, reset, down);
    mod10_counter m0(clk, reset, mod10);
    ring_counter r0(clk, reset, ring);
    johnson_counter j0(clk, reset, johnson);

    integer i;
    reg [3:0] exp_ring [0:3];
    reg [3:0] exp_johnson [0:7];
    initial begin
        exp_ring[0]=4'b0010; exp_ring[1]=4'b0100; exp_ring[2]=4'b1000; exp_ring[3]=4'b0001;
        exp_johnson[0]=4'b0001; exp_johnson[1]=4'b0011; exp_johnson[2]=4'b0111; exp_johnson[3]=4'b1111;
        exp_johnson[4]=4'b1110; exp_johnson[5]=4'b1100; exp_johnson[6]=4'b1000; exp_johnson[7]=4'b0000;
        $dumpfile("simulation/vcd/tb_counters.vcd");
        $dumpvars(0, tb_counters);
        @(posedge clk); #1;
        if (up !== 0 || down !== 15 || mod10 !== 0 || ring !== 1 || johnson !== 0)
            $fatal(1, "Counter reset values failed");
        reset = 0;
        for (i=1; i<=16; i=i+1) begin
            @(posedge clk); #1;
            if (up !== (i % 16)) $fatal(1, "Up-counter mismatch at %0d", i);
            if (down !== ((31-i) % 16)) $fatal(1, "Down-counter mismatch at %0d", i);
            if (mod10 !== (i % 10)) $fatal(1, "Mod-10 mismatch at %0d", i);
            if (ring !== exp_ring[(i-1) % 4]) $fatal(1, "Ring-counter mismatch at %0d", i);
            if (johnson !== exp_johnson[(i-1) % 8]) $fatal(1, "Johnson-counter mismatch at %0d", i);
        end
        $display("PASS: up, down, Mod-10, ring, and Johnson counters");
        $finish;
    end
endmodule
