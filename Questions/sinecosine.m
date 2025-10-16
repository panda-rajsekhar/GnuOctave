% Define the range of x values
x = 0:0.01:2*pi;

% Compute sine and cosine values
y1 = sin(x);
y2 = cos(x);

% Plot both functions
plot(x, y1, 'r', 'LineWidth', 2);  % red sine wave
hold on;                           % keep the current plot
plot(x, y2, 'b', 'LineWidth', 2);  % blue cosine wave
hold off;

% Add title and labels
title('Sine and Cosine Waves');
xlabel('x (radians)');
ylabel('Amplitude');

% Add a legend
legend('sin(x)', 'cos(x)');

% Add a grid
grid on;

