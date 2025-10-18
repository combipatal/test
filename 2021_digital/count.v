// 4번
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

    if(count % 2 == 0) X = 1;
    else X = 0;
    if((count % 3) == 0) Y = 1;
    else Y = 0;
end
endmodule 
