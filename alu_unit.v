module alu_unit(iS1, iS2, iALU_Select, oResult);

    input [31:0] iS1, iS2;
    input [3:0] iALU_Select;

    output [31:0] oResult;

    reg [31:0] rResult;

    assign oResult = rResult;

           `define ALU_OP_ADD  0 
           `define ALU_OP_SUB  1
           `define ALU_OP_XOR  2
           `define ALU_OP_AND  3
           `define ALU_OP_OR   4
           `define ALU_OP_SLT  5
           `define ALU_OP_SHR  6
           `define ALU_OP_SHL  7
           `define ALU_OP_JR   8
           `define ALU_OP_BEQ  9
           `define ALU_OP_BNE 10

    always @(iS1, iS2, iALU_Select) begin
        case(iALU_Select)
           `ALU_OP_ADD: begin
                rResult <= iS1 + iS2;
           end
           `ALU_OP_SUB: begin
                rResult <= iS1 - iS2;
           end
           `ALU_OP_XOR: begin
                rResult <= iS1 ^ iS2;
           end
           `ALU_OP_AND: begin
                rResult <= iS1 & iS2;
           end
           `ALU_OP_OR: begin
                rResult <= iS1 | iS2;
           end
           `ALU_OP_SLT: begin
                rResult <= (iS1 < iS2) ? 0 : 1;
           end
           `ALU_OP_SHR: begin
                rResult <= iS1 >> iS2;
           end
           `ALU_OP_SHL: begin
                rResult <= iS1 << iS2;
           end
           `ALU_OP_JR: begin
                rResult <= iS1;
           end
           `ALU_OP_BEQ:begin
                rResult <= 1; // TODO
           end
           `ALU_OP_BNE: begin
                rResult <= 1; // TODO
           end
       endcase
   end /* always */

endmodule /* alu */
