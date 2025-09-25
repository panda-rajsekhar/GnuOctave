% Clear the command window, workspace, and close all figures
clc; clear; close all;

% Circuit parameters
% Define the voltage of source V1 (in Volts)
V1 = 10;   % Volts
% Define the voltage of source V2 (in Volts)
V2 = 5;    % Volts
% Define the resistance of resistor R1 (in Ohms)
R1 = 4;    % Ohms
% Define the resistance of resistor R2 (in Ohms)
R2 = 6;    % Ohms
% Define the resistance of resistor R3 (in Ohms)
R3 = 12;   % Ohms

% --- Case 1: Both sources active ---
% Perform nodal analysis at Node A, where all resistors (R1, R2, R3) are
% connected, and V1 is connected to Node A through R1, V2 through R2, and
% Node A is connected to ground through R3.
% Calculate the total conductance at Node A (sum of conductances of R1, R2, R3)
% Conductance G = 1/R for each resistor, so total G = 1/R1 + 1/R2 + 1/R3
G = 1/R1 + 1/R2 + 1/R3;   % Conductance sum (in Siemens)
% Calculate the total current injected into Node A
% Current through R1 = V1/R1 (from V1 to Node A)
% Current through R2 = V2/R2 (from V2 to Node A)
% R3 does not contribute current as it connects Node A to ground
I = (V1/R1) + (V2/R2);    % Current injection (in Amperes)
% Calculate Node A voltage using Ohm's law for nodal analysis: VA = I_total / G_total
VA_both = I / G;          % Node A voltage (in Volts)

% --- Case 2: Only V1 active (V2 shorted) ---
% Apply superposition: Set V2 = 0 (short circuit), so only V1 is active
% Current injection comes only from V1 through R1
I1 = (V1/R1);             % Injection from V1 (in Amperes)
% Conductance remains the same as all resistors are still connected
% Total conductance at Node A: G1 = 1/R1 + 1/R2 + 1/R3
G1 = (1/R1 + 1/R2 + 1/R3); % Conductance (same as G)
% Calculate Node A voltage with only V1 active: VA_V1 = I1 / G1
VA_V1 = I1 / G1;          % Node A voltage (in Volts)

% --- Case 3: Only V2 active (V1 shorted) ---
% Apply superposition: Set V1 = 0 (short circuit), so only V2 is active
% Current injection comes only from V2 through R2
I2 = (V2/R2);             % Injection from V2 (in Amperes)
% Conductance remains the same as all resistors are still connected
% Total conductance at Node A: G2 = 1/R1 + 1/R2 + 1/R3
G2 = (1/R1 + 1/R2 + 1/R3); % Conductance (same as G)
% Calculate Node A voltage with only V2 active: VA_V2 = I2 / G2
VA_V2 = I2 / G2;          % Node A voltage (in Volts)

% Superposition result
% According to the superposition theorem, the total response (voltage at Node A)
% is the sum of responses due to each source acting alone
VA_super = VA_V1 + VA_V2; % Sum of voltages from V1 and V2 cases (in Volts)

% --- Display Results ---
% Print the calculated voltage at Node A when both sources are active
fprintf('Node A voltage with both sources active: %.2f V\n', VA_both);
% Print the voltage at Node A when only V1 is active
fprintf('Node A voltage with only V1 active: %.2f V\n', VA_V1);
% Print the voltage at Node A when only V2 is active
fprintf('Node A voltage with only V2 active: %.2f V\n', VA_V2);
% Print the voltage at Node A calculated using superposition
fprintf('Node A voltage by Superposition (V1 + V2): %.2f V\n', VA_super);

% --- Verification ---
% Verify the superposition theorem by checking if the voltage with both sources
% active (VA_both) equals the sum of voltages from individual sources (VA_super)
% Use a small tolerance (1e-6) to account for numerical precision errors
if abs(VA_both - VA_super) < 1e-6
    % If the difference is less than 1e-6, superposition is verified
    disp('Superposition theorem verified!');
else
    % If the difference is significant, superposition is not satisfied
    disp('Superposition theorem not verified.');
end
