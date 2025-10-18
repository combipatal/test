
//4bit binary number를 8비트 BCD code로 변환하는 conv 
// A의 값이 10진수 0~9라면 B의 상위 4비트는 4'b0000
// 하위 4비트는 A값의 2진수 코드가 된다.
// A의 값이 10진수 10-15라면 B의 상위 4비트는 4'b0001
// 하위 4비트는 A값 - 10의 2진수 코드가 된다.

module conv (
    input [3:0] A,
    output reg [7:0] B
);

always @(*) begin
    if (A <= 4'b1001)begin // 9 = 4'b1001
        B[7:4] = 4'b0000;
        B[3:0] = A; 
    end else begin
        B[7:4] = 4'b0001;
        B[3:0] = A - 4'd10;
    end
end
endmodule