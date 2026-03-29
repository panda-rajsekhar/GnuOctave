clc; clear; close all;
pkg load signal
fs = 8000;
fm = 20;
fc = 500;
Am = 1;
Ac = 1;

t = 0:1/fs:0.2;

% Message and carrier
m = Am*cos(2*pi*fm*t);
c = Ac*cos(2*pi*fc*t);

% ---------------- MODULATION ----------------

% Define modulation indices directly
mu1 = 0.5;   % under
mu2 = 1;     % exact
mu3 = 2.5;   % over

s1 = Ac*(1 + mu1*m).*c;
s2 = Ac*(1 + mu2*m).*c;
s3 = Ac*(1 + mu3*m).*c;

% ---------------- DEMODULATION ----------------

% Local oscillator (same freq, phase aligned)
c_demod = cos(2*pi*fc*t);

% Low-pass filter (cutoff ~ 2*fm)
[b,a] = butter(4, 2*fm/(fs/2));

% Product detector
mr1 = filter(b,a, 2*s1.*c_demod);
mr2 = filter(b,a, 2*s2.*c_demod);
mr3 = filter(b,a, 2*s3.*c_demod);

% Remove DC offset
mr1 = mr1 - mean(mr1);
mr2 = mr2 - mean(mr2);
mr3 = mr3 - mean(mr3);

% ---------------- PLOTTING ----------------


figure;

subplot(4,3,1:3);
plot(t,m,'m'); title('Message Signal (20 Hz)');
xlim([0 0.2]);

subplot(4,3,4:6);
plot(t,c,'m'); title('Carrier Signal (500 Hz)');
xlim([0 0.02]);

subplot(4,3,7);
plot(t,s1,'m'); title('Under Modulated (μ=0.5)');
xlim([0 0.1]);

subplot(4,3,8);
plot(t,s2,'m'); title('Exact Modulated (μ=1)');
xlim([0 0.1]);

subplot(4,3,9);
plot(t,s3,'m'); title('Over Modulated (μ=2.5)');
xlim([0 0.1]);

subplot(4,3,10);
plot(t,mr1,'m'); title('Demodulated (μ=0.5)');
xlim([0 0.2]);

subplot(4,3,11);
plot(t,mr2,'m'); title('Demodulated (μ=1)');
xlim([0 0.2]);

subplot(4,3,12);
plot(t,mr3,'m'); title('Demodulated (μ=2.5)');
xlim([0 0.2]);
