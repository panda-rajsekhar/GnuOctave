n = input('Enter the Number: ');

% Validate input
if ~isscalar(n) || ~isfinite(n) || n ~= floor(n) || n < 1
    error('Please enter a positive integer n >= 1.');
end

% Preallocate and seed
fibo = zeros(1, n);
fibo(1) = 0;
if n > 1
    fibo(2) = 1;
end

% Generate
for i = 3:n
    fibo(i) = fibo(i-1) + fibo(i-2);
end

disp('Fibonacci sequence:');
disp(fibo);

