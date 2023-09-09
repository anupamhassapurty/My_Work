module fifo #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
) (
    input clk,
    input rst,
    input write_enable,
    input read_enable,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output reg full,
    output reg empty,
    output reg overflow,
    output reg underflow,
    output reg overrun,
    output reg underrun
);

reg [WIDTH-1:0] memory [0:DEPTH-1];
reg [4:0] write_pointer = 0;
reg [4:0] read_pointer = 0;
reg [4:0] count = 0;

always @(posedge clk) begin
    if (rst) begin
        write_pointer <= 0;
        read_pointer  <= 0;
        count 		  <= 0;
        full 		  <= 0;
        empty 		  <= 1;
        overflow 	  <= 0;
        underflow 	  <= 0;
        overrun       <= 0;
        underrun      <= 0;
    end
    else begin
        
		if (write_enable && !full) begin
            memory[write_pointer] <= data_in;
            write_pointer <= write_pointer + 1;
            count <= count + 1;
            empty <= 0;
            
			if (write_pointer == DEPTH) begin
                overflow <= 1;
                write_pointer <= 0;
            end
        end
        
		if (read_enable && !empty) begin
            data_out <= memory[read_pointer];
            read_pointer <= read_pointer + 1;
            count <= count - 1;
            full <= 0;
            
			if (read_pointer == DEPTH) begin
                underflow <= 1;
                read_pointer <= 0;
            end
        end
        
		if (count == DEPTH) begin
            full <= 1;
            
			if (write_enable) begin
                overrun <= 1;
            end
            else if (read_enable) begin
                underrun <= 1;
            end
        end
        
		if (count == 0) begin
            empty <= 1;
        end
    end
end

endmodule
