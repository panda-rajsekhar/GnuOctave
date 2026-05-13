clc;
clear;
close all;

% ================= PARAMETERS =================
fs = 10000;          % Sampling frequency
fm = 20;             % Message frequency
fc = 500;            % Carrier frequency
Am = 1;              % Message amplitude

t = 0:1/fs:0.25;

% Message signal
m = Am*sin(2*pi*fm*t);

% Triangular carrier
tri = sawtooth(2*pi*fc*t,0.5);

% Modulation indices
mu1 = 0.6;      % Under modulation
mu2 = 1.0;      % Normal modulation
mu3 = 1.6;      % Over modulation

% ==========================================================
% PWM GENERATION
% ==========================================================
pwm1 = (mu1*m > tri);
pwm2 = (mu2*m > tri);
pwm3 = (mu3*m > tri);

% ==========================================================
% PPM GENERATION
% Proper frame-based PPM
% ==========================================================

ppm1 = zeros(size(t));
ppm2 = zeros(size(t));
ppm3 = zeros(size(t));

samples_per_frame = round(fs/fc);

% Fixed pulse width for PPM
pulse_width = round(samples_per_frame/10);

% ==========================================================
% UNDER MODULATION (mu = 0.6)
% ==========================================================
for k = 1:floor(length(t)/samples_per_frame)

    idx0 = (k-1)*samples_per_frame + 1;

    if idx0 > length(m)
        break;
    end

    % Normalize message to [0,1]
    msg = mu1*m(idx0);

    % Pulse position shift
    shift = round(((msg + 1)/2) * 0.8*samples_per_frame);

    idx = idx0 + shift;

    if idx+pulse_width <= length(ppm1)
        ppm1(idx:idx+pulse_width) = 1;
    end
end

% ==========================================================
% NORMAL MODULATION (mu = 1.0)
% ==========================================================
for k = 1:floor(length(t)/samples_per_frame)

    idx0 = (k-1)*samples_per_frame + 1;

    if idx0 > length(m)
        break;
    end

    msg = mu2*m(idx0);

    shift = round(((msg + 1)/2) * 0.8*samples_per_frame);

    idx = idx0 + shift;

    if idx+pulse_width <= length(ppm2)
        ppm2(idx:idx+pulse_width) = 1;
    end
end

% ==========================================================
% OVER MODULATION (mu = 1.6)
% ==========================================================
for k = 1:floor(length(t)/samples_per_frame)

    idx0 = (k-1)*samples_per_frame + 1;

    if idx0 > length(m)
        break;
    end

    msg = mu3*m(idx0);

    shift = round(((msg + 1)/2) * 0.8*samples_per_frame);

    idx = idx0 + shift;

    if idx+pulse_width <= length(ppm3)
        ppm3(idx:idx+pulse_width) = 1;
    end
end

% ==========================================================
% DEMODULATION
% Low-pass filter approximation
% ==========================================================

[b,a] = butter(6,80/(fs/2));

dem1 = filter(b,a,double(ppm1));
dem2 = filter(b,a,double(ppm2));
dem3 = filter(b,a,double(ppm3));

% Remove DC component
dem1 = dem1 - mean(dem1);
dem2 = dem2 - mean(dem2);
dem3 = dem3 - mean(dem3);

% Normalize recovered signals
dem1 = dem1/max(abs(dem1));
dem2 = dem2/max(abs(dem2));
dem3 = dem3/max(abs(dem3));

% ==========================================================
% PLOTTING
% ==========================================================

figure('Position',[100 100 1400 850]);

% Message signal
subplot(4,3,1:3);
plot(t,m,'b','LineWidth',1.5);
title('Message Signal (20 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.25]);

% Carrier signal
subplot(4,3,4:6);
plot(t,tri,'r','LineWidth',1.2);
title('Triangular Carrier (500 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.05]);

% Under modulated PPM
subplot(4,3,7);
plot(t,ppm1,'k','LineWidth',1.2);
title('Under Modulated PPM (\mu = 0.6)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.1]);

% Normally modulated PPM
subplot(4,3,8);
plot(t,ppm2,'k','LineWidth',1.2);
title('Normal Modulated PPM (\mu = 1.0)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.1]);

% Over modulated PPM
subplot(4,3,9);
plot(t,ppm3,'k','LineWidth',1.2);
title('Over Modulated PPM (\mu = 1.6)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.1]);

% Demodulated under
subplot(4,3,10);
plot(t,dem1,'b','LineWidth',1.5);
title('Demodulated Signal (\mu = 0.6)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.25]);

% Demodulated normal
subplot(4,3,11);
plot(t,dem2,'b','LineWidth',1.5);
title('Demodulated Signal (\mu = 1.0)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.25]);

% Demodulated over
subplot(4,3,12);
plot(t,dem3,'b','LineWidth',1.5);
title('Demodulated Signal (\mu = 1.6)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.25]);

sgtitle('Pulse Position Modulation (PPM) Simulation','FontSize',15);
