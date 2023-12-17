module HZRD_Unit(input MemRead_EX, output PCSel, ENA, HZRDcontrol);

always_comb
begin
    if(MemRead_EX)
        begin
            PCSel = 1;
            ENA = 1;
            HZRDcontrol = 1;
        end
    else 
        begin
            PCSel = 0;
            ENA = 0;
            HZRDcontrol = 0;
        end
end

endmodule