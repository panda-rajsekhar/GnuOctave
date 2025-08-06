%{
In this program we will be plotting the Exponential Funciton in both the Continuous and
Discrete Time.
%}


%--Continuous  Exponential Funciton

%Define the x values
x = -5:0.1:5;

%Define the exponential function y = exp(x)
y = exp(x);

%Plot the Funciton
figure;
subplot(2,1,1);
plot(x,y,'b', 'LineWidth', 1);
grid on;
xlabel('x');
ylabel('exp(x)');
title('Continuous Exponential Function');


%--Discrete Exponential Function

%Define the Discrete Domain
d = 0:20;

%Now define the parameter of the discrete exponential function
a = 1.5; %base of the exp funciton
z = a.^d;%element wise exponentiation

%now plotting the exponential function with stem
subplot(2,1,2);
stem(d,z,'r', 'filled');
grid on;
xlabel('n');
ylabel('a^n');
title('Discrete Exponential Function');

