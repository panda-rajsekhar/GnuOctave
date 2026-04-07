% Initialization
reg1 = 0; reg2 = 0; reg3 = 0;
eta = sqrt(2)/2;
theta = 2*pi*1/100;

Kp = (4*eta*theta)/(1 + 2*eta*theta + theta^2);
Ki = (4*theta^2)/(1 + 2*eta*theta + theta^2);

d_phi_1 = 1/20;
n_data = 100;

% Preallocate arrays
phi1_reg = zeros(1, n_data);
phi2_reg = zeros(1, n_data);
phi_error_reg = zeros(1, n_data);
s1_reg = zeros(1, n_data);
s2_reg = zeros(1, n_data);
reg1_reg = zeros(1, n_data);
reg2_reg = zeros(1, n_data);

for nn = 1:n_data
    % Input phase increment
    phi1 = reg1 + d_phi_1;
    phi1_reg(nn) = phi1;

    % Signals
    s1 = exp(1j*2*pi*reg1);
    s2 = exp(1j*2*pi*reg2);
    s1_reg(nn) = s1;
    s2_reg(nn) = s2;

    % Phase detector
    t = s1 * conj(s2);
    phi_error = atan2(imag(t), real(t)) / (2*pi);  % in cycles
    phi_error_reg(nn) = phi_error * 360;           % convert to degrees

    % PI controller
    sum1 = Kp * phi_error + reg3;
    reg3 = reg3 + Ki * phi_error;

    % Save previous states
    reg1_reg(nn) = reg1;
    reg2_reg(nn) = reg2;

    % Update VCO and input
    reg1 = phi1;
    reg2 = reg2 + sum1;
    phi2_reg(nn) = reg2;
end

% Plot phase
figure(1)
plot(phi1_reg); hold on
plot(phi2_reg,'r'); hold off
grid on
title('Phase plot');
xlabel('Samples');
ylabel('Phase (cycles)');

% Plot phase error
figure(2)
plot(phi_error_reg);
title('Phase Error of Phase Detector');
grid on;
xlabel('Samples');
ylabel('Phase error (degrees)');

% Plot input and output signals
figure(3)
plot(real(s1_reg)); hold on
plot(real(s2_reg),'r'); hold off
grid on
title('Input Signal & Output Signal of VCO');
xlabel('Samples');
ylabel('Amplitude');
axis([0 n_data -1.1 1.1]);
