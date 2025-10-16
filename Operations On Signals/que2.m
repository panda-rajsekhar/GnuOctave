%===========================================================
% Demonstration of (2t - 3) operation on unit step signals
% Both Continuous-time and Discrete-time versions included
% Author: <your name>
%===========================================================
clc; clear; close all;

t = -2:0.01:4;
u_t = t >= 0;



y2 = (2*t - 3) >= 0;

n = -5:10;
u_n = n >= 0;


y4 = (2*n - 3) >= 0;

%===========================================================
% Plotting
%===========================================================
figure('Name','Operations on Unit Step Signals','NumberTitle','off');



% Continuous-time u(2t - 3)
subplot(2,1,1);
plot(t, y2, 'LineWidth', 2);
grid on;
xlabel('t'); ylabel('y(t)');
title('Continuous-time: y(t) = u(2t - 3)');
axis([-2 4 -0.2 1.2]);


% Discrete-time u[2n - 3]
subplot(2,1,2);
stem(n, y4, 'filled');
grid on;
xlabel('n'); ylabel('y[n]');
title('Discrete-time: y[n] = u[2n - 3]');
axis([-5 10 -0.2 1.2]);

%===========================================================
% Done
%===========================================================
sgtitle('Operation (2t - 3) on Unit Step Signals');


