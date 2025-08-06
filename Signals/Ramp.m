%{ In this code we will be plotting the Continuous Time and Discrete Time Ramp Signal %}

%Continuous Time Vector
t = -5:0.01:5;                  % Creates a time vector t from -5 to 5 with the step value of 0.01, This creates a continuous signal.

%Creating the Ramp Signal
r_cont = t .* (t >= 0);
%{
 t>=0 --> returns a logical array with output  1 where t>=0 and 0 elsewhere
 t.*(t>=0 ) is element wise multiplication
 This defines Ramp starting at 0 and incerasing to (t>0)
%}

% Plotting Continuous-Time Ramp Signal
figure;
subplot(2,1,1);                 % First subplot (top)
plot(t, r_cont, 'LineWidth', 2);
grid on;
xlabel('Time (t)');
ylabel('Amplitude');
title('Continuous-Time Ramp Signal');


%% --- Discrete-Time Ramp Signal ---
% Define the range of n (sample indices)
n = -5:5;   % Change range as needed

% Discrete-time unit step function
u = zeros(size(n));     %It initializes a unit step array u with zeros , having same size as n
u(n >= 0) = 1;          %It applies the unit step function definition , n = 0 produces a logical mask  [0 0 0 0 0 1 1 1 1 1 1]
%whenever the condition is true it sets the u[n] =1

% Discrete-time unit ramp function
ramp = n .* u;      % Element-wise multiplication between the vectors n and u

%This gives the output [0 0 0 0 0 0 1 2 3 4 5]; which gets plotted as the ramp signal

% Plotting the discrete ramp signal
subplot(2,1,2);
stem(n, ramp, 'filled', 'r');   % Use 'stem' for discrete signals
xlabel('n');
ylabel('r[n]');
title('Discrete-Time  Ramp Signal');
grid on;

