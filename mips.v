module MIPS(CLK, RST, CS, WE, Address, Mem_Bus);

    input CLK, RST;

    output CS, WE;
    output [31:0] Address;

    inout [31:0] Mem_Bus;

    wire [31:0] wPC, wInstruction, wSR1_Data, wSR2_Data, wALU_Out, wMux2_Out,
                 wMux3_Out, wMux4_Out, wMem_Out, wPC_Add_4, wPC_Branch, 
                 wPC_Jump;
    wire [4:0] wMux1_Out;
    reg  [31:0] rPC;
    reg [10:0] rMicrocode;

    `define MICROCODE_MUX_4_SELECT  10:9
    `define MICROCODE_MUX_3_SELECT  8
    `define MICROCODE_MUX_2_SELECT  7
    `define MICROCODE_MUX_1_SELECT  6
    `define MICROCODE_ALU_OP_SELECT 5:2
    `define MICROCODE_REG_W_SELECT  1 
    `define MICROCODE_DR_SELECT     0

    Memory instruction_memory(CS, WE, CLK, wPC, wInstruction);
    Memory data_memory(CS, WE, CLK, wALU_Out, wMem_Out);


    REG register_file(CLK, rMicrocode[`MICROCODE_REG_W_SELECT], wMux1_Out, 
    wInstruction[25:21], wInstruction[20:16], wMux3_Out, wSR1_Data, wSR2_Data);

    four_bit_two_input_mux mux1(wInstruction[20:16], wInstruction[15:11], 
        rMicrocode[`MICROCODE_MUX_1_SELECT], wMux1_Out);

    thirty_two_bit_two_input_mux mux2(wSR2_Data, {16'd0, wInstruction[15:0]}, 
        rMicrocode[`MICROCODE_MUX_2_SELECT], wMux2_Out);

    thirty_two_bit_two_input_mux mux3(wMem_Out, wALU_Out,
        rMicrocode[`MICROCODE_MUX_3_SELECT], wMux3_Out);

    thirty_two_bit_four_input_mux mux4(wPC_Jump, wPC_Add_4, wPC_Branch, 
            wSR1_Data, rMicrocode[`MICROCODE_MUX_4_SELECT], wMux4_Out);

    add_unit add(wPC, 32'd4, wPC_Add_4);

    add_unit adder(wPC_Add_4, {14'd0, wInstruction[15:0], 2'd0}, wPC_Branch);

    alu_unit alu(wSR1_Data, wMux2_Out, rMicrocode[`MICROCODE_ALU_OP_SELECT], 
                wALU_Out);

endmodule /* MIPS */

module add_unit(iAddendOne, iAddendTwo, oSum);

    input [31:0] iAddendOne, iAddendTwo;
    output [31:0] oSum;

    assign oSum = iAddendOne + iAddendTwo;

endmodule /* add_unit */

module four_bit_two_input_mux(iInputOne, iInputTwo, iMuxSelect, oMuxOut);
    
    input [4:0] iInputOne, iInputTwo;
    input iMuxSelect;

    output [4:0] oMuxOut;

    assign oMuxOut = (iMuxSelect) ? iInputTwo : iInputOne;

endmodule /* four_bit_two_input_mux */

module thirty_two_bit_two_input_mux(iInputOne, iInputTwo, iMuxSelect, oMuxOut);

    input [31:0] iInputOne, iInputTwo;
    input iMuxSelect;

    output [31:0] oMuxOut;

    assign oMuxOut = (iMuxSelect) ? iInputTwo : iInputOne;

endmodule /* thirty_two_bit_two_input_mux */

module thirty_two_bit_four_input_mux(iInputOne, iInputTwo, iInputThree, 
                                    iInputFour, iMuxSelect, oMuxOut);

    input [31:0] iInputOne, iInputTwo, iInputThree, iInputFour;
    input [1:0]  iMuxSelect;

    output [31:0] oMuxOut;

    assign oMuxOut = (iMuxSelect[1] ) ?
                    ((iMuxSelect[0]) ? iInputFour : iInputThree) :
                    ((iMuxSelect[0]) ? iInputTwo : iInputOne);

endmodule /* thirty_two_bit_four_input_mux */

