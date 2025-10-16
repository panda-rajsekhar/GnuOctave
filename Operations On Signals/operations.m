% MATLAB Code to Demonstrate Shifting, Scaling, and Reversal
% for Unit Step Function (Continuous & Discrete Time)

clc; clear; close all;

%% Define Time Axes
t = -10:0.01:10;   % Continuous time axis
n = -10:10;        % Discrete time axis

%% Define Unit Step Function
u_t = double(t>=0);   % Continuous-time unit step
u_n = double(n>=0);   % Discrete-time unit step

%% Continuous-Time Operations
% Shifting (u(t-3)) --> Right shift by 3
u_shift = double((t-3) >= 0);

% Time Scaling (u(0.5t)) --> Slow down by factor of 2
u_scale = double((0.5*t) >= 0);

% Time Reversal (u(-t))
u_rev = double((-t) >= 0);

% Amplitude Scaling (2*u(t))
u_amp = 2 * u_t;

%% Discrete-Time Operations
% Shifting (u[n-3])
u_n_shift = double((n-3) >= 0);

% Time Scaling (u[2n]) --> compress by factor of 2
u_n_scale = double((2*n) >= 0);

% Time Reversal (u[-n])
u_n_rev = double((-n) >= 0);

% Amplitude Scaling (0.5*u[n])
u_n_amp = 0.5 * u_n;

%% Plot Continuous-Time
figure('Name','Continuous-Time Unit Step Operations');
subplot(5,1,1); plot(t,u_t,'LineWidth',2); grid on;
title('u(t) - Original Unit Step'); xlabel('t'); ylabel('u(t)');

subplot(5,1,2); plot(t,u_shift,'r','LineWidth',2); grid on;
title('u(t-3) - Time Shift'); xlabel('t'); ylabel('u(t-3)');

subplot(5,1,3); plot(t,u_scale,'m','LineWidth',2); grid on;
title('u(0.5t) - Time Scaling'); xlabel('t'); ylabel('u(0.5t)');

subplot(5,1,4); plot(t,u_rev,'g','LineWidth',2); grid on;
title('u(-t) - Time Reversal'); xlabel('t'); ylabel('u(-t)');

subplot(5,1,5); plot(t,u_amp,'k','LineWidth',2); grid on;
title('2u(t) - Amplitude Scaling'); xlabel('t'); ylabel('2u(t)');

%% Plot Discrete-Time
figure('Name','Discrete-Time Unit Step Operations');
subplot(5,1,1); stem(n,u_n,'filled'); grid on;
title('u[n] - Original Unit Step'); xlabel('n'); ylabel('u[n]');

subplot(5,1,2); stem(n,u_n_shift,'r','filled'); grid on;
title('u[n-3] - Time Shift'); xlabel('n'); ylabel('u[n-3]');

subplot(5,1,3); stem(n,u_n_scale,'m','filled'); grid on;
title('u[2n] - Time Scaling'); xlabel('n'); ylabel('u[2n]');

subplot(5,1,4); stem(n,u_n_rev,'g','filled'); grid on;
title('u[-n] - Time Reversal'); xlabel('n'); ylabel('u[-n]');

subplot(5,1,5); stem(n,u_n_amp,'k','filled'); grid on;
title('0.5u[n] - Amplitude Scaling'); xlabel('n'); ylabel('0.5u[n]');

