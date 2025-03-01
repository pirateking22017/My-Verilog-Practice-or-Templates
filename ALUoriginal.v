module  alu[A,B,ALUcontrol, Result, Z,N,V,C]
    //input decl
    input [31:0] A,B;
    input [2:0] ALUcontrol;

    //output decl
    output  [31:0] Result;
    output Z,N,V,C;
    //wire decl
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] mux_1; 
    wire [31:0] sum;
    wire [31:0] mux_2;
    wire [31:0] slt;
    wire cout;
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
    assign {cout,sum} = A + mux_1 + ALUcontrol[0];
    //zerio extension
    assign slt = {31'b00000000000000000000000000000000,sum[31]};
    //mux
    assign mux_2 = (ALUcontrol[2:0] == 2'b000) ? sum :
                    (ALUcontrol[2:0] == 2'b001) ? sum :
                    (ALUcontrol[2:0] == 2'b010) ? a_and_b :
                    (ALUcontrol[2:0] == 2'b011) ? a_or_b :
                    (ALUcontrol[2:0] == 2'b101) ? slt : 32'h00000000;


    assign Result = mux_2;

    //flags implementation
    assign Z = &(~Result); //zeroFlag
    assign N = Result[31]; //negativeFlag
    assign V = (~ALUcontrol[1]) & (A[31]^sum[31]) & (~(A[31] ^ B[31] ^ ALUcontrol[0])) //overflowFlag
    assign C = cout & (~ALUcontrol[1]); //carry flag

endmodule

