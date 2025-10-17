`timescale 1ns / 1ps  // 시간단위: 1ns, 정밀도: 1ps

module tb_detecter;

reg din_bit;
reg reset;
reg clk;
wire detect_out;  

deteter_shift U1(
    .din_bit(din_bit),
    .reset(reset),
    .clk(clk),
    .detect_out(detect_out)
);

// 클럭 생성
initial begin
    clk = 0;
    forever #10 clk = ~clk;  // 20ns 주기 클럭 (10ns마다 토글)
end

// 초기화 및 테스트 시퀀스
initial begin
    // 초기값 설정
    reset = 1;
    din_bit = 0;
    // Reset 해제
    #25 reset = 0; din_bit = 0;
    #20 din_bit = 1;
    #20 din_bit = 0;
    #20 din_bit = 1;
    #20 din_bit = 1;
    #20 din_bit = 0;
    #20 din_bit = 0;
    #20 din_bit = 1;
    #20 din_bit = 0;
    #20 din_bit = 0;
    #20 din_bit = 1;
    #20 din_bit = 1;
    #20 din_bit = 0;
    #20 din_bit = 1;
    #20 din_bit = 1;
    #20 din_bit = 0;
end

initial begin
    #370 $finish;
end

// 모니터링 (posedge clk에서만, $strobe로 최종값 출력)
always @(posedge clk) begin
    $strobe("Time=%0t reset=%b din_bit=%b detect_out=%b", 
            $time, reset, din_bit, detect_out);
end

endmodule
