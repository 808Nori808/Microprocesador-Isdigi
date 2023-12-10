// --- E n t r a d a s ----------------------------
// Bus de datos IMEM: idata
// Bus de datos de lectura DMEM: ddata_r
// ------------------------------------------------

// --- S a l i d a s ------------------------------
// Bus de direcciones IMEM: iaddr
// Bus de direcciones DMEM: daddr 
// Bus de datos de escritura DMEM: ddata_w
// ------------------------------------------------

module procesador 
#(parameter data_size = 1024, parameter address_size = 32)
(
    input CLK,RESET_N,
    input [size-1:0] idata, ddata_r,
    output [$clog2(data_size-1)-1:0] iaddr, daddr
    output [size-1:0] ddata_w, 
    output d_rw
);
    


endmodule