`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 13:39:29
// Design Name: 
// Module Name: tb_voting_machine
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


module tb_voting_machine;

    reg clk, rst;
    reg start, submit;
    reg [1:0] voter_id;
    reg [7:0] password;
    reg [1:0] vote;

    wire vote_done, invalid_login, already_voted;
    wire [3:0] vote_count0, vote_count1, vote_count2;

    voting_machine uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .submit(submit),
        .voter_id(voter_id),
        .password(password),
        .vote(vote),
        .vote_done(vote_done),
        .invalid_login(invalid_login),
        .already_voted(already_voted),
        .vote_count0(vote_count0),
        .vote_count1(vote_count1),
        .vote_count2(vote_count2)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Time\tID\tDone\tInvalid\tVoted\tCount0\tCount1\tCount2");
        $monitor("%0t\t%0d\t%b\t%b\t%b\t%0d\t%0d\t%0d", 
                 $time, voter_id, vote_done, invalid_login, already_voted,
                 vote_count0, vote_count1, vote_count2);

        // Reset
        rst = 1; start = 0; submit = 0; #15;
        rst = 0;

        // Voter 0 correct vote for candidate 0
        login_vote(2'b00, 8'hA5, 2'b00);

        // Voter 1 wrong password
        login_vote(2'b01, 8'h00, 2'b01);

        // Voter 2 correct vote for candidate 2
        login_vote(2'b10, 8'h7E, 2'b10);

        // Voter 0 tries again
        login_vote(2'b00, 8'hA5, 2'b01);

        #50 $finish;
    end

    task login_vote;
        input [1:0] id;
        input [7:0] pass;
        input [1:0] v;
        begin
            voter_id = id;
            password = pass;
            vote = v;
            start = 1; #10;
            start = 0; #10;
            submit = 1; #10;
            submit = 0; #20;
        end
    endtask

endmodule

