module tb_other_fsm;
    reg clk=0;
    always #5 clk=~clk;
    reg reset=1, coin5=0, coin10=0, tick=0, request_valid=0;
    reg [1:0] request_floor=0;
    wire vend, change5;
    wire [1:0] floor;
    wire motor_up, motor_down, door_open;
    vending_machine vm(clk,reset,coin5,coin10,vend,change5);
    elevator_controller ec(clk,reset,tick,request_valid,request_floor,floor,motor_up,motor_down,door_open);

    task cycle;
        begin @(posedge clk); #1; end
    endtask
    initial begin
        $dumpfile("simulation/vcd/tb_other_fsm.vcd");
        $dumpvars(0,tb_other_fsm);
        cycle();
        if (!door_open || floor !== 0 || vend) $fatal(1,"FSM reset failed");
        reset=0; coin5=1; cycle(); coin5=0;
        coin10=1; cycle(); coin10=0;
        if (!vend) $fatal(1,"Vending at 15 units failed");
        cycle(); if (vend) $fatal(1,"Vend pulse should clear");
        coin10=1; cycle(); coin10=0;
        coin10=1; #1; if (!change5) $fatal(1,"Expected 5 units change for 20-unit payment");
        cycle(); coin10=0;
        if (!vend) $fatal(1,"Overpayment should vend");
        cycle();
        request_valid=1; request_floor=2; cycle(); request_valid=0;
        if (!motor_up || floor !== 0) $fatal(1,"Elevator did not start upward");
        tick=1; cycle(); if (floor !== 1 || !motor_up) $fatal(1,"Elevator floor 1 transition failed");
        cycle(); tick=0;
        if (floor !== 2 || !door_open || motor_up) $fatal(1,"Elevator arrival failed");
        $display("PASS: vending machine and elevator FSMs");
        $finish;
    end
endmodule
