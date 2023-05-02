module DDS(phase_cntrl, clk, out, rst);
    input [1:0] phase_cntrl;
    input clk, rst;
    output [7:0] out;
    wire [7:0] load_data;

    Register #(.N(8)) reg(.load_data(load_data), .clk(clk), .rst(rst), .out(out)); 

    assign load_data = out + phase_cntrl;
endmodule