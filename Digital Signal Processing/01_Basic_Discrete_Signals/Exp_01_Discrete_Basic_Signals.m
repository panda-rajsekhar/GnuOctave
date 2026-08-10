% EXPERIMENT 01 - DSP LAB
% Generation of Basic Signals and Their Classification
%
% Signals:
% 1. Unit Impulse
% 2. Unit Step
% 3. Unit Ramp
% 4. Sinusoidal Signal
% 5. Exponential Signal
% 6. Signum Signal

clc;
clear;
close all;

% Time index
n = -20:20;

% ------------------------------------------------------------------------
% Signal Definitions
% ------------------------------------------------------------------------

% 1. Unit Impulse
delta = (n == 0);

% 2. Unit Step
u = (n >= 0);

% 3. Unit Ramp
r = n .* (n >= 0);

% 4. Sinusoidal Signal
x_sin = sin(0.2*pi*n);

% 5. Exponential Signal
x_exp = (0.8).^n;

% 6. Signum Signal
x_sign = sign(n);

% ------------------------------------------------------------------------
% Plotting
% ------------------------------------------------------------------------

figure;

subplot(3,2,1);
stem(n, delta,"r", 'filled');
title('Unit Impulse \delta[n]');
xlabel('n');
ylabel('\delta[n]');
grid on;

subplot(3,2,2);
stem(n, u,"g", 'filled');
title('Unit Step u[n]');
xlabel('n');
ylabel('u[n]');
grid on;

subplot(3,2,3);
stem(n, r,"m", 'filled');
title('Unit Ramp r[n]');
xlabel('n');
ylabel('r[n]');
grid on;

subplot(3,2,4);
stem(n, x_sin, 'filled');
title('Sinusoidal Signal');
xlabel('n');
ylabel('x[n]');
grid on;

subplot(3,2,5);
stem(n, x_exp,"b", 'filled');
title('Exponential Signal');
xlabel('n');
ylabel('x[n]');
grid on;

subplot(3,2,6);
stem(n, x_sign,"a", 'filled');
title('Signum Signal');
xlabel('n');
ylabel('sgn[n]');
grid on;


