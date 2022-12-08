module fifo #(parameter  WIDTH = 8, parameter SIZE = $clog2(WIDTH))(
    input  logic [WIDTH-1:0] data_in;
    input  logic clk, rst;
    input  logic inp_val, out_rdy;
    output logic inp_rdy, out_val; 
    output logic [WIDTH-1:0] data_out;

logic [WIDTH:0] count;
logic [WIDTH-1:0] fifo_mem [0:WIDTH-1];
logic [SIZE-1:0] wr_ptr, rd_ptr;
logic empty, full;

assign empty   = (count==0);
assign full    = (count==WIDTH);

assign inp_rdy = !full;
assign out_val = !empty;

/////////////
//reset block
/////////////
always @(posedge(clk)) begin
    if (rst) begin
        wr_ptr  <= 1'b0;
        rd_ptr  <= 1'b0;
        count <= 0;
        inp_rdy <= 1'b1;
        out_val <= 1'b0;
    end
    else begin
        wr_ptr  <= (inp_rdy && inp_val) ? wr_ptr+1'b1 : wr_ptr;
        rd_ptr  <= (out_rdy && out_val) ? rd_ptr+1'b1 : rd_ptr;
    end
end

/////////////
//write block
/////////////
always @(posedge(clk)) begin
    if(inp_rdy && inp_val) begin
        fifo_mem[wr_ptr] <= data_in;
        count            <= count+1;
    end
end

/////////////
//read block
/////////////
always @(posedge(clk)) begin
    if(out_rdy && out_val) begin
        data_out <= fifo_mem[rd_ptr];
        count    <= count-1;
    end
end
endmodule