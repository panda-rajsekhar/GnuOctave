# 📡 Envelope Detector using GNU Octave

This project demonstrates an **Envelope Detector**, a simple and widely used technique for **AM (Amplitude Modulation) demodulation**.

The goal is to **recover the original message signal** from an **AM-modulated waveform** using:

- Rectification (Diode behavior)
- Low-pass filtering (RC circuit)

---

# 🧠 Theory Overview

An **Envelope Detector** works in two main stages.

## 1️⃣ Rectification

The modulated signal is passed through a diode-like operation:

- Removes the **negative portions** of the signal  
- Leaves only the **positive peaks**

This produces a waveform that roughly follows the **signal envelope**.

---

## 2️⃣ Low-Pass Filtering

A **smoothing RC filter** extracts the **envelope** of the rectified waveform.

The resulting signal approximates the **original message signal**.

---

# ⚙️ Code Explanation

## 📌 1. Initialization

```octave
clc;
clear;
close all;
```

- `clc` → Clears the command window  
- `clear` → Removes all variables  
- `close all` → Closes all open figures  

---

## 📌 2. Signal Parameters

```octave
fs = 10000;
t = 0:1/fs:0.1;

fm = 50;
fc = 1000;

Am = 1;
Ac = 1;
```

| Parameter | Description |
|----------|-------------|
| `fs` | Sampling frequency |
| `t` | Time vector |
| `fm` | Message frequency |
| `fc` | Carrier frequency |
| `Am` | Message amplitude |
| `Ac` | Carrier amplitude |

---

## 📌 3. Message Signal

```octave
m = Am * cos(2*pi*fm*t);
```

This generates the **original low-frequency message signal**.

---

## 📌 4. AM Modulation (DSB-FC)

```octave
s = (Ac + m) .* cos(2*pi*fc*t);
```

This creates a **standard AM signal** where the **message signal modulates the carrier amplitude**.

---

## 📌 5. Rectification (Diode Simulation)

```octave
rectified = max(s, 0);
```

This simulates a **half-wave rectifier**.

- Negative values are clipped to zero  
- Equivalent to diode behavior  

### Alternative (Full-wave rectifier)

```octave
rectified = abs(s);
```

---

## 📌 6. RC Low-Pass Filter (Envelope Extraction)

```octave
RC = 0.001;
alpha = 1/(1 + (1/(fs*RC)));

envelope = zeros(size(rectified));

for i = 2:length(rectified)
    envelope(i) = alpha * rectified(i) + (1 - alpha) * envelope(i-1);
end
```

This implements a **discrete-time RC filter** that:

- Smooths the rectified signal  
- Extracts the **envelope (demodulated signal)**

### 🔍 Key Insight

The **RC value controls smoothing**:

- Too small → noisy output  
- Too large → slow response (distortion)

---

## 📌 7. Visualization

```octave
figure;

subplot(4,1,1);
plot(t, m);
title('Message Signal');

subplot(4,1,2);
plot(t, s);
title('AM Signal');

subplot(4,1,3);
plot(t, rectified);
title('Rectified Signal');

subplot(4,1,4);
plot(t, envelope, 'r', 'LineWidth', 2);
title('Detected Envelope (Output)');
```

This generates four plots:

1. **Message Signal** → Original signal  
2. **AM Signal** → Modulated waveform  
3. **Rectified Signal** → After diode action  
4. **Detected Envelope** → Recovered signal  

---

# 🎯 Key Takeaways

- Envelope detection is a **simple and effective AM demodulation technique**
- Works best when:

```
1/fc << RC << 1/fm
```

- The **RC filter plays a critical role in detection accuracy**

---

# 🚀 Possible Extensions

- Add **noise** to test robustness  
- Compare with **coherent detection**  
- Build a **GUI for real-time visualization**  
- Simulate a **physical diode model**

---

# 🧑‍💻 Requirements

- GNU Octave / MATLAB compatible environment

---

# 📜 License

This project is open-source and available for educational purposes.
