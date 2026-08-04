clc;
clear;
close all;

% ============================================================
%          SAMPLING THEOREM DEMONSTRATION
% ============================================================

% Original Analog Signal
f_signal = 5;              % Signal Frequency (Hz)
A = 1;
duration = 1;              % seconds

% High resolution time axis (acts as continuous signal)
t = 0:0.0005:duration;

x = A*sin(2*pi*f_signal*t);

% Nyquist Rate
Nyquist = 2*f_signal;

fprintf('Signal Frequency : %.2f Hz\n',f_signal);
fprintf('Nyquist Rate     : %.2f Samples/sec\n',Nyquist);

% ============================================================
% Sampling Frequencies
% ============================================================

Fs1 = 6;        % Below Nyquist (Aliasing)
Fs2 = Nyquist;  % Nyquist Sampling
Fs3 = 30;       % Oversampling

Fs = [Fs1 Fs2 Fs3];

titles = {
    'Undersampling (Aliasing)'
    'Nyquist Sampling'
    'Oversampling'
};

% ============================================================
% Figure 1 : Original Analog Signal
% ============================================================

figure(1)
plot(t,x,'LineWidth',2)
grid on
title('Original Continuous-Time Signal')
xlabel('Time (sec)')
ylabel('Amplitude')

% ============================================================
% Figure 2-4 : Sampled Signals
% ============================================================

for k=1:3

    fs = Fs(k);

    ts = 0:1/fs:duration;

    xs = A*sin(2*pi*f_signal*ts);

    figure(k+1)

    plot(t,x,'b','LineWidth',1.5)
    hold on

    stem(ts,xs,'r','filled','LineWidth',1.3)

    grid on

    xlabel('Time (sec)')
    ylabel('Amplitude')

    title(sprintf('%s (Fs = %d Hz)',titles{k},fs))

    legend('Original Signal','Sampled Points')

end

% ============================================================
% Figure 5 : Reconstruction
% ============================================================

figure(5)

for k=1:3

    fs = Fs(k);

    ts = 0:1/fs:duration;

    xs = A*sin(2*pi*f_signal*ts);

    % Reconstruction
    xr = interp1(ts,xs,t,'spline');

    subplot(3,1,k)

    plot(t,x,'b','LineWidth',2)
    hold on

    plot(t,xr,'r--','LineWidth',1.5)

    stem(ts,xs,'k','filled')

    grid on

    title(sprintf('%s  (Fs = %d Hz)',titles{k},fs))

    xlabel('Time (sec)')
    ylabel('Amplitude')

    legend('Original','Reconstructed','Samples')

end

% ============================================================
% Figure 6 : Original Frequency Spectrum
% ============================================================

N = length(x);

X = abs(fft(x));

freq = (0:N-1)/(N*(t(2)-t(1)));

figure(6)

plot(freq(1:N/2),X(1:N/2),'LineWidth',2)

grid on

xlabel('Frequency (Hz)')
ylabel('|X(f)|')

title('Spectrum of Original Signal')

% ============================================================
% Figure 7 : Sampled Signal Spectra
% ============================================================

figure(7)

for k=1:3

    fs = Fs(k);

    ts = 0:1/fs:duration;

    xs = A*sin(2*pi*f_signal*ts);

    N2 = length(xs);

    Xs = abs(fft(xs));

    freq2 = (0:N2-1)*(fs/N2);

    subplot(3,1,k)

    stem(freq2(1:floor(N2/2)),Xs(1:floor(N2/2)),'filled')

    grid on

    xlabel('Frequency (Hz)')
    ylabel('|X(f)|')

    title(sprintf('%s Spectrum (Fs = %d Hz)',titles{k},fs))

end

% ============================================================
% Figure 8 : Comparison of Reconstruction Error
% ============================================================

figure(8)

for k=1:3

    fs = Fs(k);

    ts = 0:1/fs:duration;

    xs = A*sin(2*pi*f_signal*ts);

    xr = interp1(ts,xs,t,'spline');

    error = x - xr;

    subplot(3,1,k)

    plot(t,error,'LineWidth',1.5)

    grid on

    xlabel('Time (sec)')
    ylabel('Error')

    title(sprintf('Reconstruction Error (Fs = %d Hz)',fs))

end
