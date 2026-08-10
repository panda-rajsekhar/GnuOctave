% Experiment 01 - DSP LAB
% Generation of Basic Trigonometric Signals and Their Classification

clc;
clear;
close all;

n = -15:15;

% -------- Signal Definitions --------------------------------------------

a = sin(n);
b = cos(n);
c = tan(n);
d = sec(n);
e = csc(n);
f = cot(n);

% -------- Figure --------------------------------------------------------

figure;

% -------- Subplots ------------------------------------------------------

subplot(3,2,1);
stem(n, a, 'r', 'filled');
title('Sin(n)');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(3,2,2);
stem(n, b, 'g', 'filled');
title('Cos(n)');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(3,2,3);
stem(n, c, 'b', 'filled');
title('Tan(n)');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(3,2,4);
stem(n, d,  'filled');
title('Sec(n)');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(3,2,5);
stem(n, e, 'm', 'filled');
title('Csc(n)');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(3,2,6);
stem(n, f, 'c', 'filled');
title('Cot(n)');
xlabel('n');
ylabel('Amplitude');
grid on;


