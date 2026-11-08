module tb_parameterized;
    reg clk = 0;
    always #5 clk = ~clk;
    reg reset = 1, enable = 0, direction = 1, serial_in = 0;
    reg [3:0] din4 = 0;
    reg [7:0] din8 = 0;
    wire [3:0] dout4, count4, shift4;
    wire [7:0] dout8, count8, shift8;
    reg [3:0] expected_shift4 = 0;
    reg [7:0] expected_shift8 = 0;

    parameterized_register #(4) r4(clk, reset, din4, dout4);
    parameterized_register #(8) r8(clk, reset, din8, dout8);
    parameterized_counter #(4) c4(clk, reset, enable, direction, count4);
    parameterized_counter #(8) c8(clk, reset, enable, direction, count8);
    parameterized_shift_register #(4) s4(clk, reset, enable, serial_in, shift4);
    parameterized_shift_register #(8) s8(clk, reset, enable, serial_in, shift8);

    integer i;
    initial begin
        $dumpfile("simulation/vcd/tb_parameterized.vcd");
        $dumpvars(0, tb_parameterized);
        @(posedge clk); #1; reset = 0; din4 = 4'hA; din8 = 8'hA5;
        @(posedge clk); #1;
        if (dout4 !== 4'hA || dout8 !== 8'hA5) $fatal(1, "Parameterized register failed");
        enable = 1; serial_in = 1;
        for (i=1; i<=16; i=i+1) begin
            @(posedge clk); #1;
            expected_shift4 = (expected_shift4 << 1) | 1'b1;
            expected_shift8 = (expected_shift8 << 1) | 1'b1;
            if (count4 !== (i % 16) || count8 !== i[7:0]) $fatal(1, "Parameterized up-counter failed");
            if (shift4 !== expected_shift4 || shift8 !== expected_shift8) $fatal(1, "Parameterized shift failed");
        end
        direction = 0;
        @(posedge clk); #1;
        if (count4 !== 4'hF || count8 !== 8'h10) $fatal(1, "Parameterized down-count failed");
        $display("PASS: parameterized registers, counters, and shift registers at 4 and 8 bits");
        $finish;
    end
endmodule
