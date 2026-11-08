`timescale 1ns/1ps
// Sequential logic examples with active-high reset.
module dff_sync_reset(input wire clk, input wire reset, input wire d, output reg q);
    always @(posedge clk) begin
        if (reset) q <= 1'b0;
        else       q <= d;
    end
endmodule

module dff_async_reset(input wire clk, input wire reset, input wire d, output reg q);
    always @(posedge clk or posedge reset) begin
        if (reset) q <= 1'b0;
        else       q <= d;
    end
endmodule

module register_sync #(parameter WIDTH = 8) (
    input wire clk, input wire reset, input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk) begin
        if (reset) data_out <= {WIDTH{1'b0}};
        else       data_out <= data_in;
    end
endmodule

module register_async #(parameter WIDTH = 8) (
    input wire clk, input wire reset, input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) data_out <= {WIDTH{1'b0}};
        else       data_out <= data_in;
    end
endmodule

// Shifts left by one bit on each rising clock edge; serial_in enters bit 0.
module shift_register_sync #(parameter WIDTH = 8) (
    input wire clk, input wire reset, input wire serial_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk) begin
        if (reset) data_out <= {WIDTH{1'b0}};
        else       data_out <= (data_out << 1) | serial_in;
    end
endmodule

module shift_register_async #(parameter WIDTH = 8) (
    input wire clk, input wire reset, input wire serial_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) data_out <= {WIDTH{1'b0}};
        else       data_out <= (data_out << 1) | serial_in;
    end
endmodule
