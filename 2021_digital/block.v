module block (
    input I0,
    input I1,
    input S0,
    input S1,

    output reg O0,
    output reg O1
);

wire a,b,c;

assign a = S1 | I0;
assign b = S0 & I1;
assign c = a ^ b;
always @(*)begin 
    case ({S0,S1})
        2'b00   :begin O0 = c; O1 = a & b; end
        2'b01   :begin O0 = c; O1 = c;  end
        2'b10   :begin O0 = a | b; O1 = a & b; end
        2'b11   :begin O0 = a | b; O1 = c; end
    endcase
end
endmodule

module tb_block;

reg I0,I1,S0,S1;
wire O0,O1;

//16가지 경우의 수
initial begin
    #10 I0 = 0; I1 = 0; S0 = 0; S1 = 0;

    #20 I0 = 1; I1 = 0; S0 = 0; S1 = 0;
    #20 I0 = 0; I1 = 1; S0 = 0; S1 = 0;
    #20 I0 = 0; I1 = 0; S0 = 1; S1 = 0;
    #20 I0 = 0; I1 = 0; S0 = 0; S1 = 1;

    #20 I0 = 1; I1 = 1; S0 = 0; S1 = 0;
    #20 I0 = 1; I1 = 0; S0 = 1; S1 = 0;
    #20 I0 = 1; I1 = 0; S0 = 0; S1 = 1;
    #20 I0 = 0; I1 = 1; S0 = 1; S1 = 0;
    #20 I0 = 0; I1 = 1; S0 = 0; S1 = 1;
    #20 I0 = 0; I1 = 0; S0 = 1; S1 = 1;

    #20 I0 = 1; I1 = 1; S0 = 1; S1 = 0;
    #20 I0 = 1; I1 = 1; S0 = 0; S1 = 1;
    #20 I0 = 1; I1 = 0; S0 = 1; S1 = 1;
    #20 I0 = 0; I1 = 1; S0 = 1; S1 = 1;

    #20 I0 = 1; I1 = 1; S0 = 1; S1 = 1;
end

endmodule