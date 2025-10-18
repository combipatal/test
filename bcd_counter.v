module bcd_counter (
    input   clk,
    input   rst,

    output  reg [3:0]   cnt
);

always@(posedge clk or posedge rst) begin 

    if (rst) begin 
        cnt <= 0;
    end else begin 
        if (cnt == 4'd9) cnt <= 0;       // 9가 몇 비트지 4'1001
        else cnt <= cnt+ 1'b1;
    end
end
endmodule

