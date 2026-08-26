% ================================================================
% MAIN.M -- Linear vs Circular Convolution: Project Entry Point
% ================================================================
%
% Project structure:
%   main.m                     <- you are here
%   linear_conv_demo.m         <- flip-and-slide animation (+ GIF export)
%   circular_conv_demo.m       <- rotating wheel animation (+ GIF export)
%   compare_results.m          <- metrics table (MSE, RMSE, % error) + report
%   benchmark_performance.m    <- Direct O(N^2) vs FFT O(N log N) timing
%   audio_echo_demo.m          <- real-world echo/reverb application demo
%   utils/circconv_fft.m       <- FFT-based circular convolution
%   utils/validate_input.m     <- input sanity checks
%   outputs/                   <- all generated plots, GIFs, reports, audio
%
% Run this file from the project's root folder in Octave.
% ================================================================

clc; clear; close all;
addpath('utils');
if ~exist('outputs', 'dir'), mkdir('outputs'); end

% Ensure a working graphics toolkit is selected (falls back gracefully
% on headless systems / minimal Octave installs where 'qt' is absent).
available_tk = available_graphics_toolkits();
if ismember('qt', available_tk)
    graphics_toolkit('qt');
elseif ismember('gnuplot', available_tk)
    graphics_toolkit('gnuplot');
end

fprintf('==============================================================\n');
fprintf(' LINEAR vs CIRCULAR CONVOLUTION -- DEMONSTRATION PROJECT\n');
fprintf('==============================================================\n\n');

% ---------------------------------------------------------------
% 1) DEFINE & VALIDATE INPUT SEQUENCES
% ---------------------------------------------------------------
% Edit these, or switch to input() prompts for interactive use:
x = [1 2 3 4];
h = [2 1 1];

% Uncomment for interactive keyboard input instead of hardcoded values:
% x = input('Enter x[n] as a vector, e.g. [1 2 3 4]: ');
% h = input('Enter h[n] as a vector, e.g. [2 1 1]: ');

x = validate_input(x, 'x[n]');
h = validate_input(h, 'h[n]');

fprintf('x[n] = '); disp(x);
fprintf('h[n] = '); disp(h);

Nx = length(x); Nh = length(h);
N_full = Nx + Nh - 1;

% ---------------------------------------------------------------
% 2) OPTIONS (toggle features on/off here)
% ---------------------------------------------------------------
opts.animate    = true;    % show step-by-step animations
opts.save_gif   = true;    % export animations as GIFs to outputs/
opts.pause_time = 0.6;     % seconds per animation frame
opts.max_len    = 15;      % auto-skip animation if N_full exceeds this

run_benchmark  = true;     % run Direct vs FFT timing comparison
run_audio_demo = true;     % run real-world echo/reverb demo

% ---------------------------------------------------------------
% 3) LINEAR CONVOLUTION (with animation)
% ---------------------------------------------------------------
fprintf('\n--- Running Linear Convolution Demo ---\n');
y_lin = linear_conv_demo(x, h, opts);

% ---------------------------------------------------------------
% 4) CIRCULAR CONVOLUTION, zero-padded to match linear (with animation)
% ---------------------------------------------------------------
fprintf('\n--- Running Circular Convolution Demo (zero-padded) ---\n');
y_circ_match = circular_conv_demo(x, h, opts);

% ---------------------------------------------------------------
% 5) CIRCULAR CONVOLUTION, minimal length (aliased, no animation needed)
% ---------------------------------------------------------------
N1 = max(Nx, Nh);
y_circ_alias = circconv_fft(x, h, N1);
fprintf('\n--- Circular Convolution (N=%d, ALIASED / no zero-padding) ---\n', N1);
disp(y_circ_alias);

% ---------------------------------------------------------------
% 6) QUANTITATIVE COMPARISON + REPORT
% ---------------------------------------------------------------
fprintf('\n--- Comparing Linear vs Zero-Padded Circular Convolution ---\n');
metrics = compare_results(y_lin, y_circ_match, true);  % true = save report to outputs/

% ---------------------------------------------------------------
% 7) FINAL OVERLAY PLOT
% ---------------------------------------------------------------
figure('Name','Final Comparison','NumberTitle','off');
stem(0:length(y_lin)-1, y_lin, 'filled','k','LineWidth',1.5); hold on;
stem(0:length(y_circ_match)-1, y_circ_match, 'og','LineWidth',1.5);
legend('Linear Convolution','Circular Convolution (zero-padded)');
title('Final Comparison: Linear vs Circular Convolution');
xlabel('n'); ylabel('y[n]'); grid on;
saveas(gcf, 'outputs/final_comparison.png');
fprintf('Final comparison plot saved to outputs/final_comparison.png\n');

% ---------------------------------------------------------------
% 8) PERFORMANCE BENCHMARK (Direct O(N^2) vs FFT O(N log N))
% ---------------------------------------------------------------
if run_benchmark
    fprintf('\n--- Running Performance Benchmark ---\n');
    benchmark_performance();
end

% ---------------------------------------------------------------
% 9) REAL-WORLD APPLICATION: AUDIO ECHO/REVERB DEMO
% ---------------------------------------------------------------
if run_audio_demo
    fprintf('\n--- Running Real-World Audio Echo Demo ---\n');
    audio_echo_demo();
end

fprintf('\n==============================================================\n');
fprintf(' ALL DEMOS COMPLETE. Check the outputs/ folder for:\n');
fprintf('   - linear_conv.gif, circular_conv.gif   (animations)\n');
fprintf('   - comparison_report.csv / .txt          (metrics)\n');
fprintf('   - benchmark.png                         (timing plot)\n');
fprintf('   - audio_*.wav, audio_echo_comparison.png (echo demo)\n');
fprintf('   - final_comparison.png\n');
fprintf('==============================================================\n');
