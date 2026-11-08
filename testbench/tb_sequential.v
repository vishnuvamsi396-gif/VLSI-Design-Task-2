module tb_sequential;
    reg clk = 0;
    always #5 clk = ~clk;
    reg reset = 0, d = 0, serial_in = 0;
    reg [7:0] data_in = 0;
    wire q_sync, q_async;
    wire [7:0] reg_sync_out, reg_async_out, shift_sync_out, shift_async_out;

    dff_sync_reset d0(clk, reset, d, q_sync);
    dff_async_reset d1(clk, reset, d, q_async);
    register_sync #(8) r0(clk, reset, data_in, reg_sync_out);
    register_async #(8) r1(clk, reset, data_in, reg_async_out);
    shift_register_sync #(8) s0(clk, reset, serial_in, shift_sync_out);
    shift_register_async #(8) s1(clk, reset, serial_in, shift_async_out);

    initial begin
        $dumpfile("simulation/vcd/tb_sequential.vcd");
        $dumpvars(0, tb_sequential);
        reset = 1; #1;
        if (q_async !== 0 || reg_async_out !== 0 || shift_async_out !== 0)
            $fatal(1, "Asynchronous reset did not act immediately");
        @(negedge clk); #1;
        if (q_sync !== 0 || reg_sync_out !== 0 || shift_sync_out !== 0)
            $fatal(1, "Synchronous reset failed at clock edge");
        reset = 0; d = 1; data_in = 8'hA5; serial_in = 1;
        @(posedge clk); #1;
        if (q_sync !== 1 || q_async !== 1 || reg_sync_out !== 8'hA5 ||
            reg_async_out !== 8'hA5 || shift_sync_out !== 8'h01 || shift_async_out !== 8'h01)
            $fatal(1, "First data capture/shift failed");
        @(negedge clk); d = 0; data_in = 8'h3C; serial_in = 0;
        @(posedge clk); #1;
        if (q_sync !== 0 || q_async !== 0 || reg_sync_out !== 8'h3C ||
            reg_async_out !== 8'h3C || shift_sync_out !== 8'h02 || shift_async_out !== 8'h02)
            $fatal(1, "Second data capture/shift failed");
        @(negedge clk); reset = 1; #1;
        if (q_async !== 0 || reg_async_out !== 0 || shift_async_out !== 0)
            $fatal(1, "Asynchronous reset assertion failed");
        @(posedge clk); #1;
        if (q_sync !== 0 || reg_sync_out !== 0 || shift_sync_out !== 0)
            $fatal(1, "Synchronous reset assertion failed");
        reset = 0;
        $display("PASS: sequential logic and reset behavior");
        $finish;
    end
endmodule
