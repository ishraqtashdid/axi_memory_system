package axi_pkg;

    localparam ID_WIDTH   = 2;
    localparam ADDR_WIDTH = 16;
    localparam USER_WIDTH = 16;
    localparam DATA_WIDTH = 16;

    typedef bit [ID_WIDTH-1:0]  id_t;
    typedef struct packed {
        bit [ADDR_WIDTH-13:0]  bank_addr;
        bit [11-SIZE:0]        row_addr;
        bit [SIZE-1:0]         col_addr;
    } addr_t;
    typedef bit [7:0] len_t;
    typedef bit [2:0] size_t;
    typedef bit [1:0] burst_t;
    typedef bit lock_t;
    typedef bit [3:0] cache_t;
    typedef bit [2:0] prot_t;
    typedef bit [3:0] qos_t;
    typedef bit [3:0] region_t;
    typedef bit [USER_WIDTH-1:0] user_t;
    typedef bit [DATA_WIDTH/8-1:0][7:0] data_t;
    typedef bit [DATA_WIDTH/8-1:0] strb_t;
    typedef bit last_t;
    typedef bit [1:0] resp_t;

    typedef struct packed {
        id_t      id;
        addr_t    addr;
        lock_t    lock;
        prot_t    prot;
        region_t  region;
    } rd_req_t;

    typedef struct packed {
        id_t      id;
        addr_t    addr;
        lock_t    lock;
        prot_t    prot;
        region_t  region;
        data_t    data;
        strb_t    strb;
        last_t    last;
    } wr_req_t;

endpackage
