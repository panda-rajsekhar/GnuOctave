clc; clear; close all;

fs = 10000;        % Sampling frequency
fm = 20;           % Message frequency
fc = 500;          % Carrier frequency
Am = 1;
Ac = 1;            % Not really used in PWM, kept for consistency

t = 0:1/fs:0.25;   % Increased a bit for better view

% Signals
m = Am * sin(2*pi*fm*t);
tri = sawtooth(2*pi*fc*t, 0.5);     % Triangular carrier

% Modulation indices
mu1 = 0.6;   % Under
mu2 = 1.0;   % Normal
mu3 = 1.7;   % Over

% PWM Generation
pwm1 = (mu1 * m > tri);
pwm2 = (mu2 * m > tri);
pwm3 = (mu3 * m > tri);

% Demodulation
[b,a] = butter(6, 80/(fs/2));   % Cutoff around 4*fm

dem1 = filter(b,a, double(pwm1));
dem2 = filter(b,a, double(pwm2));
dem3 = filter(b,a, double(pwm3));

dem1 = dem1 - mean(dem1);
dem2 = dem2 - mean(dem2);
dem3 = dem3 - mean(dem3);

% Plotting
figure('Position',[100 100 1300 800]);

subplot(4,3,1:3); plot(t,m,'b','LineWidth',1.5); title('Message Signal (20 Hz)'); xlim([0 0.25]); grid on;
ylabel('Amplitude');

subplot(4,3,4:6); plot(t,tri,'r','LineWidth',1.2); title('Triangular Carrier (500 Hz)'); xlim([0 0.05]); grid on;
ylabel('Amplitude');

subplot(4,3,7); plot(t,pwm1,'b','LineWidth',1.2); title('Under Modulated PWM (μ=0.6)'); xlim([0 0.1]); grid on;
subplot(4,3,8); plot(t,pwm2,'b','LineWidth',1.2); title('Normal Modulated PWM (μ=1.0)'); xlim([0 0.1]); grid on;
subplot(4,3,9); plot(t,pwm3,'b','LineWidth',1.2); title('Over Modulated PWM (μ=1.7)'); xlim([0 0.1]); grid on;

subplot(4,3,10); plot(t,dem1,'b','LineWidth',1.5); title('Demodulated (μ=0.6)'); xlim([0 0.25]); grid on;
subplot(4,3,11); plot(t,dem2,'b','LineWidth',1.5); title('Demodulated (μ=1.0)'); xlim([0 0.25]); grid on;
subplot(4,3,12); plot(t,dem3,'b','LineWidth',1.5); title('Demodulated (μ=1.7)'); xlim([0 0.25]); grid on;

sgtitle('Pulse Width Modulation (PWM) using Natural Sampling','FontSize',14);
