
// 6번

module alu (
    output reg [7:0] F,
    input [7:0] A,
    input [7:0] B,
    input [4:0] S
);
    
    always @* begin
        casez (S)
            // Shift Operations (S[4]=0, S[3:2]=00/01)
            5'b000?? : F = A << S[1:0];           // Shift Left
            5'b001?? : F = A >> S[1:0];           // Shift Right
            
            // Rotate Left (S[4]=0, S[3:2]=10)
            5'b01000 : F = A;                     // 0회 회전
            5'b01001 : F = {A[6:0], A[7]};       // 1회 좌회전
            5'b01010 : F = {A[5:0], A[7:6]};     // 2회 좌회전
            5'b01011 : F = {A[4:0], A[7:5]};     // 3회 좌회전
            
            // Rotate Right (S[4]=0, S[3:2]=11)
            5'b01100 : F = A;                     // 0회 회전
            5'b01101 : F = {A[0], A[7:1]};       // 1회 우회전
            5'b01110 : F = {A[1:0], A[7:2]};     // 2회 우회전
            5'b01111 : F = {A[2:0], A[7:3]};     // 3회 우회전
            
            // Reset (S[4:3]=10)
            5'b1000? : F = 0;
            5'b1001? : F = 8'd255;

            // Arithmetic/Logic (S[4:3]=11)
            5'b10100 : F = A;                     // Transfer
            5'b10101 : F = B;
            5'b10110 : F = -A;
            5'b10111 : F = -B;
            5'b11000 : F = A+B;
            5'b11001 : F = A-B;
            5'b11010 : F = A|B;
            5'b11011 : F = A&B;
            5'b11100 : F = ~(A|B);
            5'b11101 : F = ~(A&B);
            5'b11110 : F = ~A;
            5'b11111 : F = ~B;
            default  : F = 8'b0;                 
        endcase
    end
endmodule
// -------------------------------------------------------//

module alu (
    output reg [7:0] F,

    input [7:0] A,
    input [7:0] B,
    input [4:0] S
    );
    
    always @* begin
        if (S[4] == 1'b0) begin
            case (S[3:2]) 
                2'b00 : F = A << (S[1:0]);      // Shift Left
                2'b01 : F = A >> (S[1:0]);      // Shift Right
                2'b10 : case(S[1:0])                   // Rotate Left
                            2'b00: F = A;                           // 0회 회전
                            2'b01: F = {A[6:0], A[7]};             // 1회 좌회전
                            2'b10: F = {A[5:0], A[7:6]};           // 2회 좌회전
                            2'b11: F = {A[4:0], A[7:5]};           // 3회 좌회전
                        endcase                 
                2'b11 : case(S[1:0])                                  //Rotate Right
                            2'b00: F = A;                           // 0회 회전
                            2'b01: F = {A[0], A[7:1]};             // 1회 우회전
                            2'b10: F = {A[1:0], A[7:2]};           // 2회 우회전
                            2'b11: F = {A[2:0], A[7:3]};           // 3회 우회전
                        endcase
            endcase 
        end else begin
            if (S[3] == 1'b0)  F = 0; 
            else
                case (S[2:0]) 
                    3'b000 : F = A;
                    3'b001 : F = A+B;
                    3'b010 : F = A-B;
                    3'b011 : F = -A;
                    3'b100 : F = A|B;
                    3'b101 : F = A&B;
                    3'b110 : F = A^B;
                    3'b111 : F = ~A;
                endcase
        end
    end
endmodule