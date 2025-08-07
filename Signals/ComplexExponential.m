A = 1;                 % Amplitude
f = 5;                 % Frequency in Hz
omega = 2 * pi * f;    % Angular frequency
t = linspace(0, 1, 1000);  % Time vector from 0 to 1 second

% Complex exponential
z = A * exp(1i * omega * t);

% Plot real and imaginary parts
figure;
subplot(2,2,1);
plot(t, real(z));
title('Real Part');
xlabel('Time (s)');
ylabel('Re\{z(t)\}');

subplot(2,2,2);
plot(t, imag(z));
title('Imaginary Part');
xlabel('Time (s)');
ylabel('Im\{z(t)\}');

% Plot magnitude and phase
subplot(2,2,3);
plot(t, abs(z));
title('Magnitude');
xlabel('Time (s)');
ylabel('|z(t)|');

subplot(2,2,4);
plot(t, angle(z));
title('Phase');
xlabel('Time (s)');
ylabel('¡çz(t) [rad]');

