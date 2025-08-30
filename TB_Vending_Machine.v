`timescale 1ns/1ps
module TB_Vending_Machine;

    reg clk, reset;
    reg [1:0] coin;
    wire newspaper, change_5;

    Vending_machine uut(
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .newspaper(newspaper),
        .change_5(change_5)
    );

    // clock
    initial clk = 0;
    always #5 clk = ~clk;

    task do_reset;
    begin
        reset = 1; coin = 2'b00;
        #10; // hold one clock
        reset = 0;
    end
    endtask

    initial begin
        $dumpfile("vending.vcd");
        $dumpvars(0, TB_Vending_Machine);

        // Test1: 5 only -> no newspaper
        do_reset;
        coin = 2'b01; #10; coin = 2'b00; #20;
        $display("T1: coin=5 -> newspaper=%b change=%b", newspaper, change_5);

        // Test2: 10 only -> no newspaper
        do_reset;
        coin = 2'b10; #10; coin = 2'b00; #20;
        $display("T2: coin=10 -> newspaper=%b change=%b", newspaper, change_5);

        // Test3: 5 + 5 -> 10 -> no newspaper
        do_reset;
        coin = 2'b01; #10; coin = 2'b00; #10;
        coin = 2'b01; #10; coin = 2'b00; #20;
        $display("T3: 5+5 -> newspaper=%b change=%b", newspaper, change_5);

        // Test4: 10 + 5 -> 15 -> newspaper, no change
        do_reset;
        coin = 2'b10; #10; coin = 2'b00; #10;
        coin = 2'b01; #10; coin = 2'b00; #20;
        $display("T4: 10+5 -> newspaper=%b change=%b", newspaper, change_5);

        // Test5: 10 + 10 -> 20 -> newspaper + change_5
        do_reset;
        coin = 2'b10; #10; coin = 2'b00; #10;
        coin = 2'b10; #10; coin = 2'b00; #20;
        $display("T5: 10+10 -> newspaper=%b change=%b", newspaper, change_5);

        // Test6: 5+5+5 -> 15 -> newspaper
        do_reset;
        coin = 2'b01; #10; coin = 2'b00; #10;
        coin = 2'b01; #10; coin = 2'b00; #10;
        coin = 2'b01; #10; coin = 2'b00; #20;
        $display("T6: 5+5+5 -> newspaper=%b change=%b", newspaper, change_5);

        #50 $finish;
    end

endmodule
