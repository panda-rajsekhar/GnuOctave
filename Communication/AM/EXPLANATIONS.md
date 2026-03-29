## 📶 Amplitude Modulation (AM) Simulation

This script demonstrates **Amplitude Modulation (AM)** and **coherent demodulation using a product detector** in **GNU Octave / MATLAB**.

It shows how different **modulation indices (μ)** affect the transmitted signal and how the **original message signal can be recovered** using a **local oscillator and low-pass filtering**.

The simulation visualizes three cases:

* **Under Modulation (μ < 1)**
* **Critical Modulation (μ = 1)**
* **Over Modulation (μ > 1)**

---

## 🧠 Theory

In amplitude modulation, the carrier amplitude varies according to the message signal.

The AM signal is given by:

[
s(t) = A_c (1 + \mu m(t)) \cos(2\pi f_c t)
]

Where:

* (A_c) → Carrier amplitude
* (m(t)) → Message signal
* (f_c) → Carrier frequency
* (μ) → Modulation index

Interpretation of μ:

| Modulation Index | Condition           | Effect                                |
| ---------------- | ------------------- | ------------------------------------- |
| μ < 1            | Under modulation    | Envelope follows message correctly    |
| μ = 1            | Critical modulation | Maximum modulation without distortion |
| μ > 1            | Over modulation     | Envelope distortion occurs            |

---

# ⚙️ Code Explanation

## 1️⃣ Initialization

```matlab
clc; clear; close all;
pkg load signal
```

* `clc` → clears terminal output
* `clear` → removes variables from workspace
* `close all` → closes previous plots
* `pkg load signal` → loads the **signal processing toolbox** (required for the Butterworth filter)

---

## 2️⃣ Define System Parameters

```matlab
fs = 8000;
fm = 20;
fc = 500;
Am = 1;
Ac = 1;
```

| Parameter | Meaning                      |
| --------- | ---------------------------- |
| `fs`      | Sampling frequency (8000 Hz) |
| `fm`      | Message frequency (20 Hz)    |
| `fc`      | Carrier frequency (500 Hz)   |
| `Am`      | Message amplitude            |
| `Ac`      | Carrier amplitude            |

---

## 3️⃣ Time Vector

```matlab
t = 0:1/fs:0.2;
```

Creates a **time axis from 0 to 0.2 seconds** sampled at **8000 Hz**.

---

## 4️⃣ Generate Message and Carrier Signals

```matlab
m = Am*cos(2*pi*fm*t);
c = Ac*cos(2*pi*fc*t);
```

* `m(t)` → low-frequency **message signal**
* `c(t)` → high-frequency **carrier signal**

---

## 5️⃣ Define Modulation Indices

```matlab
mu1 = 0.5;
mu2 = 1;
mu3 = 2.5;
```

Three modulation scenarios are simulated:

| μ   | Case                |
| --- | ------------------- |
| 0.5 | Under modulation    |
| 1   | Critical modulation |
| 2.5 | Over modulation     |

---

## 6️⃣ AM Modulation

```matlab
s1 = Ac*(1 + mu1*m).*c;
s2 = Ac*(1 + mu2*m).*c;
s3 = Ac*(1 + mu3*m).*c;
```

This implements the **AM modulation formula**:

[
s(t) = A_c (1 + μ m(t))c(t)
]

Three AM signals are generated:

* `s1` → under-modulated signal
* `s2` → critically modulated signal
* `s3` → over-modulated signal

---

## 7️⃣ Coherent Demodulation (Product Detector)

### Local Oscillator

```matlab
c_demod = cos(2*pi*fc*t);
```

A **local carrier** with the same frequency is generated to recover the message signal.

---

### Low Pass Filter Design

```matlab
[b,a] = butter(4, 2*fm/(fs/2));
```

A **4th-order Butterworth low-pass filter** is created.

Cutoff frequency:

[
f_c \approx 2f_m
]

Purpose:

* Remove high-frequency carrier components
* Keep only the message signal

---

### Product Detection

```matlab
mr1 = filter(b,a, 2*s1.*c_demod);
mr2 = filter(b,a, 2*s2.*c_demod);
mr3 = filter(b,a, 2*s3.*c_demod);
```

Steps:

1. Multiply AM signal with the **local oscillator**
2. This shifts the **message back to baseband**
3. Apply **low-pass filtering** to recover the message

---

### Remove DC Offset

```matlab
mr1 = mr1 - mean(mr1);
mr2 = mr2 - mean(mr2);
mr3 = mr3 - mean(mr3);
```

Demodulation introduces a **DC component**, which is removed by subtracting the mean.

---

# 📊 Visualization

The script plots **12 subplots** showing the full communication process.

### Signals Displayed

| Plot | Signal                       |
| ---- | ---------------------------- |
| 1    | Message signal               |
| 2    | Carrier signal               |
| 3    | Under-modulated AM           |
| 4    | Critical modulation          |
| 5    | Over-modulated AM            |
| 6    | Demodulated signal (μ = 0.5) |
| 7    | Demodulated signal (μ = 1)   |
| 8    | Demodulated signal (μ = 2.5) |

Each plot uses **time-limited windows** for clearer visualization.

---

# 🎯 Key Observations

* **Under modulation (μ < 1)** → signal demodulates cleanly
* **Critical modulation (μ = 1)** → maximum transmission without distortion
* **Over modulation (μ > 1)** → envelope distortion occurs and recovery becomes inaccurate

This simulation helps visualize how **modulation index affects signal quality and demodulation accuracy**.

---

⭐ This script is part of the **Communication Systems Simulations** collection for learning modulation techniques using **GNU Octave / MATLAB**.
