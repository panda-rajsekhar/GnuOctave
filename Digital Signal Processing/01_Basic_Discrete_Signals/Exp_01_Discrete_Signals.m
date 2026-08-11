% Experiment 01 - DSP LAB
% Generation of Basic Trigonometric Signals and Their Classification
clc;
clear;
close all;
n = -15:15;

% -------- Signal Definitions --------------------------------------------
a = sin(n);
b = cos(n);
c = tan(n);
d = sec(n);
e = csc(n);
f = cot(n);

signals = {a, b, c, d, e, f};
names   = {'Sin(n)', 'Cos(n)', 'Tan(n)', 'Sec(n)', 'Csc(n)', 'Cot(n)'};
colors  = {'r', 'g', 'b', 'k', 'm', 'c'};

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
sgtitle('Basic Trigonometric Discrete-Time Signals');

% -------- Classification --------------------------------------------
fprintf('\n=================================================================\n');
fprintf(' SIGNAL CLASSIFICATION TABLE (n = -15 to 15)\n');
fprintf('=================================================================\n');
fprintf('%-8s | %-12s | %-14s | %-30s\n', 'Signal', 'Time Type', 'Symmetry', 'Energy/Power Classification');
fprintf('-----------------------------------------------------------------\n');

results = cell(6,4);
for k = 1:6
    x = signals{k};
    [timeType, symType, epType] = classifySignal(x, n);
    results(k,:) = {names{k}, timeType, symType, epType};
    fprintf('%-8s | %-12s | %-14s | %-30s\n', names{k}, timeType, symType, epType);
end
fprintf('=================================================================\n\n');

% -------- Local Functions --------------------------------------------
function [timeType, symType, epType] = classifySignal(x, n)
    % 1) Continuous vs Discrete
    % n is a set of integer sample indices -> always discrete-time here
    timeType = 'Discrete';

    % 2) Even / Odd check (n is symmetric about 0, so flip mirrors n -> -n)
    x_flipped = fliplr(x);
    valid = isfinite(x) & isfinite(x_flipped);   % ignore singular points (e.g. n=0 for csc,cot)
    tol = 1e-6;

    if all(abs(x(valid) - x_flipped(valid)) < tol)
        symType = 'Even';
    elseif all(abs(x(valid) + x_flipped(valid)) < tol)
        symType = 'Odd';
    else
        symType = 'Neither';
    end

    % 3) Energy vs Power classification
    % A discrete sinusoid extended to n -> infinity is bounded and
    % periodic-like, so it is treated as a POWER signal.
    % Signals with singularities (tan, sec, csc, cot) become unbounded
    % as n -> infinity (they blow up whenever the denominator sin/cos
    % passes near zero), so they are classified as NEITHER energy nor
    % power signals (both are infinite/undefined).
    boundThreshold = 1e3;

    if any(~isfinite(x)) || any(abs(x) > boundThreshold)
        epType = 'Neither (Unbounded)';
    else
        avgPower = mean(x.^2);
        if avgPower < 1e-6
            totalEnergy = sum(x.^2);
            epType = sprintf('Energy Signal (E=%.3f)', totalEnergy);
        else
            epType = sprintf('Power Signal (P=%.3f)', avgPower);
        end
    end
end
