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