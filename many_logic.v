//A가 3의 배수인 경우 F=1, 아니라면 F=0
module multi_3 ( 
    input[3:0] A,
    output F 
);

assign F = ~(A % 3);
endmodule

module U2 (
    input [15:0] A,
    output reg F
);
//1,3,5,7,9,11,13,15 비트에 1이 홀수개 있다면 F = 1, 아니면 F = 0
    integer i;
    reg [3:0] count;
    always @(*)begin
        count = 0;
        for (i = 1; i < 16 ; i = i+2) begin
            if(A[i]) count = count + 1;
        end
        
        if (count % 2) F = 1;
        else F = 0;  

    end
endmodule

//010 비트열이 하나라도 잇으면 F=1, 아니면 F=0
module u3 (
    input [7:0] A,
    output reg F
);
    integer i;
    reg found;
    always @(*) begin
        found = 0;
        for(i = 0; i < 6; i = i+1)begin //6번만 반복
           if(A[i+2:i] == 3'b010) found = 1;
        end
        F = found;
    end
endmodule 

//16비트 입력A 에서 0의 개수가 짝수 (0포함)이면 x = 1, 아니면 x=0
//16비트 입력A 에서 0의 개수가 3의 배수(0포함)이면 y=1, 아니면 y=0

module count (
    input [15:0] A,
    output reg X,
    output reg Y
);
integer i;
reg [5:0] count;
always @(*) begin 
    //일단 0의 개수를 카운트
    count = 0; 
    for (i = 0; i< 16; i = i+1) 
        if(!A[i]) count = count + 1;

    if(count % 2) x = 0;
    else x = 1;
    
    if((count % 3) == 0) y = 1;
    else y = 0;
end
endmodule 

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
    if (A <= 4'b1001)begin 
        B[7:4] = 4'b0000;
        B[3:0] = A; 
    end else begin
        B[7:4] = 4'b0001;
        B[3:0] = A - 4'd10;
    end
end
endmodule