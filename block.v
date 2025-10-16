module block (
    output reg O0,
    output reg O1,
    input I0,
    input I1,
    input S0,
    input S1
    );

    wire a,b;

    assign a = 1'b0;
    assign b = ~I1;

    always @* begin
        case({S0, S1})
            2'b00: begin O0 = a; O1 = a; end
            2'b01: begin O0 = a; O1 = b; end
            2'b10: begin O0 = b; O1 = a; end
            2'b11: begin O0 = b; O1 = b; end
        endcase
    end

endmodule

