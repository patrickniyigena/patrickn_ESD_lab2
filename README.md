# patrickn_ESD_lab2
# Lab 1 Part Two: Assembly Language Traffic Light Controller

## Project Overview
This project implements a Traffic Light Controller using the PIC16F877A microcontroller. The program is written in Assembly Language (using the XC8 `pic-as` toolchain) and simulates a standard traffic light sequence (Red -> Yellow -> Green -> Yellow) using LEDs connected to PORTB.

**Course:** 04-633 A: Embedded Systems Development  
**Institution:** Carnegie Mellon University Africa  
**Author:** Patrick Niyigena  

## Hardware Requirements
* **Microcontroller:** PIC16F877A
* **Clock:** 16MHz Crystal Oscillator (HS Mode)
* **Outputs:**
    * **Red LED:** Connected to pin **RB0** (Pin 33)
    * **Yellow LED:** Connected to pin **RB1** (Pin 34)
    * **Green LED:** Connected to pin **RB2** (Pin 35)
* **Circuit:** Standard LED connections with current-limiting resistors (220Ω-330Ω).

## Software & Toolchain
* **IDE:** MPLAB X
* **Compiler:** XC8 (v2.35+) using the `pic-as` assembler.
* **Simulation:** Proteus Design Suite.

## Technical Implementation Details
The code handles the traffic light timing using nested delay loops calibrated for a 16MHz clock cycle.

### Linker Compatibility Notes
To ensure compatibility with the modern XC8 Linker while writing pure assembly, this project includes specific `PSECT` directives (Dummy Sections) such as `functab`, `init`, and `intentry`. These allow the code to build successfully without linking standard C startup files, preventing "Undefined Section" errors during compilation.

## How to Build and Run
1.  **Open** the project in MPLAB X.
2.  **Clean and Build** to generate the `.hex` file.
    * *Note:* The project properties are set to "Do not link startup module" and "Link in C Library: None".
3.  **Load** the generated `.hex` file into the PIC16F877A component in Proteus.
4.  **Set Frequency** of the PIC component in Proteus to **16MHz**.
5.  **Run Simulation** to observe the sequence:
    * Red: ~5 Seconds
    * Yellow: ~2 Seconds
    * Green: ~5 Seconds

## Repository Contents
* `traffic.asm` - The main assembly source code.
* `Traffic_Light_Sim.pdsprj` - Proteus simulation file.
* `README.md` - Project documentation.
