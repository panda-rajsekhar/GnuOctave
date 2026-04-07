# Digital Phase-Locked Loop (PLL) Simulation in MATLAB

This repository contains a simple MATLAB simulation of a **Digital Phase-Locked Loop (PLL)** using a PI (Proportional-Integral) controller.

## Overview

A Phase-Locked Loop is a control system that generates an output signal whose phase is related to the phase of an input signal. This simulation demonstrates how a basic digital PLL can track a constant frequency offset (phase ramp) using:

- A phase detector (complex multiplier + `atan2`)
- A digital PI controller
- A Numerically Controlled Oscillator (NCO / VCO)

### Key Features

- Input signal with constant phase increment (`d_phi_1 = 1/20` cycles per sample)
- Second-order loop filter using PI controller
- Phase error monitoring in degrees
- Visualization of:
  - Input vs Output phase tracking
  - Phase detector error over time
  - Real parts of input and VCO output signals

## Parameters

- **Damping factor** (`eta`): `√2/2` (critically damped response)
- **Loop noise bandwidth** related parameter (`theta`): `2π/100`
- **Proportional gain** (`Kp`): Calculated from loop parameters
- **Integral gain** (`Ki`): Calculated from loop parameters
- **Phase step** of input: `1/20` cycles per sample (≈18° per sample)
- **Simulation length**: 100 samples

## How It Works

1. **Input Phase Accumulator** (`reg1`): Generates a linearly increasing phase (constant frequency).
2. **VCO / NCO** (`reg2`): The digitally controlled oscillator whose phase is adjusted by the loop.
3. **Phase Detector**: Computes the phase difference between input and VCO using complex conjugate multiplication and `atan2`.
4. **PI Controller**: Filters the phase error and drives the VCO to minimize the error.
5. **Loop Filter Gains**: Pre-computed using standard second-order PLL design equations for good locking behavior.

## Plots Generated

### 1. Phase Tracking Plot
Shows how well the VCO phase (`phi2`) tracks the input phase (`phi1`).

### 2. Phase Error Plot
Displays the instantaneous phase error (in degrees) over time. You should see the error quickly reduce and settle near zero after lock.

### 3. Time-Domain Signals
Real part of the input signal and the VCO output signal. Once locked, both signals should align in phase.

## Running the Code

1. Open MATLAB
2. Run the script
3. Three figures will be generated automatically

## Applications

This basic PLL structure is widely used in:
- Carrier recovery in digital communication systems
- Clock recovery
- Frequency synthesis
- Software Defined Radio (SDR)
- Doppler tracking

## Future Improvements

- Add loop filter with different damping factors
- Introduce frequency steps or noise
- Implement loop bandwidth adaptation
- Add lock detector
- Convert to Simulink model

---

**Made with ❤️ for learning Digital Signal Processing and PLLs**

Feel free to fork, modify, and experiment with the loop parameters!
