clc; clear; close all;
pkg load signal

% ================== PARAMETERS ==================
fs = 10000;          % Sampling frequency (Hz)
fm = 20;             % Message frequency (Hz)
fs_pulse = 500;      % Pulse sampling frequency (Hz) - Carrier pulse rate
Am = 1;              % Message amplitude
Ac = 1;              % Carrier pulse amplitude

t = 0:1/fs:0.2;      % Simulation time (0 to 0.2 seconds)

% ================== SIGNALS ==================
% Message signal
m = Am * cos(2*pi*fm*t);

% Generate Pulse Carrier (Rectangular pulses - 20% duty cycle)
pulse_period = 1/fs_pulse;
pulse_width = pulse_period * 0.2;        % 20% duty cycle

% Efficient way to generate pulse train
pulse_train = rectpuls(mod(t, pulse_period) - pulse_width/2, pulse_width);

% ================== PAM MODULATION ==================
mu1 = 0.5;   % Under modulation
mu2 = 1.0;   % Normal modulation
mu3 = 1.8;   % Over modulation

pam1 = Ac * (1 + mu1 * m) .* pulse_train;
pam2 = Ac * (1 + mu2 * m) .* pulse_train;
pam3 = Ac * (1 + mu3 * m) .* pulse_train;

% ================== DEMODULATION ==================
% Low-pass filter (Butterworth)
cutoff_freq = 4 * fm;                    % Cutoff frequency
[b, a] = butter(6, cutoff_freq/(fs/2));

demod1 = filter(b, a, pam1);
demod2 = filter(b, a, pam2);
demod3 = filter(b, a, pam3);

% Remove DC component
demod1 = demod1 - mean(demod1);
demod2 = demod2 - mean(demod2);
demod3 = demod3 - mean(demod3);

% ================== PLOTTING ==================
figure('Position', [100 100 1200 800]);

% Row 1: Message and Pulse Carrier
subplot(4,3,1:3);
plot(t, m, 'b', 'LineWidth', 1.5);
title('Message Signal (20 Hz)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.2]);

subplot(4,3,4:6);
plot(t, pulse_train, 'r', 'LineWidth', 1.2);
title('Pulse Carrier (500 Hz, 20% Duty Cycle)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.05]);

% Row 2: Modulated PAM Signals
subplot(4,3,7);
plot(t, pam1, 'b', 'LineWidth', 1.2);
title('Under Modulated PAM (μ = 0.5)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.1]);

subplot(4,3,8);
plot(t, pam2, 'b', 'LineWidth', 1.2);
title('Normal Modulated PAM (μ = 1.0)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.1]);

subplot(4,3,9);
plot(t, pam3, 'b', 'LineWidth', 1.2);
title('Over Modulated PAM (μ = 1.8)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.1]);

% Row 3: Demodulated Signals
subplot(4,3,10);
plot(t, demod1, 'b', 'LineWidth', 1.5);
title('Demodulated Signal (μ = 0.5)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.2]);

subplot(4,3,11);
plot(t, demod2, 'b', 'LineWidth', 1.5);
title('Demodulated Signal (μ = 1.0)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.2]);

subplot(4,3,12);
plot(t, demod3, 'b', 'LineWidth', 1.5);
title('Demodulated Signal (μ = 1.8)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 0.2]);

sgtitle('Pulse Amplitude Modulation (PAM) - Demonstration', 'FontSize', 14);
