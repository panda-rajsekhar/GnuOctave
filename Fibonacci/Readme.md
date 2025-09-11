
# Fibonacci Sequence Generator in MATLAB

## Overview
This MATLAB script generates the Fibonacci sequence up to the nth term, where `n` is a user-provided positive integer. The Fibonacci sequence is a series of numbers where each number is the sum of the two preceding ones, starting with 0 and 1.

## Code Explanation
The script performs the following steps:

1. **User Input**:
   - Prompts the user to enter a number `n` using the `input` function.
   - The input is stored as a string and converted to a numeric value.

2. **Input Validation**:
   - Checks if the input `n` is:
     - A scalar (single value).
     - Finite (not `Inf` or `NaN`).
     - An integer (equal to its floor value).
     - Positive (greater than or equal to 1).
   - If any condition is not met, the script throws an error with a descriptive message.

3. **Sequence Initialization**:
   - Preallocates an array `fibo` of size `1 x n` filled with zeros to store the Fibonacci sequence.
   - Sets the first term `fibo(1)` to 0.
   - If `n > 1`, sets the second term `fibo(2)` to 1.

4. **Sequence Generation**:
   - Uses a `for` loop to generate subsequent Fibonacci numbers starting from the third term (`i = 3`).
   - Each term is calculated as the sum of the two previous terms: `fibo(i) = fibo(i-1) + fibo(i-2)`.

5. **Output**:
   - Displays the label "Fibonacci sequence:".
   - Outputs the generated sequence using the `disp` function.

## Usage
1. Save the script as `fibonacci.m` (or any preferred name).
2. Run the script in MATLAB.
3. Enter a positive integer when prompted (e.g., `5`).
4. The script will output the Fibonacci sequence up to the nth term.
