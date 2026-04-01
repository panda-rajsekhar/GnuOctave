clc;
clear;
close all;

% 📌 Parameters
fs = 10000;          % Sampling frequency
t = 0:1/fs:0.1;      % Time vector

fm = 50;             % Message frequency
fc = 1000;           % Carrier frequency

Am = 1;              % Message amplitude
Ac = 1;              % Carrier amplitude

%  Message Signal
m = Am * cos(2*pi*fm*t);

% AM Modulated Signal (DSB-FC)
s = (Ac + m) .* cos(2*pi*fc*t);

% Step 1: Rectification (Diode simulation)
rectified = max(s, 0);   % Half-wave rectifier

% Step 2: RC Low Pass Filter
RC = 0.001;              % Time constant
alpha = 1/(1 + (1/(fs*RC)));

envelope = zeros(size(rectified));

for i = 2:length(rectified)
    envelope(i) = alpha * rectified(i) + (1 - alpha) * envelope(i-1);
end

%  Plotting
figure;

subplot(4,1,1);
plot(t, m);
title('Message Signal');
grid on;

subplot(4,1,2);
plot(t, s);
title('AM Signal');
grid on;

subplot(4,1,3);
plot(t, rectified);
title('Rectified Signal');
grid on;

subplot(4,1,4);
plot(t, envelope, 'r', 'LineWidth', 2);
title('Detected Envelope (Output)');
grid on;
