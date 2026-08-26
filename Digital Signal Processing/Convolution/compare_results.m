function metrics = compare_results(y_lin, y_circ, save_report)
% COMPARE_RESULTS  Print a results table and error metrics comparing
%   linear convolution output (y_lin) against zero-padded circular
%   convolution output (y_circ). Both must be the same length
%   (N = Nx + Nh - 1) for a fair, exact comparison.
%
%   metrics = compare_results(y_lin, y_circ, save_report)
%   save_report (optional, default false): if true, also writes the
%   table to outputs/comparison_report.csv and outputs/comparison_report.txt
%
%   Returns a struct 'metrics' with fields: max_error, mse, rmse,
%   percent_error.

    if nargin < 3
        save_report = false;
    end

    if length(y_lin) ~= length(y_circ)
        error('compare_results:length', ...
              'y_lin and y_circ must be the same length for exact comparison.');
    end

    N = length(y_lin);
    err = y_lin - y_circ;

    metrics.max_error     = max(abs(err));
    metrics.mse           = mean(err.^2);
    metrics.rmse          = sqrt(metrics.mse);
    denom                 = max(abs(y_lin));
    if denom == 0
        denom = 1; % avoid divide-by-zero for all-zero sequences
    end
    metrics.percent_error = 100 * metrics.max_error / denom;

    % ---- Print results table ----
    fprintf('\n%-5s %-14s %-14s %-12s\n', 'n', 'Linear y[n]', 'Circular y[n]', 'Abs. Error');
    fprintf('%s\n', repmat('-', 1, 48));
    for n = 1:N
        fprintf('%-5d %-14.4f %-14.4f %-12.2e\n', n-1, y_lin(n), y_circ(n), abs(err(n)));
    end
    fprintf('%s\n', repmat('-', 1, 48));

    fprintf('\nMax Absolute Error : %.4e\n', metrics.max_error);
    fprintf('MSE                : %.4e\n', metrics.mse);
    fprintf('RMSE               : %.4e\n', metrics.rmse);
    fprintf('Percent Error       : %.6f %%\n\n', metrics.percent_error);

    if metrics.max_error < 1e-9
        disp('=> Circular convolution (zero-padded) EXACTLY matches linear convolution.');
    else
        disp('=> WARNING: results differ more than expected floating-point tolerance.');
    end

    % ---- Optional: save report to file ----
    if save_report
        if ~exist('outputs', 'dir')
            mkdir('outputs');
        end

        % CSV
        fid = fopen('outputs/comparison_report.csv', 'w');
        fprintf(fid, 'n,Linear_y,Circular_y,AbsError\n');
        for n = 1:N
            fprintf(fid, '%d,%.6f,%.6f,%.6e\n', n-1, y_lin(n), y_circ(n), abs(err(n)));
        end
        fclose(fid);

        % TXT summary
        fid = fopen('outputs/comparison_report.txt', 'w');
        fprintf(fid, 'Linear vs Circular Convolution - Comparison Report\n');
        fprintf(fid, '%s\n\n', datestr(now));
        fprintf(fid, 'Max Absolute Error : %.6e\n', metrics.max_error);
        fprintf(fid, 'MSE                : %.6e\n', metrics.mse);
        fprintf(fid, 'RMSE               : %.6e\n', metrics.rmse);
        fprintf(fid, 'Percent Error      : %.6f %%\n', metrics.percent_error);
        fclose(fid);

        fprintf('Report saved to outputs/comparison_report.csv and .txt\n\n');
    end
end
