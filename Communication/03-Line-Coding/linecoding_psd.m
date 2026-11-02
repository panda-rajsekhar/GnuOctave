clc;
clear;
close all;

%% LINE CODING SCHEMES AND PSD ANALYSIS

% Parameters
N = 20;                 % Number of bits
Rb = 100;                % Bit rate
Tb = 1/Rb;               % Bit duration
A = 1;                   % Signal amplitude
Fs = 10000;               % Sampling frequency
Ns = Fs/Rb;               % Samples per bit

% Generate random binary input sequence
rng(10);
bits = randi([0 1],1,N);

% Time vector
t = (0:N*Ns-1)/Fs;

% Initialize encoded signals
unipolar = zeros(1,N*Ns);
bipolar = zeros(1,N*Ns);
manchester = zeros(1,N*Ns);
polar = zeros(1,N*Ns);

%% 1. UNIPOLAR NRZ ENCODING

for i = 1:N

    idx = (i-1)*Ns+1:i*Ns;

    if bits(i) == 1
        unipolar(idx) = A;
    else
        unipolar(idx) = 0;
    end

end

%% 2. BIPOLAR AMI ENCODING

last_pulse = -A;

for i = 1:N

    idx = (i-1)*Ns+1:i*Ns;

    if bits(i) == 1

        last_pulse = -last_pulse;
        bipolar(idx) = last_pulse;

    else

        bipolar(idx) = 0;

    end

end

%% 3. MANCHESTER ENCODING

for i = 1:N

    idx = (i-1)*Ns+1:i*Ns;
    half = Ns/2;

    if bits(i) == 1

        manchester(idx(1:half)) = A;
        manchester(idx(half+1:end)) = -A;

    else

        manchester(idx(1:half)) = -A;
        manchester(idx(half+1:end)) = A;

    end

end

%% 4. POLAR NRZ ENCODING

for i = 1:N

    idx = (i-1)*Ns+1:i*Ns;

    if bits(i) == 1
        polar(idx) = A;
    else
        polar(idx) = -A;
    end

end

%% DISPLAY INPUT BINARY SEQUENCE

disp('Original Binary Input Sequence:');
disp(bits);

%% FIGURE 1: LINE CODING WAVEFORMS

figure('Name','Line Coding Schemes',...
       'Color','w');

% Input binary sequence
subplot(5,1,1);

stairs(0:N,[bits bits(end)],'k','LineWidth',1.5);

xlim([0 N]);
ylim([-0.3 1.3]);
grid on;

title('Original Binary Input Sequence');
xlabel('Bit Number');
ylabel('Binary');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

% Unipolar NRZ
subplot(5,1,2);

plot(t,unipolar,'b','LineWidth',1.5);

grid on;
xlim([0 N*Tb]);

title('Unipolar NRZ Line Coding');
xlabel('Time (seconds)');
ylabel('Amplitude');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

% Bipolar AMI
subplot(5,1,3);

plot(t,bipolar,'r','LineWidth',1.5);

grid on;
xlim([0 N*Tb]);

title('Bipolar AMI Line Coding');
xlabel('Time (seconds)');
ylabel('Amplitude');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

% Manchester
subplot(5,1,4);

plot(t,manchester,'m','LineWidth',1.5);

grid on;
xlim([0 N*Tb]);

title('Manchester Line Coding');
xlabel('Time (seconds)');
ylabel('Amplitude');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

% Polar NRZ
subplot(5,1,5);

plot(t,polar,'g','LineWidth',1.5);

grid on;
xlim([0 N*Tb]);

title('Polar NRZ Line Coding');
xlabel('Time (seconds)');
ylabel('Amplitude');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

%% PSD CALCULATION USING FFT

signals = {unipolar,bipolar,manchester,polar};

scheme_names = {'Unipolar NRZ','Bipolar AMI',...
                'Manchester','Polar NRZ'};

% Frequency axis
M = length(unipolar);
Nfft = 2^nextpow2(4*M);

f = (0:Nfft/2)*Fs/Nfft;

% Figure for PSD
figure('Name','PSD Analysis of Line Coding',...
       'Color','w');

for k = 1:4

    signal = signals{k};

    % FFT
    X = fft(signal,Nfft);

    % Two-sided periodogram
    Pxx = abs(X).^2/(Fs*M);

    % One-sided PSD
    Pxx = Pxx(1:Nfft/2+1);
    Pxx(2:end-1) = 2*Pxx(2:end-1);

    % Convert to dB
    Pxx_dB = 10*log10(max(Pxx,1e-12));

    % Plot PSD
    subplot(4,1,k);

    plot(f,Pxx_dB,'LineWidth',1.3);

    grid on;
    xlim([0 2000]);

    title([scheme_names{k},' - Power Spectral Density']);
    xlabel('Frequency (Hz)');
    ylabel('PSD (dB/Hz)');

    text(0.5,0.5,'240106010052',...
        'Units','normalized',...
        'HorizontalAlignment','center',...
        'VerticalAlignment','middle',...
        'FontSize',18,...
        'FontWeight','bold',...
        'Color',[0.82 0.82 0.82],...
        'Rotation',35);

end

%% DISPLAY INFORMATION

fprintf('\nLINE CODING AND PSD ANALYSIS\n');

fprintf('Number of bits = %d\n',N);
fprintf('Bit rate = %d bits/sec\n',Rb);
fprintf('Bit duration = %f seconds\n',Tb);
fprintf('Sampling frequency = %d Hz\n',Fs);

disp('Binary Input Sequence:');
disp(bits);

disp('Line coding and PSD analysis completed.');
