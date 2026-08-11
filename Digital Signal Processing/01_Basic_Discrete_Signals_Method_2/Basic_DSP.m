% =========================================================================
% Experiment: Generation and Classification of Basic Signals
% Signals   : Unit Impulse, Unit Step, Unit Ramp, Sinusoidal, Exponential
% Classify  : Periodic/Non-periodic, Even/Odd/Neither, Energy/Power
% Tool      : GNU Octave
% Each plot also displays its classification results as an on-graph label.
% =========================================================================

clc;
clear all;
close all;

%% -------------------- SIGNAL DEFINITIONS -------------------------------
n1 = -5:5;  x1 = (n1 == 0);              % Unit impulse
n2 = -5:5;  x2 = (n2 >= 0);              % Unit step
n3 = -5:5;  x3 = n3 .* (n3 >= 0);        % Unit ramp
f  = 0.1;   n4 = 0:40;  x4 = sin(2*pi*f*n4);   % Sinusoidal
a  = 0.8;   n5 = 0:10;  x5 = a .^ n5;          % Exponential

% =========================================================================
%                       SIGNAL CLASSIFICATION (computed first)
% =========================================================================

%% --- (A) PERIODICITY ---
per_impulse = 'Non-periodic';
per_step    = 'Non-periodic';
per_ramp    = 'Non-periodic';

[num, den] = rat(f);                     % check if f is rational -> periodic
if den ~= 0
    per_sine = sprintf('Periodic, N = %d', den);
else
    per_sine = 'Non-periodic';
end

if a == 1
    per_exp = 'Periodic (constant)';
else
    per_exp = 'Non-periodic';
end

%% --- (B) EVEN / ODD (evaluated on symmetric index range -10:10) ---
nn = -10:10;
sig_impulse = (nn == 0);
sig_step    = (nn >= 0);
sig_ramp    = nn .* (nn >= 0);
sig_sine    = sin(2*pi*f*nn);
sig_exp     = a .^ nn .* (nn >= 0);

names_eo    = {'Impulse','Step','Ramp','Sine','Exponential'};
all_sigs_eo = {sig_impulse, sig_step, sig_ramp, sig_sine, sig_exp};
eo_result   = cell(1,5);

for k = 1:numel(all_sigs_eo)
    x  = all_sigs_eo{k};
    xf = fliplr(x);                      % represents x[-n]
    if isequal(x, xf)
        eo_result{k} = 'Even';
    elseif isequal(x, -xf)
        eo_result{k} = 'Odd';
    else
        eo_result{k} = 'Neither';
    end
end
[eo_impulse, eo_step, eo_ramp, eo_sine, eo_exp] = eo_result{:};

%% --- (C) ENERGY / POWER (over the finite simulated window) ---
names_ep    = {'Impulse','Step','Ramp','Sine','Exponential'};
all_sigs_ep = {x1, x2, x3, x4, x5};
ep_result   = cell(1,5);

for k = 1:numel(all_sigs_ep)
    x = all_sigs_ep{k};
    N = length(x);
    E = sum(abs(x).^2);
    P = E / N;
    if E < inf && P == 0
        ep_result{k} = sprintf('Energy (E=%.2f)', E);
    else
        ep_result{k} = sprintf('E=%.2f, P=%.2f', E, P);
    end
end
[ep_impulse, ep_step, ep_ramp, ep_sine, ep_exp] = ep_result{:};

% Also print full summary to the command window
printf('\n================ SIGNAL CLASSIFICATION ================\n');
printf('%-12s %-16s %-10s %s\n', 'Signal', 'Periodicity', 'Even/Odd', 'Energy/Power');
printf('%-12s %-16s %-10s %s\n', 'Impulse',   per_impulse, eo_impulse, ep_impulse);
printf('%-12s %-16s %-10s %s\n', 'Step',      per_step,    eo_step,    ep_step);
printf('%-12s %-16s %-10s %s\n', 'Ramp',      per_ramp,    eo_ramp,    ep_ramp);
printf('%-12s %-16s %-10s %s\n', 'Sine',      per_sine,    eo_sine,    ep_sine);
printf('%-12s %-16s %-10s %s\n', 'Exponential', per_exp,   eo_exp,     ep_exp);
printf('=========================================================\n');
printf('Note: Step/Ramp classifications above are for the finite\n');
printf('simulated window. Over infinite duration, Step is a POWER\n');
printf('signal and Ramp is NEITHER energy nor power.\n');

% =========================================================================
%                       PLOTS WITH CLASSIFICATION LABELS
% =========================================================================

%% -------------------- 1. UNIT IMPULSE -----------------------------------
figure(1);
stem(n1, x1, 'filled', 'LineWidth', 1.5);
title('Unit Impulse Signal \delta[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
ylim([-0.2 1.3]);
label1 = sprintf('Periodicity: %s\nSymmetry: %s\n%s signal', ...
                  per_impulse, eo_impulse, ep_impulse);
text(0.02, 0.95, label1, 'Units', 'normalized', 'VerticalAlignment', 'top', ...
     'BackgroundColor', [1 1 0.8], 'EdgeColor', 'black', 'FontSize', 9);

%% -------------------- 2. UNIT STEP --------------------------------------
figure(2);
stem(n2, x2, 'filled', 'LineWidth', 1.5);
title('Unit Step Signal u[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
ylim([-0.2 1.3]);
label2 = sprintf('Periodicity: %s\nSymmetry: %s\n%s', ...
                  per_step, eo_step, ep_step);
text(0.02, 0.95, label2, 'Units', 'normalized', 'VerticalAlignment', 'top', ...
     'BackgroundColor', [1 1 0.8], 'EdgeColor', 'black', 'FontSize', 9);

%% -------------------- 3. UNIT RAMP --------------------------------------
figure(3);
stem(n3, x3, 'filled', 'LineWidth', 1.5);
title('Unit Ramp Signal r[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
label3 = sprintf('Periodicity: %s\nSymmetry: %s\n%s', ...
                  per_ramp, eo_ramp, ep_ramp);
text(0.02, 0.95, label3, 'Units', 'normalized', 'VerticalAlignment', 'top', ...
     'BackgroundColor', [1 1 0.8], 'EdgeColor', 'black', 'FontSize', 9);

%% -------------------- 4. SINUSOIDAL --------------------------------------
figure(4);
stem(n4, x4, 'filled', 'LineWidth', 1.2);
title('Sinusoidal Signal x[n] = sin(2\pi f n)');
xlabel('n'); ylabel('Amplitude'); grid on;
label4 = sprintf('Periodicity: %s\nSymmetry: %s\n%s', ...
                  per_sine, eo_sine, ep_sine);
text(0.02, 0.95, label4, 'Units', 'normalized', 'VerticalAlignment', 'top', ...
     'BackgroundColor', [1 1 0.8], 'EdgeColor', 'black', 'FontSize', 9);

%% -------------------- 5. EXPONENTIAL --------------------------------------
figure(5);
stem(n5, x5, 'filled', 'LineWidth', 1.5);
title('Exponential Signal x[n] = a^n , a = 0.8');
xlabel('n'); ylabel('Amplitude'); grid on;
label5 = sprintf('Periodicity: %s\nSymmetry: %s\n%s', ...
                  per_exp, eo_exp, ep_exp);
text(0.02, 0.95, label5, 'Units', 'normalized', 'VerticalAlignment', 'top', ...
     'BackgroundColor', [1 1 0.8], 'EdgeColor', 'black', 'FontSize', 9);
