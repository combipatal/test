// 8번 문제 

module mem (
    input W,
    input [15:0] A,
    input [15:0] DI,
    output reg [7:0] DOU,
    output reg [7:0] DOL
);

reg [15:0] mc   [65535:0];
/* 메모리 크기는 65536 memory words
 W가 1이면 mem 내부의 array 셀인 mc에서
 A값을 지정하는 mc[A] 에 DI 값이 저장 
 그값이 동시에 DOU, DOL로 출력되는데
 상위 8비트는 DOU, 하위 8비트는 DOL로 출력
*/

//W가 0이면 상위 8비트는 DOU, 하위 8비트는 DOL로 출력
always @(*) begin
    if (W) begin    // write
        mc[A] = DI;
        {DOU,DOL} = DI;
    end else begin //read
        {DOU,DOL} = mc[A];
    end
end

endmodule


