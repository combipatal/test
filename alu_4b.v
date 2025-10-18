module alu_4b (
    input   [3:0]   op_a, 
    input   [3:0]   op_b,
    input   [3:0]   inst,

    output  reg [3:0]   alu_out
);

reg [3:0]   logic_out, arith_out;

// case inst[2:1] 으로 4가지 논리연산을 구현
// ?00?,?01?,?10?,?11?  zero, and, or ,xor
// inst[2:0] 

always @(*) begin
    case (inst[2:1])    
        2'b00 : logic_out = 0;              // ?00?
        2'b01 : logic_out = (op_a & op_b);  // ?01?
        2'b10 : logic_out = (op_a | op_b);  // ?10?
        2'b11 : logic_out = (op_a ^ op_b);  // ?11?
        default : logic_out = 0;
    endcase
    //6가지 산술연산..? + - * / % **
    case (inst[2:0])
        3'b000 : arith_out = op_a + op_b;   // ?000
        3'b001 : arith_out = op_a - op_b;   // ?001
        3'b010 : arith_out = op_a * op_b;   // ?010
        3'b011 : arith_out = op_a / op_b;   // ?011
        3'b100 : arith_out = op_a % op_b;   // ?100
        3'b101 : arith_out = op_a ** op_b;  // ?101
        default : arith_out = 0; 
    endcase 
    // inst[3] 으로 arith_out(1) 과 logic_out(0) 을 결정
    // inst[0] 으로 logic_out 의 반전(1)을 결정 
    alu_out = (inst[3] ? arith_out : (inst[0] ? !logic_out : logic_out));
end

endmodule