// Four-bit and classic sequence counters. All resets are synchronous and active-high.
module up_counter_4bit(input wire clk, input wire reset, output reg [3:0] count);
    always @(posedge clk) begin
        if (reset) count <= 4'd0;
        else       count <= count + 1'b1;
    end
endmodule

module down_counter_4bit(input wire clk, input wire reset, output reg [3:0] count);
    always @(posedge clk) begin
        if (reset) count <= 4'hF;
        else       count <= count - 1'b1;
    end
endmodule

module mod10_counter(input wire clk, input wire reset, output reg [3:0] count);
    always @(posedge clk) begin
        if (reset)      count <= 4'd0;
        else if (count == 4'd9) count <= 4'd0;
        else            count <= count + 1'b1;
    end
endmodule

// Four-bit one-hot ring sequence: 0001, 0010, 0100, 1000, ...
module ring_counter(input wire clk, input wire reset, output reg [3:0] count);
    always @(posedge clk) begin
        if (reset) count <= 4'b0001;
        else       count <= {count[2:0], count[3]};
    end
endmodule

// Four-bit Johnson sequence: 0000, 0001, 0011, 0111, 1111, 1110, ...
module johnson_counter(input wire clk, input wire reset, output reg [3:0] count);
    always @(posedge clk) begin
        if (reset) count <= 4'b0000;
        else       count <= {count[2:0], ~count[3]};
    end
endmodule
