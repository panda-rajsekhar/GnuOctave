function y = circconv_fft(x, h, N)
% CIRCCONV_FFT  Circular convolution of x and h using FFT (vectorized).
%
%   y = circconv_fft(x, h, N) computes the N-point circular convolution
%   of vectors x and h. If N is omitted, N = max(length(x), length(h)).
%
%   Both x and h are automatically zero-padded (or truncated) to length N
%   by fft(), so no manual padding is required.
%
%   Complexity: O(N log N)  (vs O(N^2) for a direct time-domain sum)

    if nargin < 3
        N = max(length(x), length(h));
    end

    X = fft(x, N);
    H = fft(h, N);
    y = real(ifft(X .* H));
end
