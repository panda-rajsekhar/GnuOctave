%{
Here we will create the 2D Plot of basic trigonometric functions like sin, cos, tan, cosec or csc ,sec and cot on the
interval of 0 to 2pi and display them using the subplot function in the layout having 3 rows and two coulumns.
%}

x = 0:pi/100:2*pi ;
%the variable x is defined as a vector from 0 to 2pi in  increment of pi/100
%this gives a smooth curve when plotting the functions

%2D subplot of sin x
y = sin(x);
subplot(3,2,1);
plot(x,y)
legend('sin(x)');
hold
%{
the above piece of code calculates sin(x) and  the value is stored in the variable
named y (in this case);

then as the name of the subplot suggests it creates the plot in 3 row and 2 columns grid
system;

then the function plot(x,y) plots sin(x) against x;
then the legend function adds the legend which is enclosed in single quote;

then the hold function allows us to plot more on the same axes later ;

we are going to follow the same process to plot the remainig functions ;
%}

%2D plot of cos x
z = cos(x);
subplot(3,2,2);
plot(x,z)
legend('cos(x)');
hold

%2d plot of tan x
a = tan(x);
subplot(3,2,3);
plot(x,a)
legend('tan(x)');
hold

%2D plot of cosec x
b = csc(x);
subplot(3,2,4);
plot(x,b)
legend('csc(x)');
hold

%2D plot of sec x
c = sec(x);
subplot(3,2,5);
plot(x,c)
legend('sec(x)');
hold

%2D plot of cot x
d = cot(x);
subplot(3,2,6);
plot(x,d)
legend('cot(x)');

%issues in  or  some questions that may arise in your minid are dealt in the readme file

