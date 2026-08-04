%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROGRAM: Sampling Theorem Demonstration
%
% Objective:
%   To verify the Sampling Theorem by sampling a sinusoidal signal at
%   three different sampling frequencies:
%       1. Below Nyquist Rate  (Aliasing)
%       2. At Nyquist Rate
%       3. Above Nyquist Rate  (Oversampling)
%
% Software : GNU Octave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;

%% ===================================================================== %%
%                         SIGNAL PARAMETERS
%% ===================================================================== %%

A = 1;                  % Signal amplitude
f_signal = 5;           % Analog signal frequency (Hz)
duration = 1;           % Signal duration (seconds)

% High-resolution time axis (approximates continuous-time signal)
t = 0:0.0005:duration;

% Original analog signal
x = A*sin(2*pi*f_signal*t);

% Nyquist sampling frequency
Fs_nyquist = 2*f_signal;

fprintf('Signal Frequency : %.2f Hz\n',f_signal);
fprintf('Nyquist Rate     : %.2f Hz\n\n',Fs_nyquist);

%% ===================================================================== %%
%                     SAMPLING FREQUENCIES
%% ===================================================================== %%

Fs = [6 10 30];

titles = {...
    'Under Sampling (Fs = 6 Hz)',...
    'Nyquist Sampling (Fs = 10 Hz)',...
    'Over Sampling (Fs = 30 Hz)'};

%% ===================================================================== %%
%                     CREATE A SINGLE FIGURE
%% ===================================================================== %%

figure('Name','Sampling Theorem Demonstration',...
       'NumberTitle','off');

%% ===================================================================== %%
%                     ORIGINAL ANALOG SIGNAL
%% ===================================================================== %%

subplot(4,3,[2 3])

plot(t,x,'b','LineWidth',2)

grid on

title('Original Continuous-Time Signal')
xlabel('Time (Seconds)')
ylabel('Amplitude')

%% ===================================================================== %%
%                 LOOP THROUGH ALL SAMPLING CASES
%% ===================================================================== %%

for k = 1:3

    %-------------------------------------------------------------
    % Sampling
    %-------------------------------------------------------------

    fs = Fs(k);

    ts = 0:1/fs:duration;

    xs = A*sin(2*pi*f_signal*ts);

    %-------------------------------------------------------------
    % Signal Reconstruction
    %-------------------------------------------------------------

    xr = interp1(ts,xs,t,'spline');

    %-------------------------------------------------------------
    % Frequency Spectrum
    %-------------------------------------------------------------

    N = length(xs);

    X = abs(fft(xs));

    freq = (0:N-1)*(fs/N);

    %% ========================================================= %%
    % Sampled Signal
    %% ========================================================= %%

    subplot(4,3,3+k)

    plot(t,x,'b','LineWidth',1.5)

    hold on

    stem(ts,xs,'r','filled')

    grid on

    title(titles{k})

    xlabel('Time (Seconds)')
    ylabel('Amplitude')

    legend('Original','Samples')

    %% ========================================================= %%
    % Reconstructed Signal
    %% ========================================================= %%

    subplot(4,3,6+k)

    plot(t,x,'b','LineWidth',2)

    hold on

    plot(t,xr,'r--','LineWidth',1.8)

    grid on

    title(['Reconstruction - ',titles{k}])

    xlabel('Time (Seconds)')
    ylabel('Amplitude')

    legend('Original','Reconstructed')

    %% ========================================================= %%
    % Sampled Signal Spectrum
    %% ========================================================= %%

    subplot(4,3,9+k)

    stem(freq(1:floor(N/2)),...
         X(1:floor(N/2)),...
         'filled')

    grid on

    title(['Spectrum - ',titles{k}])

    xlabel('Frequency (Hz)')
    ylabel('|X(f)|')

end

%% ===================================================================== %%
%                     ORIGINAL SIGNAL SPECTRUM
%% ===================================================================== %%

N = length(x);

X = abs(fft(x));

freq = (0:N-1)/(N*(t(2)-t(1)));

subplot(4,3,1)

plot(freq(1:N/2),...
     X(1:N/2),...
     'LineWidth',2)

grid on

title('Original Signal Spectrum')

xlabel('Frequency (Hz)')
ylabel('|X(f)|')

%% ===================================================================== %%
%                           END OF PROGRAM
%% ===================================================================== %%

disp('Sampling Theorem Demonstration Completed Successfully.');
