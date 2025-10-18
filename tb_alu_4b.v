`timescale 1ns/1ps

module tb_alu_4b;

reg [3:0] op_a, op_b,inst;
wire  [3:0] alu_out;

    alu_4b u1 (
        .op_a(op_a),
        .op_b(op_b),
        .inst(inst),
        .alu_out(alu_out)
    );

    initial begin
        #10 op_a = 4'b0000;
            op_b = 4'b0000;
            inst = 4'b0000; 

        #20 op_a = 4'b0011;
            op_b = 4'b0110;
            inst = 4'b0010; // logic 비반전 , and
            // 4'b0010;
        #20 op_a = 4'b0110;
            op_b = 4'b1000;
            inst = 4'b1000; // arith , +
            // 4'b1110;
    end

    initial begin
        $monitor("op_a = %d, op_b = %d , %inst = %b , alu_out = %d",
                 op_a, op_b, inst, alu_out);
        #100 $finish;
    end
endmodule