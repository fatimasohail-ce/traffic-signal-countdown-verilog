`timescale 1ns/1ps

module tb_traffic_signal;

    logic clk;
    logic reset;

    logic ns_red;
    logic ns_yellow;
    logic ns_green;

    logic ew_red;
    logic ew_yellow;
    logic ew_green;

    logic [6:0] seg;

    initial
    begin
        clk = 0;
        forever
            #5 clk = ~clk;
    end

    traffic_signal_countdown #(
        .CLK_FREQ(10),
        .GREEN_TIME(10),
        .YELLOW_TIME(4)
    )
    dut
    (
        .clk(clk),
        .reset(reset),

        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),

        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green),

        .seg(seg)
    );

    initial
    begin
        $dumpfile("traffic_signal.vcd");
        $dumpvars(0, tb_traffic_signal);

        reset = 1;

        #20;

        reset = 0;

        #3000;

        reset = 1;

        #20;

        reset = 0;

        #500;

        $finish;
    end

    always @(posedge clk)
    begin
        $display(
            "Time = %0t | State = %0d | Countdown = %0d | NS: R=%b Y=%b G=%b | EW: R=%b Y=%b G=%b",
            $time,
            dut.current_state,
            dut.countdown,
            ns_red,
            ns_yellow,
            ns_green,
            ew_red,
            ew_yellow,
            ew_green
        );
    end

endmodule