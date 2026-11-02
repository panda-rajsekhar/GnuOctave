clc;
clear;
close all;

%% DPCM QUANTIZATION

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

Emax = 1;
delta = 2*Emax/L;

% Initialize variables
N = length(xs);

xq = zeros(1,N);
e = zeros(1,N);
eq = zeros(1,N);
predict = zeros(1,N);

%% DPCM ENCODING AND DECODING

for i = 1:N

    % Prediction
    if i == 1
        predict(i) = 0;
    else
        predict(i) = xq(i-1);
    end

    % Prediction error
    e(i) = xs(i)-predict(i);

    % Uniform quantization of error
    eq(i) = -Emax + delta/2 + ...
            delta*floor((e(i)+Emax)/delta);

    % Limit quantized error
    eq(i) = min(max(eq(i),-Emax+delta/2),...
                Emax-delta/2);

    % Reconstructed sample
    xq(i) = predict(i)+eq(i);

end

% DPCM binary encoding
index = round((eq+Emax-delta/2)/delta);
index = min(max(index,0),L-1);

dpcm_code = dec2bin(index,n);

% Reconstruction
xr = interp1(ts,xq,t,'previous','extrap');

%% PLOT 1: INPUT AND SAMPLED SIGNAL

figure('Name','DPCM Quantization','Color','w');

subplot(3,1,1);

plot(t,x,'b','LineWidth',1.5);
hold on;
stem(ts,xs,'r','filled');

grid on;
title('DPCM Input and Sampled Signal');
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

%% PLOT 2: PREDICTION ERROR QUANTIZATION

subplot(3,1,2);

stem(ts,e,'b','filled');
hold on;
stairs(ts,eq,'r','LineWidth',1.5);

grid on;
title('DPCM Prediction Error Quantization');
xlabel('Time (seconds)');
ylabel('Error Amplitude');

legend('Prediction Error','Quantized Error');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

%% PLOT 3: RECONSTRUCTED SIGNAL

subplot(3,1,3);

plot(t,x,'b','LineWidth',1.5);
hold on;
stairs(t,xr,'r','LineWidth',1.5);

grid on;
title('DPCM Reconstructed Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original Signal','Reconstructed Signal');

text(0.5,0.5,'240106010052',...
    'Units','normalized',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle',...
    'FontSize',18,...
    'FontWeight','bold',...
    'Color',[0.82 0.82 0.82],...
    'Rotation',35);

%% DISPLAY RESULTS

disp('DPCM Quantization Results');

disp('Sampled Values:');
disp(xs);

disp('Predicted Values:');
disp(predict);

disp('Prediction Error:');
disp(e);

disp('Quantized Prediction Error:');
disp(eq);

disp('Reconstructed Values:');
disp(xq);

disp('DPCM Binary Codes:');
disp(dpcm_code);

fprintf('Quantization Step Size = %f\n',delta);
fprintf('Number of Quantization Levels = %d\n',L);
