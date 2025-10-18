// 3번

module clkgen (
    input S,
    output reg clk
);


// 이게 무슨 ㅈ같은 문제야 
// 주기가 40
always @(*) begin
    if (S == 1'b0) begin
        clk 
    end
end