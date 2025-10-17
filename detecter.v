module detecter (
    input   [15:0]  din_bit,
    input   reset,
    input   clk,
    output  reg [15:0]  detect_out
);

reg [2:0]   state,next_state;
reg [3:0]   count;
reg [15:0]  detect_out_temp;
//fsm 으로 설계s
parameter start = 3'b000;
parameter st1   = 3'b001;
parameter st2   = 3'b010;
parameter st3   = 3'b011;
parameter st4   = 3'b100;

initial begin
    count <= 4'd15;
end

always @(*) begin
        case (state)
        start : if(din_bit[count]==0) next_state = st1; // 0
                else next_state = start;                //1

        st1 :   if(din_bit[count]==1) next_state = st2; // 01 
                else next_state = st1;                  // 00

        st2 :   if(din_bit[count]==1) next_state = st3; // 011
                else next_state =st1;                   // 010

        st3 :   if(din_bit[count]==0) begin             // 0110
                    next_state = st4;
                    detect_out_temp[count] = 1'b1;
                end else next_state = start;            // 0111

        st4 :   if(din_bit[count]==0) next_state = st1; //01100
                else next_state = st2;                  //01101
                
        default next_state = start; 
        endcase
end

always @(posedge clk or posedge reset) begin 
    if (reset) begin 
        state <= start;
        count <= 15;
        detect_out_temp = 0;
        next_state = start;
        detect_out <= 0;

    end else if (count > 0) begin
        count <= count - 1'b1;
        state <= next_state;
    end else
        detect_out <= detect_out_temp;
end

endmodule