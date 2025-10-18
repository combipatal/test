module adder (
    input A,
    input B,
    input CI,
    output S,
    output CO
);

assign {CO, S} = A + B + CI;

endmodule



module adder4 (
    input [3:0] A,
    input [3:0] B,
    input CI,
    output [3:0] S,
    output CO
);

wire [2:0] CO_temp;

adder u1 (.A(A[0]), .B(B[0]), .CI(CI), .S(S[0]), .CO(CO_temp[0]));
adder u2 (.A(A[1]), .B(B[1]), .CI(CO_temp[0]), .S(S[1]), .CO(CO_temp[1]));
adder u3 (.A(A[2]), .B(B[2]), .CI(CO_temp[1]), .S(S[2]), .CO(CO_temp[2]));
adder u4 (.A(A[3]), .B(B[3]), .CI(CO_temp[2]), .S(S[3]), .CO(CO));

endmodule