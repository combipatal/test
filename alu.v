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