module demux #(
    parameter NUM_ELEM   = 8,
    parameter ELEM_WIDTH = 32
) (
    input  logic [$clog2(NUM_ELEM)-1:0]         sel,
    input  logic               [ELEM_WIDTH-1:0] data_in,
    output logic [NUM_ELEM-1:0][ELEM_WIDTH-1:0] data_out
);

    always_comb begin
        for (int i = 0; i < NUM_ELEM; i++)
        begin
            if (i==sel)
                data_out [i] = data_in;
            else
                data_out [i] = '0;
        end
    end 

endmodule