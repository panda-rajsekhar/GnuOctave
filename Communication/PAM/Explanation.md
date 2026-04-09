# 📡 Pulse Amplitude Modulation (PAM) Simulation in GNU Octave  

## 🔍 Overview  
This project demonstrates **Pulse Amplitude Modulation (PAM)** using a sinusoidal message signal in **GNU Octave / MATLAB**.

The simulation generates:
- Original message signal  
- Instantaneous sampled points (stem plot)  
- Flat-top PAM signal (Sample-and-Hold / Zero-Order Hold)  

---

## 📘 Theory Overview  

**Pulse Amplitude Modulation (PAM)** is a sampling technique where the amplitude of a pulse train varies according to the instantaneous amplitude of an analog signal.

### 🧩 Types of PAM  

#### 1. Natural Sampling (Gated PAM)
- The signal is multiplied by a rectangular pulse train  
- Pulse follows the **shape of the signal**  
- Top is **not flat**, it is curved  

#### 2. Flat-Top Sampling (Sample-and-Hold PAM)
- Signal is sampled at discrete instants  
- Each sample is **held constant** until the next one  
- Produces **flat-top pulses**  
- Widely used in **ADC systems**  

---


## ⚙️ Simulation Details  

This script implements **Flat-Top PAM** using a **Zero-Order Hold (ZOH)** approach.

### 📊 Key Parameters  

| Parameter | Value |
|----------|------|
| Message Frequency (`fm`) | 5 Hz |
| Sampling Frequency (`fs_pam`) | 50 Hz |
| Condition | `fs_pam > 2 × fm` (Nyquist satisfied) |

---

## 🧠 How Flat-Top PAM Works  

1. Sample the signal at: $t = n * Ts$
2. For each interval : $$nTs, (n+1)Ts)$$

the value is **held constant**

 This produces a staircase waveform:
- Horizontal segments → constant amplitude  
- Vertical jumps → new sample  

`stairs()` is ideal for visualization.

---

The Results are in images *pam1.png* and *pam2.png*
