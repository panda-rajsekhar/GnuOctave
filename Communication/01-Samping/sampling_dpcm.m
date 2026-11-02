
clc;
clear;
close all;

%% DPCM SAMPLING

% Input signal parameters
fm = 100;
Am = 1;
t = 0:0.00001:0.03;

% Generate input signal
x = Am*sin(2*pi*fm*t);

% Sampling frequencies
fs_values = [150 200 800];

names = {'Under Sampling','Nyquist Sampling',...
         'Over Sampling'};

% Quantization parameters
n = 3;
L = 2^n;
Emax = 1;
delta = 2*Emax/L;

figure('Name','DPCM Sampling','Color','w');

for k = 1:3

    fs = fs_values(k);
    Ts = 1/fs;

    % Sampling
    ts = 0:Ts:0.03;
    xs = Am*sin(2*pi*fm*ts);

    % Initialize variables
    N = length(xs);

    xq = zeros(1,N);
    e = zeros(1,N);
    eq = zeros(1,N);

    % DPCM encoding and decoding
    for i = 1:N

        if i == 1
            predictor = 0;
        else
            predictor = xq(i-1);
        end

        % Prediction error
        e(i) = xs(i)-predictor;

        % Quantization of prediction error
        eq(i) = -Emax + delta/2 + ...
                delta*floor((e(i)+Emax)/delta);

        % Limit quantized error
        eq(i) = min(max(eq(i),-Emax+delta/2),...
                    Emax-delta/2);

        % Reconstructed sample
        xq(i) = predictor + eq(i);

    end

    % DPCM binary encoding
    index = round((eq+Emax-delta/2)/delta);
    index = min(max(index,0),L-1);

    dpcm_code = dec2bin(index,n);

    % Reconstructed continuous signal
    xr = interp1(ts,xq,t,'previous','extrap');

    % Plot
    subplot(3,1,k);

    plot(t,x,'b','LineWidth',1.5);
    hold on;

    stem(ts,xs,'r','filled');

    stairs(t,xr,'g','LineWidth',1.2);

    grid on;

    title([names{k},' (f_s = ',num2str(fs),' Hz)']);
    xlabel('Time (seconds)');
    ylabel('Amplitude');

    legend('Input Signal','Sampled Signal',...
           'DPCM Reconstructed Signal');

    % Diagonal watermark
    text(0.5, 0.5, '240106010052', ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 18, ...
        'FontWeight', 'bold', ...
        'Color', [0.82 0.82 0.82], ...
        'Rotation', 35);

    % Display DPCM binary codes
    fprintf('\n%s\n',names{k});
    disp('DPCM Binary Codes:');
    disp(dpcm_code);

end
