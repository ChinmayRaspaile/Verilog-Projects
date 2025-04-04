# Password-Protected Voting Machine (Verilog)

## Overview
This project implements a password-protected voting machine using **pure Verilog-2001**, designed to simulate on a PC without external hardware. It models a real-life secure voting system where each voter must authenticate using a password and is allowed to vote only once.

## Features
- Supports 4 voters (IDs: 0 to 3), each with a unique 8-bit password.
- Supports voting for 3 candidates (candidate codes: 00, 01, 10).
- Prevents double voting by the same voter.
- Detects and flags invalid password attempts.
- Displays individual vote counts per candidate.

## Simulation Setup
Simulation is run using Vivado with a testbench that models the following actions:

1. **Voter 0** votes for candidate 0 with the correct password.
2. **Voter 1** tries to vote with a wrong password — access denied.
3. **Voter 2** votes for candidate 2 with the correct password.
4. **Voter 0** tries to vote again — blocked due to already voting.

## Simulation Output Analysis
Here is the simulation output in a properly formatted table:

| Time (ns) | Voter ID | vote_done | invalid_login | already_voted | vote_count0 | vote_count1 | vote_count2 |
|-----------|----------|------------|----------------|----------------|--------------|--------------|--------------|
| 15000     | 0        | 0          | 0              | 0              | 0            | 0            | 0            |
| 35000     | 0        | 1          | 0              | 0              | 1            | 0            | 0            |
| 65000     | 1        | 0          | 0              | 0              | 1            | 0            | 0            |
| 75000     | 1        | 0          | 1              | 0              | 1            | 0            | 0            |
| 115000    | 2        | 0          | 0              | 0              | 1            | 0            | 0            |
| 135000    | 2        | 1          | 0              | 0              | 1            | 0            | 1            |
| 165000    | 0        | 0          | 0              | 0              | 1            | 0            | 1            |
| 175000    | 0        | 0          | 0              | 1              | 1            | 0            | 1            |

### Output Signal Meaning
- **vote_done**: High (`1`) when a valid vote is submitted.
- **invalid_login**: High (`1`) when a password doesn't match.
- **already_voted**: High (`1`) if the voter has already voted.
- **vote_countX**: Total votes each candidate has received.

### Final Result
- Candidate 0: 1 vote (from Voter 0)
- Candidate 1: 0 votes
- Candidate 2: 1 vote (from Voter 2)

All login rules and restrictions worked as expected.

## Tools Used
- Vivado 2016.4 (or later)
- Verilog (RTL and testbench)

## Next Steps (Optional Enhancements)
- Add a winner detection logic.
- Display results on 7-segment display (simulated).
- Use file-based input/output for batch voting.
- Add more voters and candidates.

---

**Simulation complete. Voting system secure.**

**Happy Coding! 🚀**


