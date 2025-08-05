GNU Octave provides a wide range of **matrix-related functions and formulas**, especially since it is designed to be mostly compatible with MATLAB. Below is a categorized list of the **most commonly used matrix formulas, operations, and functions** in Octave, suitable for reference or study.

---

##  **Matrix Creation**

```octave
A = [1, 2; 3, 4];     % 2x2 matrix
zeros(n, m)           % n×m matrix of zeros
ones(n, m)            % n×m matrix of ones
eye(n)                % n×n identity matrix
rand(n, m)            % n×m matrix of uniform random numbers
randn(n, m)           % n×m matrix of normal random numbers
diag(v)               % creates diagonal matrix from vector v
repmat(A, m, n)       % repeats A m times vertically and n times horizontally
linspace(a, b, n)     % row vector of n points between a and b
```

---

##  **Matrix Operations**

```octave
B = A';               % Transpose
B = A.';              % Non-conjugate transpose (for complex)
C = A + B;            % Matrix addition
C = A - B;            % Matrix subtraction
C = A * B;            % Matrix multiplication
C = A .* B;           % Element-wise multiplication
C = A ./ B;           % Element-wise division
C = A .^ 2;           % Element-wise power
inv(A)                % Inverse of matrix
pinv(A)               % Pseudo-inverse
det(A)                % Determinant
rank(A)               % Rank
trace(A)              % Trace (sum of diagonal)
norm(A)               % Norm (default is 2-norm)
```

---

## **Solving Equations**

```octave
x = A \ b;            % Solves Ax = b
x = linsolve(A, b)    % Another way to solve Ax = b
```

---

##  **Matrix Decompositions**

```octave
[L, U] = lu(A);                   % LU decomposition
[Q, R] = qr(A);                   % QR decomposition
[U, S, V] = svd(A);               % Singular value decomposition
[P, L, U] = lu(A);                % With pivoting
[vec, val] = eig(A);              % Eigenvalues and eigenvectors
chol(A)                          % Cholesky decomposition (A must be SPD)
```

---

##  **Matrix Dimensions and Shape**

```octave
size(A)                % Returns [rows, cols]
length(A)              % Length of the largest dimension
numel(A)               % Number of elements
ndims(A)               % Number of dimensions
rows(A)                % Number of rows
columns(A)             % Number of columns
reshape(A, m, n)       % Change shape to m×n
```

---

##  **Matrix Manipulation**

```octave
A(:)                  % Convert to column vector
A = A(:)              % Flatten to column vector
A = reshape(A, m, n)  % Reshape matrix
flipud(A)             % Flip up-down
fliplr(A)             % Flip left-right
rot90(A)              % Rotate 90 degrees
sort(A)               % Sort columns
sortrows(A)           % Sort rows
```

---

##  **Indexing and Logical Operations**

```octave
A(i, j)               % Element at row i, column j
A(:, j)               % All rows, column j
A(i, :)               % Row i, all columns
A(2:end, :)           % Submatrix from row 2
find(A > 0)           % Indices of positive elements
any(A), all(A)        % Logical any/all
```

---

## **Matrix Utilities**

```octave
isnan(A)              % Check for NaN
isinf(A)              % Check for Inf
isempty(A)            % Check if matrix is empty
issquare(A)           % Check if square
isvector(A)           % Check if vector
ismatrix(A)           % Check if matrix
diag(A)               % Extract diagonal
triu(A)               % Upper triangle
tril(A)               % Lower triangle
```

---

##  **Special Matrices**

```octave
magic(n)              % Magic square matrix
hilb(n)               % Hilbert matrix
pascal(n)             % Pascal matrix
toeplitz(c, r)        % Toeplitz matrix
hankel(c, r)          % Hankel matrix
gallery('moler', n)   % Test matrices
```

---

##  **Advanced Functions**

```octave
expm(A)               % Matrix exponential
logm(A)               % Matrix logarithm
sqrtm(A)              % Matrix square root
sinm(A), cosm(A)      % Matrix sine/cosine
kron(A, B)            % Kronecker product
blkdiag(A, B)         % Block diagonal matrix
```

---

