module traffic_signal_countdown #(
    parameter integer CLK_FREQ = 50_000_000,
    parameter integer GREEN_TIME = 10,
    parameter integer YELLOW_TIME = 4
)(
    input logic clk,
    input logic reset,

    output logic ns_red,
    output logic ns_yellow,
    output logic ns_green,

    output logic ew_red,
    output logic ew_yellow,
    output logic ew_green,

    output logic [6:0] seg
);

    typedef enum logic [1:0] {
        NS_GREEN,
        NS_YELLOW,
        EW_GREEN,
        EW_YELLOW
    } state_t;

    state_t current_state;
    state_t next_state;

    integer clock_count;
    integer countdown;

    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            current_state <= NS_GREEN;
            clock_count <= 0;
            countdown <= GREEN_TIME - 1;
        end
        else
        begin
            if (clock_count == CLK_FREQ - 1)
            begin
                clock_count <= 0;

                if (countdown == 0)
                begin
                    current_state <= next_state;

                    if (next_state == NS_GREEN)
                        countdown <= GREEN_TIME - 1;

                    else if (next_state == NS_YELLOW)
                        countdown <= YELLOW_TIME - 1;

                    else if (next_state == EW_GREEN)
                        countdown <= GREEN_TIME - 1;

                    else
                        countdown <= YELLOW_TIME - 1;
                end
                else
                begin
                    countdown <= countdown - 1;
                end
            end
            else
            begin
                clock_count <= clock_count + 1;
            end
        end
    end

    always_comb
    begin
        next_state = current_state;

        case (current_state)

            NS_GREEN:
            begin
                if (countdown == 0)
                    next_state = NS_YELLOW;
            end

            NS_YELLOW:
            begin
                if (countdown == 0)
                    next_state = EW_GREEN;
            end

            EW_GREEN:
            begin
                if (countdown == 0)
                    next_state = EW_YELLOW;
            end

            EW_YELLOW:
            begin
                if (countdown == 0)
                    next_state = NS_GREEN;
            end

            default:
            begin
                next_state = NS_GREEN;
            end

        endcase
    end

    always_comb
    begin
        ns_red = 0;
        ns_yellow = 0;
        ns_green = 0;

        ew_red = 0;
        ew_yellow = 0;
        ew_green = 0;

        case (current_state)

            NS_GREEN:
            begin
                ns_green = 1;
                ew_red = 1;
            end

            NS_YELLOW:
            begin
                ns_yellow = 1;
                ew_red = 1;
            end

            EW_GREEN:
            begin
                ns_red = 1;
                ew_green = 1;
            end

            EW_YELLOW:
            begin
                ns_red = 1;
                ew_yellow = 1;
            end

            default:
            begin
                ns_red = 1;
                ew_red = 1;
            end

        endcase
    end

    always_comb
    begin
        case (countdown)

            0:
                seg = 7'b1000000;

            1:
                seg = 7'b1111001;

            2:
                seg = 7'b0100100;

            3:
                seg = 7'b0110000;

            4:
                seg = 7'b0011001;

            5:
                seg = 7'b0010010;

            6:
                seg = 7'b0000010;

            7:
                seg = 7'b1111000;

            8:
                seg = 7'b0000000;

            9:
                seg = 7'b0010000;

            default:
                seg = 7'b1111111;

        endcase
    end

endmodule
