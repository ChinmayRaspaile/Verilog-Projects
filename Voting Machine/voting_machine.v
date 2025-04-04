`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 13:35:28
// Design Name: 
// Module Name: voting_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module voting_machine (
    input clk,
    input rst,
    input start,
    input submit,
    input [1:0] voter_id,
    input [7:0] password,
    input [1:0] vote, // candidate selection
    output reg vote_done,
    output reg invalid_login,
    output reg already_voted,
    output reg [3:0] vote_count0, // candidate 0
    output reg [3:0] vote_count1, // candidate 1
    output reg [3:0] vote_count2  // candidate 2
);

    // Parameters for FSM states
    parameter IDLE = 2'b00, AUTH = 2'b01, VOTE = 2'b10, DONE = 2'b11;

    reg [1:0] state;

    // Registered passwords for 4 voters
    reg [7:0] passwords [0:3];
    reg voted [0:3]; // to check if voter has voted

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            passwords[0] <= 8'hA5;
            passwords[1] <= 8'h3C;
            passwords[2] <= 8'h7E;
            passwords[3] <= 8'h55;

            for (i = 0; i < 4; i = i + 1)
                voted[i] <= 0;

            vote_count0 <= 0;
            vote_count1 <= 0;
            vote_count2 <= 0;

            vote_done <= 0;
            invalid_login <= 0;
            already_voted <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    vote_done <= 0;
                    invalid_login <= 0;
                    already_voted <= 0;
                    if (start)
                        state <= AUTH;
                end

                AUTH: begin
                    if (password == passwords[voter_id]) begin
                        if (voted[voter_id]) begin
                            already_voted <= 1;
                            state <= DONE;
                        end else begin
                            state <= VOTE;
                        end
                    end else begin
                        invalid_login <= 1;
                        state <= DONE;
                    end
                end

                VOTE: begin
                    if (submit) begin
                        voted[voter_id] <= 1;
                        case (vote)
                            2'b00: vote_count0 <= vote_count0 + 1;
                            2'b01: vote_count1 <= vote_count1 + 1;
                            2'b10: vote_count2 <= vote_count2 + 1;
                        endcase
                        vote_done <= 1;
                        state <= DONE;
                    end
                end

                DONE: begin
                    if (!start)
                        state <= IDLE;
                end
            endcase
        end
    end
endmodule

