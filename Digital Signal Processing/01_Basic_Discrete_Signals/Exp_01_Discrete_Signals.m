% =========================================================================
% EXPERIMENT 01 - DSP LAB
% Generation of Basic Trigonometric Signals and Their Classification
%
% Signals:
% 1. Sin(n)
% 2. Cos(n)
% 3. Tan(n)
% 4. Sec(n)
% 5. Csc(n)
% 6. Cot(n)
%
% Classification:
% 1. Discrete-Time / Continuous-Time
% 2. Even / Odd / Neither
% 3. Periodic / Non-Periodic
% 4. Energy / Power / Neither
% =========================================================================

clc;
clear;
close all;

%% ------------------------------------------------------------------------
% Time Index
% -------------------------------------------------------------------------

n = -15:15;

%% ------------------------------------------------------------------------
% Signal Definitions
% -------------------------------------------------------------------------

a = sin(n);
b = cos(n);
c = tan(n);
d = sec(n);
e = csc(n);
f = cot(n);

signals = {a, b, c, d, e, f};

names = {'Sin(n)', 'Cos(n)', 'Tan(n)', ...
         'Sec(n)', 'Csc(n)', 'Cot(n)'};

% Original color scheme
colors = {'r', 'g', 'b', 'k', 'm', 'c'};

%% ------------------------------------------------------------------------
% Figure: Stem Plots
% -------------------------------------------------------------------------

figure('Name', 'Basic Trigonometric Discrete-Time Signals', ...
       'NumberTitle', 'off');

for k = 1:6

    subplot(3,2,k);

    stem(n, signals{k}, colors{k}, 'filled');

    title(names{k});
    xlabel('n');
    ylabel('Amplitude');

    grid on;
    axis tight;

end

sgtitle('Basic Trigonometric Discrete-Time Signals');

%% ------------------------------------------------------------------------
% Signal Classification
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('===============================================================================================\n');
fprintf('                    TRIGONOMETRIC SIGNAL CLASSIFICATION TABLE\n');
fprintf('===============================================================================================\n');

fprintf('%-10s | %-12s | %-14s | %-18s | %-30s\n', ...
        'Signal', ...
        'Time Type', ...
        'Symmetry', ...
        'Periodicity', ...
        'Energy / Power');

fprintf('-----------------------------------------------------------------------------------------------\n');

results = cell(6,5);

for k = 1:6

    x = signals{k};

    [timeType, symType, periodicity, epType] = ...
        classifySignal(x, n);

    results(k,:) = {names{k}, ...
                    timeType, ...
                    symType, ...
                    periodicity, ...
                    epType};

    fprintf('%-10s | %-12s | %-14s | %-18s | %-30s\n', ...
            names{k}, ...
            timeType, ...
            symType, ...
            periodicity, ...
            epType);

end

fprintf('===============================================================================================\n');

%% ------------------------------------------------------------------------
% Theoretical Notes
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('THEORETICAL NOTES\n');
fprintf('===============================================================================================\n');

fprintf('1. sin(n) is an odd, non-periodic discrete-time signal.\n');
fprintf('2. cos(n) is an even, non-periodic discrete-time signal.\n');
fprintf('3. tan(n) is an odd, non-periodic discrete-time signal.\n');
fprintf('4. sec(n) is an even, non-periodic discrete-time signal.\n');
fprintf('5. csc(n) is an odd, non-periodic discrete-time signal.\n');
fprintf('6. cot(n) is an odd, non-periodic discrete-time signal.\n');

fprintf('\n');
fprintf('Energy/Power classification is based on the theoretical infinite-duration\n');
fprintf('definitions rather than the finite plotting interval n = -15 to 15.\n');

fprintf('===============================================================================================\n');
fprintf('\n');

fprintf('Experiment 01 completed successfully.\n');

%% ------------------------------------------------------------------------
% Local Function
% -------------------------------------------------------------------------

function [timeType, symType, periodicity, epType] = classifySignal(x, n)

    %% 1. Time Classification

    % n contains integer sample indices.
    timeType = 'Discrete';


    %% 2. Even / Odd Classification

    % Since n = -15:15 is symmetric about zero,
    % reversing the sequence gives x[-n].

    x_flipped = fliplr(x);

    % Ignore non-finite numerical values near singularities.
    valid = isfinite(x) & isfinite(x_flipped);

    tol = 1e-6;

    if all(abs(x(valid) - x_flipped(valid)) < tol)

        symType = 'Even';

    elseif all(abs(x(valid) + x_flipped(valid)) < tol)

        symType = 'Odd';

    else

        symType = 'Neither';

    end


    %% 3. Periodicity Classification

    % For a discrete-time sinusoidal signal:
    %
    % x[n] = sin(w0*n)
    %
    % the signal is periodic only when:
    %
    % w0/(2*pi) = rational number.
    %
    % Here:
    %
    % w0 = 1 rad/sample
    %
    % Therefore:
    %
    % 1/(2*pi) is irrational.
    %
    % Hence sin(n) and cos(n) are non-periodic.
    %
    % tan(n), sec(n), csc(n), and cot(n) have periods involving
    % pi, but pi is not an integer. Therefore they are also
    % non-periodic discrete-time sequences.

    periodicity = 'Non-Periodic';


    %% 4. Energy / Power Classification

    % These trigonometric signals do not have finite total energy.
    %
    % sin(n) and cos(n):
    % Their squared values do not produce a convergent energy sum.
    %
    % tan(n), sec(n), csc(n), and cot(n):
    % These signals contain singularities and become unbounded.
    %
    % Therefore, for this experiment they are classified as
    % neither finite-energy nor finite-power signals.

    epType = 'Neither';

end
