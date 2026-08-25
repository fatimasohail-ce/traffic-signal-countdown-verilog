# Traffic Signal Countdown System

A Verilog-based traffic signal controller with a countdown display, implemented using a finite state machine (FSM) and simulated using a SystemVerilog testbench.

## Overview

This project implements a two-direction traffic signal system for North-South (NS) and East-West (EW) traffic.

The controller operates through four traffic-light states:

1. North-South Green
2. North-South Yellow
3. East-West Green
4. East-West Yellow

The system automatically transitions between these states while displaying the remaining countdown value on a 7-segment display.

## Features

- Four-state finite state machine (FSM)
- North-South and East-West traffic control
- Configurable green-light duration
- Configurable yellow-light duration
- Automatic state transitions
- 7-segment countdown display
- Asynchronous reset
- SystemVerilog implementation
- Simulation testbench
- VCD waveform generation
- Proteus simulation project

## Parameter configuration 
- parameter integer CLK_FREQ = 50_000_000,
- parameter integer GREEN_TIME = 10,
- parameter integer YELLOW_TIME = 4

## Project Structure
.
├── src/
│   ├── design.sv
│   └── testbench.sv
│
├── simulation/
│   ├── run.sh
│   └── traffic_signal.vcd
│
├── proteus/
│   └── Traffic Light.pdsprj
│
├── docs/
│   ├── LCSD Project Report.pdf
│   └── PROJECT Codes.pdf
│
└── README.md

## State Sequence

The traffic signal follows this sequence:

```text
NS GREEN
   ↓
NS YELLOW
   ↓
EW GREEN
   ↓
EW YELLOW
   ↓
NS GREEN
   ↓
(repeats)

