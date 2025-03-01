module  alu[A,B,ALUcontrol, Result]
    //input decl
    input [31:0] A,B;
    input [2:0] ALUcontrol;

    //output decl
    output  [31:0] Result;

    //wire decl
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] mux_1; 
    wire [31:0] sum;
    wire [31:0] mux_2;
    //logic design
    //and
    assign a_and_b = A & B;
    //or
    assign a_or_b = A | B;
    //not
    assign not_b = ~B;
    //ternary op
    assign mux_1 = (ALUcontrol[0]==1'b0)?B:not_b;
    //add-sub
    assign sum = A + mux_1 + ALUcontrol[0];
    //
    assign mux_2 = (ALUcontrol[1:0] == 2'b00) ? sum :
                    (ALUcontrol[1:0] == 2'b01) ? sum :
                    (ALUcontrol[1:0] == 2'b10) ? a_and_b :
                    a_or_b;

    assign Result = mux_2;
endmodule