clc;
clear;
close all;

%% PCM SAMPLING

% Input signal parameters
fm = 100;                  
Am = 1;                    
t = 0:0.00001:0.03;        

% Generate input signal
x = Am*sin(2*pi*fm*t);

% Sampling frequencies
fs_under = 150;            
fs_nyquist = 200;           
fs_over = 800;              

% Quantization parameters
n = 3;                     
L = 2^n;                   

% Sampling cases
fs_values = [fs_under fs_nyquist fs_over];

names = {'Under Sampling','Nyquist Sampling',...
    'Over Sampling'};

figure('Name','PCM Sampling','Color','w');

for k = 1:3

    fs = fs_values(k);
    Ts = 1/fs;

    % Sampling
    ts = 0:Ts:0.03;
    xs = Am*sin(2*pi*fm*ts);

    % Uniform quantization
    delta = 2*Am/L;

    xq = -Am + delta/2 + ...
        delta*floor((xs+Am)/delta);

    % Limit quantized values
    xq = min(max(xq,-Am+delta/2),Am-delta/2);

    % PCM encoding
    index = round((xq + Am - delta/2)/delta);
    index = min(max(index,0),L-1);

    pcm_code = dec2bin(index,n);

    % Reconstructed signal
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
        'Quantized/Reconstructed Signal');

    % Diagonal watermark
    text(0.5, 0.5, '240106010052', ...
        'Units', 'normalized', ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 18, ...
        'FontWeight', 'bold', ...
        'Color', [0.82 0.82 0.82], ...
        'Rotation', 35);

    % Display PCM binary codes
    fprintf('\n%s\n',names{k});
    disp('PCM Binary Codes:');
    disp(pcm_code);

end