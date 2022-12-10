module mux #(
    parameter NUM_ELEM   = 8,
    parameter ELEM_WIDTH = 32
) (
    input  logic [$clog2(NUM_ELEM)-1:0]         sel,
    input  logic [NUM_ELEM-1:0][ELEM_WIDTH-1:0] data_in,
    output logic               [ELEM_WIDTH-1:0] data_out
);

    always_comb begin
        data_out = data_in [sel];
    end 

endmodule