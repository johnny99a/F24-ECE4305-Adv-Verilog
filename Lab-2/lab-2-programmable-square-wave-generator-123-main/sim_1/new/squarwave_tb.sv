`timescale 1ns / 1ps

module squarwave_tb;

    logic clk;
    logic [3:0] m;
    logic [3:0] n;
    logic square_wave;
    
    sqrwave_top dut (
        .clk(clk),
        .m(m),
        .n(n),
        .square_wave(square_wave)
       // .mn(mn)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
        m = 4'd3;
        n = 4'd2;
        #1000;
        m = 4'd4;
        n = 4'd5;
        #1000;
        
        $finish;
    end
    
    initial begin
        $monitor("Time: %0t | m: %0d | n: %0d | square_wave: %0b", $time, m, n, square_wave);
    end

endmodule
