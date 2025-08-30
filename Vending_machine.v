`timescale 1ns / 1ps
module Vending_machine(
    input clk,
    input reset,
    input [1:0] coin,       // 00 = no coin, 01 = Rs.5, 10 = Rs.10
    output reg newspaper,   // 1 newspaper delivered (one cycle)
    output reg change_5     // return Rs.5 change (one cycle)
);

    reg [1:0] state, next_state;
    reg change_pending, change_pending_next;

    // States (2-bit)
    parameter S0  = 2'b00;  // Rs.0
    parameter S5  = 2'b01;  // Rs.5
    parameter S10 = 2'b10;  // Rs.10
    parameter S15 = 2'b11;  // Rs.15 or more (dispense)

    // Sequential: update state and change_pending
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            change_pending <= 1'b0;
        end else begin
            state <= next_state;
            change_pending <= change_pending_next;
        end
    end

    // Combinational: compute next_state and whether change should be pending
    always @(*) begin
        // defaults
        next_state = state;
        change_pending_next = 1'b0;

        case (state)
            S0: begin
                case (coin)
                    2'b01: next_state = S5;   // insert 5
                    2'b10: next_state = S10;  // insert 10
                    default: next_state = S0;
                endcase
            end

            S5: begin
                case (coin)
                    2'b01: next_state = S10;  // 5 + 5 = 10
                    2'b10: next_state = S15;  // 5 + 10 = 15 (exact)
                    default: next_state = S5;
                endcase
            end

            S10: begin
                case (coin)
                    2'b01:
                        next_state = S15;      // 10 + 5 = 15
                    
                   
                    2'b10: begin
                        next_state = S15;      // 10 + 10 = 20 -> vend + change
                        change_pending_next = 1'b1; // mark that 5rs change should be returned
                    end
                    default: next_state = S10;
                endcase
            end

            S15: begin
                // dispense (handled in output logic), then return to idle
                next_state = S0;
                change_pending_next = 1'b0; // clear pending by default
            end

            default: begin
                next_state = S0;
                change_pending_next = 1'b0;
            end
        endcase
    end

    // Combinational outputs (Moore-style: depend on current state + latched change_pending)
    always @(*) begin
        newspaper = 1'b0;
        change_5  = 1'b0;
        if (state == S15) begin
            newspaper = 1'b1;
            change_5  = change_pending; // assert change only if it was pending when we transitioned
        end
    end

endmodule
