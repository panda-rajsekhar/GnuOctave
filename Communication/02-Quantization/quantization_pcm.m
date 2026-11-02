
clc;
clear;
close all;

%% PCM QUANTIZATION

% Input signal parameters
fm = 100;
Am = 1;
t = 0:0.00001:0.03;

% Generate input signal
x = Am*sin(2*pi*fm*t);

% Sampling frequency
fs = 800;
Ts = 1/fs;

% Sampling
ts = 0:Ts:0.03;
xs = Am*sin(2*pi*fm*ts);

% Quantization parameters
n = 3;
L = 2^n;

% Step size
delta = 2*Am/L;

% Uniform quantization
xq = -Am + delta/2 + ...
     delta*floor((xs+Am)/delta);

% Limit quantized values
xq = min(max(xq,-Am+delta/2),Am-delta/2);

% Quantization error
qe = xs-xq;

% PCM binary encoding
index = round((xq+Am-delta/2)/delta);
index = min(max(index,0),L-1);

pcm_code = dec2bin(index,n);

% Reconstructed signal
xr = interp1(ts,xq,t,'previous','extrap');

%% PLOT 1: INPUT AND SAMPLED SIGNAL

figure('Name','PCM Quantization','Color','w');

subplot(3,1,1);

plot(t,x,'b','LineWidth',1.5);
hold on;
stem(ts,xs,'r','filled');

grid on;
title('PCM Input and Sampled Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Input Signal','Sampled Signal');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

%% PLOT 2: QUANTIZED SIGNAL

subplot(3,1,2);

stem(ts,xs,'b','filled');
hold on;
stairs(ts,xq,'r','LineWidth',1.5);

grid on;
title('PCM Uniform Quantization');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Sampled Signal','Quantized Signal');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

%% PLOT 3: QUANTIZATION ERROR

subplot(3,1,3);

stem(ts,qe,'filled','m');

grid on;
title('PCM Quantization Error');
xlabel('Time (seconds)');
ylabel('Error');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

%% DISPLAY RESULTS

disp('PCM Quantization Results');
disp('Sampled Values:');
disp(xs);

disp('Quantized Values:');
disp(xq);

disp('Quantization Error:');
disp(qe);

disp('PCM Binary Codes:');
disp(pcm_code);

fprintf('Quantization Step Size = %f\n',delta);
fprintf('Number of Quantization Levels = %d\n',L);
