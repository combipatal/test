module JK_FF (
    input J,
    input K,
    input C,
    output reg Q,
    output Qb
);
assign Qb = ~Q;

always @(posedge C) begin 
    case ({J,K})
        2'b00 : Q <= Q; 
        2'b01 : Q <= 0;
        2'b10 : Q <= 1;
        2'b11 : Q <= ~Q;
        default : Q <= Q;
    endcase
end
endmodule

module D_FF (
    input D,
    input C,

    output reg Q,
    output Qb
);
assign Qb = ~Q;

always @(posedge C) begin 
    Q <= D;
end

endmodule