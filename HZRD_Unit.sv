module HZRD_Unit(input logic MemRead_EX, output logic PCWrite, IF_ID_Write, HZRDcontrol);

always_comb
begin
    if(MemRead_EX)
        begin
            IF_ID_Write = 1;
            HZRDcontrol = 1;
            PCWrite = 1;
        end
    else 
        begin
            IF_ID_Write = 0;
            HZRDcontrol = 0;
            PCWrite = 0;
        end
end

endmodule