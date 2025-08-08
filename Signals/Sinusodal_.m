%{
In this code we will be learning to plot Sinusoidal Function
Background :
Sinusoidal functions are periodic functions based on the sine and cosine functions. They are fundamental in signal processing, control systems, and physics (especially wave theory and AC circuits).
General Form:

Continuous Time : x(t)=A·sin(ωt+φ) or x(t)=A·cos(ωt+φ)

Discrete Time : x[n]=A·sin(ωn+φ) or x[n]=A·cos(ωn+φ)

Therefore We need to set the values and plot.

%}

%code

%Continuous Time Sinusoidal Function

t = 0:0.01:2*pi;  % Time vector
A = 1;            % Amplitude
f = 1;            % Frequency in Hz
phi = pi/4;       % Phase in radians

%declare x
x = A * sin(2*pi*f*t + phi);

figure;
subplot(2,1,1);
plot(t, x, 'g', 'LineWidth', 1);
title('Continuous-Time Sinusoidal Function');
xlabel('Time (t)');
ylabel('x(t)');
grid on;

%Discrete Time Sinusoidal Function

n = 0:20;
omega = pi/4;  % Angular frequency
x = cos(omega*n);

subplot(2,1,2);
stem(n, x,'g', 'filled'); % using subplot to plot the discrete function
title('Discrete-Time Sinusoidal Function');
xlabel('n');
ylabel('x[n]');
grid on;


