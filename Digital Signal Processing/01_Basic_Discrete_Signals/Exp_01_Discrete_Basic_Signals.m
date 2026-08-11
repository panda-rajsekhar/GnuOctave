% EXPERIMENT 01 - DSP LAB
% Generation of Basic Signals and Their Classification
%
% Signals:
% 1. Unit Impulse
% 2. Unit Step
% 3. Unit Ramp
% 4. Sinusoidal Signal
% 5. Exponential Signal
% 6. Signum Signal
clc;
clear;
close all;

% Time index
n = -20:20;

% -------- Signal Definitions --------------------------------------------
delta   = (n == 0);              % Unit Impulse
u       = (n >= 0);               % Unit Step
r       = n .* (n >= 0);          % Unit Ramp
x_sin   = sin(0.2*pi*n);          % Sinusoidal Signal
x_exp   = (0.8).^n;               % Exponential Signal
x_sign  = sign(n);                % Signum Signal

signals = {delta, u, r, x_sin, x_exp, x_sign};
names   = {'Unit Impulse \delta[n]', 'Unit Step u[n]', 'Unit Ramp r[n]', ...
           'Sinusoidal Signal', 'Exponential Signal', 'Signum Signal'};
colors  = {'r', 'g', 'm', 'k', 'b', 'c'};

% -------- Figure: Stem Plots --------------------------------------------
figure;
for k = 1:6
    subplot(3,2,k);
    stem(n, signals{k}, colors{k}, 'filled');
    title(names{k});
    xlabel('n');
    ylabel('Amplitude');
    grid on;
end
sgtitle('Basic Discrete-Time Signals');

% -------- Classification --------------------------------------------
fprintf('\n=====================================================================================\n');
fprintf(' SIGNAL CLASSIFICATION TABLE (n = -20 to 20)\n');
fprintf('=====================================================================================\n');
fprintf('%-24s | %-12s | %-14s | %-30s\n', 'Signal', 'Time Type', 'Symmetry', 'Energy/Power Classification');
fprintf('-------------------------------------------------------------------------------------\n');

results = cell(6,4);
for k = 1:6
    x = signals{k};
    [timeType, symType, epType] = classifySignal(x, n);
    results(k,:) = {names{k}, timeType, symType, epType};
    fprintf('%-24s | %-12s | %-14s | %-30s\n', names{k}, timeType, symType, epType);
end
fprintf('=====================================================================================\n');
fprintf('Note: Unit Ramp diverges as n -> infinity (neither finite energy nor finite power).\n');
fprintf('Note: Exponential (0.8)^n is shown for a finite window; as n -> -infinity it diverges,\n');
fprintf('      so strictly it is neither an energy nor a power signal over all n. A causal\n');
fprintf('      version (0.8)^n * u[n] would instead be a finite-energy signal.\n');
fprintf('=====================================================================================\n\n');

% -------- Local Functions --------------------------------------------
function [timeType, symType, epType] = classifySignal(x, n)
    % 1) Continuous vs Discrete
    % n is a set of integer sample indices -> always discrete-time here
    timeType = 'Discrete';

    % 2) Even / Odd check (n is symmetric about 0, so flip mirrors n -> -n)
    x_flipped = fliplr(x);
    valid = isfinite(x) & isfinite(x_flipped);   % ignore any singular points
    tol = 1e-6;

    if all(abs(x(valid) - x_flipped(valid)) < tol)
        symType = 'Even';
    elseif all(abs(x(valid) + x_flipped(valid)) < tol)
        symType = 'Odd';
    else
        symType = 'Neither';
    end

    % 3) Energy vs Power classification
    % Bounded, non-decaying signals (e.g. sinusoids, step) are treated as
    % POWER signals. Signals that decay to zero (e.g. impulse) are ENERGY
    % signals. Signals that grow without bound within the window (e.g.
    % ramp, or the exponential toward n -> -infinity) are flagged as
    % unbounded / neither.
    boundThreshold = 1e3;

    if any(~isfinite(x)) || any(abs(x) > boundThreshold)
        epType = 'Neither (Unbounded)';
    else
        avgPower = mean(x.^2);
        totalEnergy = sum(x.^2);
        if avgPower < 1e-6
            epType = sprintf('Energy Signal (E=%.3f)', totalEnergy);
        elseif abs(x(1)) > 5*abs(x(round(end/2))) || abs(x(end)) > 5*abs(x(round(end/2)))
            % Large asymmetry / growth toward the window edges suggests
            % the sequence is not settling to a stable average power.
            epType = sprintf('Neither (Growing, E=%.3f)', totalEnergy);
        else
            epType = sprintf('Power Signal (P=%.3f)', avgPower);
        end
    end
end
