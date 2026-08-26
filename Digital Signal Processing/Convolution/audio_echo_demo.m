function audio_echo_demo()
% AUDIO_ECHO_DEMO  Real-world demonstration: simulate an echo/reverb
%   effect by convolving a synthetic "signal" with an impulse response
%   (a decaying echo pattern), comparing linear vs (non-padded) circular
%   convolution to show how circular wraparound corrupts the result --
%   this is exactly why real DSP systems (e.g. overlap-add/overlap-save)
%   must zero-pad before using FFT-based fast convolution.
%
%   No audio toolbox / microphone required -- signal is synthesized so
%   this runs on any Octave install. If you have a .wav file, you can
%   substitute it in (see comment below).

    addpath('utils');
    if ~exist('outputs','dir'), mkdir('outputs'); end

    Fs = 8000;                 % sample rate (Hz)
    t  = 0:1/Fs:0.5;           % 0.5 second synthetic "signal"
    x  = sin(2*pi*440*t) .* exp(-3*t);   % decaying 440 Hz tone (like a plucked note)

    % ---- To use a real audio file instead, uncomment: ----
    % [x, Fs] = audioread('your_file.wav');
    % x = x(:,1)';  % use first channel, row vector

    % ---- Impulse response: simple decaying echo (3 repeats) ----
    echo_delay_sec = 0.08;
    delay_samples  = round(echo_delay_sec * Fs);
    h = zeros(1, 3*delay_samples);
    h(1)                 = 1.0;    % direct sound
    h(delay_samples)     = 0.6;    % 1st echo
    h(2*delay_samples)   = 0.35;   % 2nd echo
    h(3*delay_samples)   = 0.15;   % 3rd echo

    Nx = length(x); Nh = length(h);
    N_full = Nx + Nh - 1;

    fprintf('Signal length Nx = %d samples (%.2f s)\n', Nx, Nx/Fs);
    fprintf('Impulse response length Nh = %d samples\n', Nh);

    % ---- Linear convolution: correct echo effect ----
    tic; y_lin = conv(x, h); t1 = toc;
    fprintf('Linear convolution time: %.4f s\n', t1);

    % ---- Circular convolution WITHOUT padding (N = Nx): causes wraparound ----
    tic; y_circ_bad = circconv_fft(x, h, Nx); t2 = toc;
    fprintf('Circular (no padding) time: %.4f s  <-- WRAPAROUND DISTORTION EXPECTED\n', t2);

    % ---- Circular convolution WITH proper zero-padding: matches linear ----
    tic; y_circ_good = circconv_fft(x, h, N_full); t3 = toc;
    fprintf('Circular (zero-padded) time: %.4f s  <-- matches linear conv\n', t3);

    err = max(abs(y_lin - y_circ_good));
    fprintf('Max error, linear vs zero-padded circular: %.4e\n\n', err);

    % ---- Save audio outputs (normalize to avoid clipping) ----
    norm_and_write(x,           Fs, 'outputs/audio_dry.wav');
    norm_and_write(y_lin,       Fs, 'outputs/audio_echo_linear.wav');
    norm_and_write(y_circ_bad,  Fs, 'outputs/audio_echo_circular_BAD.wav');
    norm_and_write(y_circ_good, Fs, 'outputs/audio_echo_circular_good.wav');
    fprintf('Audio files saved in outputs/ (dry, linear echo, bad circular echo, correct circular echo)\n\n');

    % ---- Plot comparison ----
    figure('Name','Audio Echo Demo: Linear vs Circular Convolution','NumberTitle','off', ...
           'Position',[100 100 900 700]);

    subplot(4,1,1);
    plot(t, x, 'b'); title('Original Dry Signal x[n] (decaying 440 Hz tone)');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;

    subplot(4,1,2);
    tl = (0:length(y_lin)-1)/Fs;
    plot(tl, y_lin, 'k'); title('Linear Convolution (correct echo effect)');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;

    subplot(4,1,3);
    tc = (0:length(y_circ_bad)-1)/Fs;
    plot(tc, y_circ_bad, 'r'); title('Circular Convolution, NOT zero-padded (WRAPAROUND ARTIFACT)');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;

    subplot(4,1,4);
    tg = (0:length(y_circ_good)-1)/Fs;
    plot(tg, y_circ_good, 'g'); title('Circular Convolution, zero-padded (matches linear)');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;

    saveas(gcf, 'outputs/audio_echo_comparison.png');
    fprintf('Comparison plot saved to outputs/audio_echo_comparison.png\n');
end

function norm_and_write(sig, Fs, filename)
    m = max(abs(sig));
    if m > 0
        sig = sig / m * 0.95;   % normalize to avoid clipping, leave headroom
    end
    audiowrite(filename, sig, Fs);
end
