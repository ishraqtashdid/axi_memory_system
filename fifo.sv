module fifo #(
    parameter  WIDTH = 8,
    parameter  DEPTH = 8
)(
    input  logic             clk,
    input  logic             rst,
    
    input  logic [WIDTH-1:0] data_in,
    input  logic             inp_val,
    output logic             inp_rdy,
    
    output logic [WIDTH-1:0] data_out,    
    output logic             out_val,
    input  logic             out_rdy,

    output logic [$clog2(DEPTH+1)-1:0] count
);
    
    logic [WIDTH-1:0] fifo_mem [DEPTH];
    logic [$clog2(DEPTH+1)-1:0] count;
    logic [$clog2(DEPTH)  -1:0] wr_ptr, rd_ptr;
    logic empty, full;

    assign inp_rdy = count < DEPTH;
    assign out_val = count > 0;
    
    assign inp_hs = inp_val & inp_rdy;
    assign out_hs = out_val & out_rdy;

    assign data_out = fifo_mem [rd_ptr];
    /////////////
    //reset block
    /////////////
    always @(posedge(clk)) begin
        if (rst) begin
            wr_ptr  <= '0;
            rd_ptr  <= '0;
            count   <= '0;
        end
        else begin 
            case ({inp_hs, out_hs})
                default:
                begin
                    count  <= count;
                    wr_ptr <= wr_ptr;
                    rd_ptr <= rd_ptr;
                end
                2'd01:
                begin
                    count  <= (count - 1);
                    wr_ptr <= wr_ptr;
                    if ((rd_ptr+1)<DEPTH)
                        rd_ptr <= rd_ptr+1;
                    else
                        rd_ptr <= '0;
                end
                2'b10:
                begin
                    count  <= (count +1);
                    fifo_mem [wr_ptr] <= data_in;                    
                    if ((wr_ptr+1)<DEPTH)
                        wr_ptr <= wr_ptr+1;
                    else
                        wr_ptr <= '0;
                    rd_ptr <= rd_ptr;
                end
                2'b11:
                begin
                    count  <= count;
                    fifo_mem [wr_ptr] <= data_in;
                    if ((wr_ptr+1)<DEPTH)
                        wr_ptr <= wr_ptr+1;
                    else
                        wr_ptr <= '0;
                    if ((rd_ptr+1)<DEPTH)
                        rd_ptr <= rd_ptr+1;
                    else
                        rd_ptr <= '0;
                end
            endcase
        end
    end

endmodule
