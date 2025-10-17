module deteter_shift(
    input           din_bit,
    input           clk,
    input           reset,

    output reg      detect_out
);

reg [2:0] state, next_state;
parameter start = 3'b000;
parameter st1   = 3'b001;
parameter st2   = 3'b010;
parameter st3   = 3'b011;
parameter st4   = 3'b100;

always @(*) begin
    case (state)
    start   :   next_state = din_bit ? start : st1; // 1 / '0'
    st1     :   next_state = din_bit ? st2 : st1;   //'01' / 00
    st2     :   next_state = din_bit ? st3 : st1;   //'011'/010
    st3     :   next_state = din_bit ? start : st4; // 0111/'0110'
    st4     :   next_state = din_bit ? st2 : st1;   //'01101'/01100    
    default :   next_state = start;
    endcase 
end

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= start;
        next_state <= start;
        detect_out <= 0;
    end else begin
        state <= next_state;    
        detect_out <= (next_state == st4 && state == st3);
    end
end
endmodule  