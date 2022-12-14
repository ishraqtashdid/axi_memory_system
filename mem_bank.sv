module mem_bank #(
    parameter SIZE = 7
) (
    input  logic                      clk,
    input  logic                      we,
    input  logic [11-SIZE:0]          row_addr,
    input  logic [(2**SIZE)-1:0][7:0] wdata,
    input  logic [(2**SIZE)-1:0]      wstrb,
    output logic [(2**SIZE)-1:0][7:0] rdata
);

    logic [(2**(12-SIZE))-1:0][(2**SIZE)-1:0][7:0] mem;

    always @ (posedge clk)
    begin
        rdata <= mem[row_addr];
        for (int i = 0; i < (2**SIZE); i++)
        begin
            if (wstrb[i])
            begin
                mem[row_addr][i] <= wdata [i];
            end
        end
    end
    
endmodule