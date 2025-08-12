% In this code we will be learning to plot the square wave in matlab - gnuoctave
% To do it in octve we have to load a package signal by the command : 'pkg load signal' , in the command window

% Firstly we will be declaring the time vector from 0 to 1

t = 0:0.001:1;        % from 0 to 1 sec, step 1 ms

% Generate square wave (5 Hz)
y = square(2*pi*5*t);

% Plotting the curve
figure;
plot(t, y,'r' , 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Square Wave');
grid on;

