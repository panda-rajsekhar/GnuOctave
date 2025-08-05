%{
In this program we will be plotting the Continuous Time and the Discrete Time Unit Impulse Function.
The Unit Impulse Function is defined as £_[n] = { 1: if n =0 , 0 : otherwise}
%}

%Discrete Time Unit Impulse Function

n = -10:10;                                    %this creates a vector n of discrete time indices from -10 to 10
x_discrete  = (n==0);                          %returns a logical array of size n, where the element is true (1) only if n = 0 and 0 otherwise

%Plot the discrete time impulse function


subplot(2,1,1);
stem(n,x_discrete,'filled','b');                 %stem is used to plot discrete time signals with vertical lines , this will plot a impulse at n = 0
title('Discrete Time Unit Impulse Function');
xlabel('n');
ylabel('x[n]');
grid on;
axis([-10 10 -0.2 1.2]);


%{
Now lets discuss the continuous time unit impulse function £_(t).
In continuous time the unit function is just not a function but a mathematical distribution called
the Dirac Delta Distribution.  It can not be plotted directly but we can approximate it with a
very narrow pulse of area 1.
For that we will take t vector with very narrow pulse
%}

t = -1:0.00001:1;                                % This creates a vector t representing continuous time values from -1 to 1 with a step of 0.00001

epsilon = 0.01;                                  % This is the width of the narrow pulse. Smaller value of the epsilon gives a narrower and taller pulse kind of like the ideal impulse

x_cont= (abs(t) <epsilon);                       % This creates a rectangular pulse centered at zero. abs(t) < epsilon gives 1 if t is between -epsilon to epsilon and 0 elsewhere

x_cont = x_cont /(2*epsilon);                    % This normalizes the area to be 1


%Now we will be plotting the function
subplot(2,1,2);
plot(t,x_cont,'r');
title('Approximate Continuous Time Unit Impulse £_(t)');
grid on;
axis([-10 10 -0.2 1.2]);






