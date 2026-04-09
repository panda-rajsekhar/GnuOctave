% Pulse Amplitude Modulation (PAM) in GNU Octave
% Natural/Flat-top PAM simulation

clear all;
close all;
clc;

% ========================= Parameters =========================
Fs = 1000;                    % Sampling frequency (Hz) - high for smooth plots
T = 2;                        % Total duration (seconds)
t = 0:1/Fs:T-1/Fs;            % Time vector

fm = 5;                       % Message signal frequency (Hz)
Am = 1;                       % Message signal amplitude

fs_pam = 50;                  % PAM sampling frequency (must be > 2*fm, Nyquist)
Ts = 1/fs_pam;                % Sampling period

% ========================= Message Signal =========================
m = Am * sin(2*pi*fm*t);      % Sinusoidal message signal

% ========================= PAM Modulation =========================
% Generate PAM signal (hold the sampled value until next sample)
pam_signal = zeros(size(t));

for i = 1:length(t)
    % Find the nearest sample time
    n = round(t(i)/Ts);       % Sample index
    sample_time = n * Ts;

    if abs(t(i) - sample_time) < 1e-10 || t(i) >= sample_time
        % Hold the value from the last sample
        if n >= 0 && n*Ts <= T
            pam_signal(i) = Am * sin(2*pi*fm * sample_time);
        end
    end
end

% Better vectorized way (recommended)
n_samples = 0:floor(T/Ts);
sample_times = n_samples * Ts;
sampled_values = Am * sin(2*pi*fm*sample_times);

pam_signal = zeros(size(t));
for k = 1:length(n_samples)
    idx = find(t >= sample_times(k) & t < sample_times(k) + Ts);
    if ~isempty(idx)
        pam_signal(idx) = sampled_values(k);
    end
end

% ========================= Plotting =========================
figure('Position', [100 100 900 600]);

subplot(3,1,1);
plot(t, m, 'b', 'LineWidth', 1.5);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
stem(sample_times, sampled_values, 'r', 'LineWidth', 1.5);
hold on;
plot(t, m, 'b--', 'LineWidth', 0.8);
title('Sampled Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
legend('Samples', 'Original Message');

subplot(3,1,3);
stairs(t, pam_signal, 'g', 'LineWidth', 1.5);  % Stairs for flat-top look
hold on;
plot(t, m, 'b--', 'LineWidth', 0.8);
title('Pulse Amplitude Modulated (PAM) Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
legend('PAM Signal', 'Message Signal');

% Optional: Add pulse train visualization
figure;
plot(t, pam_signal, 'g', 'LineWidth', 1.5);
title('Flat-top PAM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
