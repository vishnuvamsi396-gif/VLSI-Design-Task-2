`timescale 1ns/1ps
// Traffic light FSMs use tick as a one-cycle state-advance enable.
// Colors are active-high one-hot outputs: {red, yellow, green}.
module traffic_light_moore(input wire clk, input wire reset, input wire tick,
                           output reg red, output reg yellow, output reg green);
    localparam RED = 2'd0, GREEN = 2'd1, YELLOW = 2'd2;
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) state <= RED;
        else if (tick) state <= next_state;
    end

    always @* begin
        case (state)
            RED:    next_state = GREEN;
            GREEN:  next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end

    always @* begin
        red = (state == RED);
        yellow = (state == YELLOW);
        green = (state == GREEN);
    end
endmodule

// Mealy example: emergency forces a red output immediately, independent of state.
module traffic_light_mealy(input wire clk, input wire reset, input wire tick,
                            input wire emergency,
                            output reg red, output reg yellow, output reg green);
    localparam RED = 2'd0, GREEN = 2'd1, YELLOW = 2'd2;
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) state <= RED;
        else if (tick) state <= next_state;
    end

    always @* begin
        case (state)
            RED:    next_state = GREEN;
            GREEN:  next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end

    always @* begin
        red = emergency || (state == RED);
        green = !emergency && (state == GREEN);
        yellow = !emergency && (state == YELLOW);
    end
endmodule

// Vending machine accepts 5- and 10-unit coins; a product costs 15 units.
// vend is asserted for one clock cycle; change5 reports a 5-unit overpayment.
module vending_machine(input wire clk, input wire reset, input wire coin5, input wire coin10,
                       output wire vend, output reg change5);
    localparam C0 = 2'd0, C5 = 2'd1, C10 = 2'd2, VEND = 2'd3;
    reg [1:0] state, next_state;
    assign vend = (state == VEND);

    always @(posedge clk) begin
        if (reset) state <= C0;
        else       state <= next_state;
    end

    always @* begin
        next_state = state;
        change5 = 1'b0;
        case (state)
            C0:  if (coin5) next_state = C5;
                 else if (coin10) next_state = C10;
            C5:  if (coin5) next_state = C10;
                 else if (coin10) next_state = VEND;
            C10: if (coin5) next_state = VEND;
                 else if (coin10) begin next_state = VEND; change5 = 1'b1; end
            VEND: next_state = C0;
            default: next_state = C0;
        endcase
    end
endmodule

// Small three-floor controller. A request is latched in IDLE; tick moves one floor.
module elevator_controller(input wire clk, input wire reset, input wire tick,
                            input wire request_valid, input wire [1:0] request_floor,
                            output reg [1:0] floor, output reg motor_up,
                            output reg motor_down, output reg door_open);
    localparam IDLE = 2'd0, UP = 2'd1, DOWN = 2'd2;
    reg [1:0] state, target_floor;
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE; floor <= 2'd0; target_floor <= 2'd0;
        end else begin
            case (state)
                IDLE: if (request_valid && request_floor < 2'd3) begin
                    target_floor <= request_floor;
                    if (request_floor > floor) state <= UP;
                    else if (request_floor < floor) state <= DOWN;
                end
                UP: if (tick) begin
                    floor <= floor + 1'b1;
                    if (floor + 1'b1 >= target_floor) state <= IDLE;
                end
                DOWN: if (tick) begin
                    floor <= floor - 1'b1;
                    if (floor - 1'b1 <= target_floor) state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
    always @* begin
        motor_up = (state == UP);
        motor_down = (state == DOWN);
        door_open = (state == IDLE);
    end
endmodule

 
// Autonomous Moore traffic-light mini-project. Each state lasts its configured
// number of clock cycles; the defaults are short for simulation and can be
// increased for a hardware clock after choosing a suitable counter width.
module traffic_light_controller #(
    parameter integer RED_CYCLES = 3,
    parameter integer GREEN_CYCLES = 3,
    parameter integer YELLOW_CYCLES = 1
) (
    input wire clk, input wire reset,
    output reg red, output reg yellow, output reg green
);
    localparam RED = 2'd0, GREEN = 2'd1, YELLOW = 2'd2;
    reg [1:0] state;
    reg [31:0] elapsed;
    reg [31:0] state_limit;

    always @* begin
        case (state)
            RED: state_limit = RED_CYCLES;
            GREEN: state_limit = GREEN_CYCLES;
            YELLOW: state_limit = YELLOW_CYCLES;
            default: state_limit = RED_CYCLES;
        endcase
        red = (state == RED);
        green = (state == GREEN);
        yellow = (state == YELLOW);
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= RED;
            elapsed <= 0;
        end else if (elapsed + 1 >= state_limit) begin
            elapsed <= 0;
            case (state)
                RED: state <= GREEN;
                GREEN: state <= YELLOW;
                YELLOW: state <= RED;
                default: state <= RED;
            endcase
        end else begin
            elapsed <= elapsed + 1;
        end
    end
endmodule
