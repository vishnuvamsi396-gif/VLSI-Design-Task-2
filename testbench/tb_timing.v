`timescale 1ns/1ps
module tb_timing;
    reg clk=0, reset=0, d=0;
    wire q_sync, q_async;
    always #5 clk=~clk;
    dff_sync_reset sync_ff(clk,reset,d,q_sync);
    dff_async_reset async_ff(clk,reset,d,q_async);

    initial begin
        $dumpfile("simulation/vcd/tb_timing.vcd");
        $dumpvars(0,tb_timing);
        d=1;
        @(posedge clk); #1;
        if (q_sync !== 1 || q_async !== 1) $fatal(1,"Initial capture failed");
        #1 reset=1; #1;
        if (q_async !== 0) $fatal(1,"Async reset should respond immediately");
        if (q_sync !== 1) $fatal(1,"Sync reset changed before the active clock edge");
        @(posedge clk); #1;
        if (q_sync !== 0 || q_async !== 0) $fatal(1,"Reset edge behavior failed");
        $display("PASS: synchronous/asynchronous reset timing around clock edges");
        $finish;
    end
endmodule
