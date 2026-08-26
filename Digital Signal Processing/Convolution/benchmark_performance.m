function benchmark_performance()
% BENCHMARK_PERFORMANCE  Compare execution time of a direct (O(N^2))
%   time-domain circular convolution against the FFT-based (O(N log N))
%   circconv_fft, across increasing sequence lengths. Plots time vs N
%   and saves the figure to outputs/benchmark.png

    addpath('utils');
    if ~exist('outputs','dir'), mkdir('outputs'); end

    sizes = [8 16 32 64 128 256 512 1024 2048];
    t_direct = zeros(size(sizes));
    t_fft    = zeros(size(sizes));

    fprintf('%-8s %-16s %-16s\n', 'N', 'Direct (s)', 'FFT (s)');
    fprintf('%s\n', repmat('-', 1, 42));

    for i = 1:length(sizes)
        N = sizes(i);
        x = rand(1, N);
        h = rand(1, N);

        % ---- Direct O(N^2) circular convolution ----
        tic;
        y_direct = zeros(1, N);
        for n = 0:N-1
            s = 0;
            for k = 0:N-1
                idx = mod(n-k, N) + 1;
                s = s + x(k+1) * h(idx);
            end
            y_direct(n+1) = s;
        end
        t_direct(i) = toc;

        % ---- FFT-based O(N log N) circular convolution ----
        tic;
        y_fft = circconv_fft(x, h, N);
        t_fft(i) = toc;

        fprintf('%-8d %-16.6f %-16.6f\n', N, t_direct(i), t_fft(i));
    end

    figure('Name','Performance Benchmark: Direct vs FFT Convolution','NumberTitle','off');
    loglog(sizes, t_direct, 'o-r','LineWidth',1.5,'MarkerFaceColor','r'); hold on;
    loglog(sizes, t_fft,    's-b','LineWidth',1.5,'MarkerFaceColor','b');
    grid on;
    xlabel('Sequence Length N (log scale)');
    ylabel('Execution Time (seconds, log scale)');
    title('Direct O(N^2) vs FFT O(N log N) Circular Convolution');
    legend('Direct (time-domain)','FFT-based','Location','northwest');

    saveas(gcf, 'outputs/benchmark.png');
    fprintf('\nBenchmark plot saved to outputs/benchmark.png\n');
end
