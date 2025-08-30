# Newspaper Vending Machine using Verilog

This project is a Verilog-based vending machine controller that simulates a simple newspaper dispenser. The machine accepts Rs.5 and Rs.10 coins, processes the total balance, and decides when to deliver a newspaper.

If a total of Rs.15 is reached, the machine dispenses one newspaper. If a customer inserts Rs.20 (two Rs.10 coins), the machine delivers the newspaper and returns Rs.5 change.

The design uses a finite state machine (FSM) to manage different balance states (Rs.0, Rs.5, Rs.10, Rs.15) and ensures correct vending and change return. This project demonstrates how digital logic and FSMs can be applied to create practical, real-world systems like vending machines.

## Project Files

* `Vending_machine.v` - Main Verilog code for vending machine functionality.
* `TB_Vending_Machine.v` - Testbench to simulate and verify the design.
* `LICENSE` - MIT License.

## Features

* Accepts Rs.5 and Rs.10 coins.
* Dispenses newspaper when balance reaches Rs.15.
* Returns Rs.5 change if Rs.20 is inserted.
* Implemented using Finite State Machine (FSM).

## Hardware Required

* FPGA Board (like Artix-7)
* Basic peripherals for testing (optional LEDs, switches)

## Getting Started

1. Clone the repository using:

   ```bash
   git clone git@github.com:Jithendranath777/Newspaper_Vending_Machine_using_Verilog.git
   ```
2. Open the project in your preferred Verilog simulation software (Vivado recommended).
3. Simulate using `TB_Vending_Machine.v` to verify behavior.

## Author

**Angam Jithendranath**

* LinkedIn: [https://www.linkedin.com/in/jithendranath](https://www.linkedin.com/in/jithendranath)
* GitHub: [https://github.com/Jithendranath777](https://github.com/Jithendranath777)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
