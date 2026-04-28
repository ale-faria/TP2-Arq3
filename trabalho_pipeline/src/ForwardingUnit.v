module ForwardingUnit (
    input  [4:0] idex_rs1,
    input  [4:0] idex_rs2,

    input  [4:0] exmem_rd,
    input        exmem_regwrite,
    input  [6:0] exmem_op,

    input  [4:0] memwb_rd,
    input        memwb_regwrite,
    input  [6:0] memwb_op,

    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

    always @(*) begin
        // Padrão: sem forwarding
        forwardA = 2'b00;
        forwardB = 2'b00;

        // Prioridade 1: dado mais recente vindo de EX/MEM
        if (exmem_regwrite && (exmem_rd != 5'd0) && (exmem_rd == idex_rs1)) begin
            forwardA = 2'b10;
        end
        else if (memwb_regwrite && (memwb_rd != 5'd0) && (memwb_rd == idex_rs1)) begin
            forwardA = 2'b01;
        end

        // Prioridade 1: dado mais recente vindo de EX/MEM
        if (exmem_regwrite && (exmem_rd != 5'd0) && (exmem_rd == idex_rs2)) begin
            forwardB = 2'b10;
        end
        else if (memwb_regwrite && (memwb_rd != 5'd0) && (memwb_rd == idex_rs2)) begin
            forwardB = 2'b01;
        end
    end

endmodule