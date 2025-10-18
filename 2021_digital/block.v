module block (
    input I0,
    input I1,
    input S0,
    input S1,

    output reg O0,
    output reg O1
);

wire a,b,c;

assign a = S1 | I0;
assign b = S0 & I1;
assign c = a ^ b;
always @(*)begin 
    case ({S0,S1})
        2'b00   :begin O0 = c; O1 = a & b; end
        2'b01   :begin O0 = c; O1 = c;  end
        2'b10   :begin O0 = a | b; O1 = a & b; end
        2'b11   :begin O0 = a | b; O1 = c; end
    endcase
end
endmodule

// 단순 테스트 벤치
module tb_block;
    
reg I0,I1,S0,S1;    
wire O0,O1;

block U1(.I0(I0),.I1(I1),
        .S0(S0),.S1(S1),
        .O0(O0),.O1(O1));

//16가지 경우의 수
initial begin
    #10 I0 = 0; I1 = 0; S0 = 0; S1 = 0;

    #20 I0 = 1; I1 = 0; S0 = 0; S1 = 0;
    #20 I0 = 0; I1 = 1; S0 = 0; S1 = 0;
    #20 I0 = 0; I1 = 0; S0 = 1; S1 = 0;
    #20 I0 = 0; I1 = 0; S0 = 0; S1 = 1;

    #20 I0 = 1; I1 = 1; S0 = 0; S1 = 0;
    #20 I0 = 1; I1 = 0; S0 = 1; S1 = 0;
    #20 I0 = 1; I1 = 0; S0 = 0; S1 = 1;
    #20 I0 = 0; I1 = 1; S0 = 1; S1 = 0;
    #20 I0 = 0; I1 = 1; S0 = 0; S1 = 1;
    #20 I0 = 0; I1 = 0; S0 = 1; S1 = 1;

    #20 I0 = 1; I1 = 1; S0 = 1; S1 = 0;
    #20 I0 = 1; I1 = 1; S0 = 0; S1 = 1;
    #20 I0 = 1; I1 = 0; S0 = 1; S1 = 1;
    #20 I0 = 0; I1 = 1; S0 = 1; S1 = 1;

    #20 I0 = 1; I1 = 1; S0 = 1; S1 = 1;
end

endmodule
// task 를 활용한 테스트 벤치
module tb_block1;

reg I0,I1,S0,S1;
reg O0,O1;

block U1(.I0(I0),.I1(I1),
        .S0(S0),.S1(S1),
        .O0(O0),.O1(O1));


task intask(input I0_temp,I1_temp,S0_temp,S1_temp);
    begin
        I0 = I0_temp;
        I1 = I1_temp;
        S0 = S0_temp;
        S1 = S1_temp;
    end
endtask

initial begin 

    #10 intask(0,0,0,0);
    #10 intask(1,0,0,0);
    #10 intask(0,1,0,0);
    #10 intask(0,0,1,0);
    #10 intask(0,0,0,1);
    #10 intask(1,1,0,0);
    #10 intask(1,0,1,0);
    #10 intask(1,0,0,1);
    #10 intask(0,1,1,0);
    #10 intask(0,1,0,1);
    #10 intask(0,0,1,1);
    #10 intask(1,1,1,0);
    #10 intask(1,1,0,1);
    #10 intask(1,0,1,1);
    #10 intask(0,1,1,1);
    #10 intask(1,1,1,1);
end

endmodule

// for 루프를 활용한 벤치

module tb_block2;
reg I0,I1,S0,S1;
reg O0,O1;

integer i;
block U1(.I0(I0),.I1(I1),
        .S0(S0),.S1(S1),
        .O0(O0),.O1(O1));


initial begin
    for(i = 0; i < 16; i = i+1) begin
        {I0,I1,S0,S1} = i[3:0];
        #10;
    end
    #10 $finish;
end


endmodule