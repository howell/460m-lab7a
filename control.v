module control;

    `define DR_SELECT_INSTRUCTION_20_16 0
    `define DR_SELECT_INSTRUCTION_15_11 1

    `define REG_W_READ 0
    `define REG_W_WRITE 1

    `define MUX_2_SELECT_REG 0
    `define MUX_2_SELECT_IMM 1

    `define ALU_OP_SELECT 1

    `define MUX_3_SELECT_ALU 0
    `define MUX_3_SELECT_MEM 1

    `define PC_SELECT_PC_JUMP 0
    `define PC_SELECT_PC_ADD_4 1
    `define PC_SELECT_PC_BRANCH 2
    `define PC_SELECT_PC_JR 3


endmodule /* control */
