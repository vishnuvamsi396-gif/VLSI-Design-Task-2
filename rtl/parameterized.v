// Reusable synchronous RTL building blocks. Reset is active-high.
module parameterized_register #(parameter WIDTH = 8) (
    input wire clk, input wire reset, input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk) begin
        if (reset) data_out <= {WIDTH{1'b0}};
        else       data_out <= data_in;
    end
endmodule

module parameterized_counter #(parameter WIDTH = 4) (
    input wire clk, input wire reset, input wire enable, input wire direction,
    output reg [WIDTH-1:0] count
);
    always @(posedge clk) begin
        if (reset)       count <= {WIDTH{1'b0}};
        else if (enable && direction)  count <= count + 1'b1;
        else if (enable && !direction) count <= count - 1'b1;
    end
endmodule

// Shifts left; serial_in enters bit 0.
module parameterized_shift_register #(parameter WIDTH = 8) (
    input wire clk, input wire reset, input wire enable, input wire serial_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk) begin
        if (reset) data_out <= {WIDTH{1'b0}};
        else if (enable) data_out <= (data_out << 1) | serial_in;
    end
endmodule
