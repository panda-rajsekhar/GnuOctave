%{
In this code we will be plotting the continuous time and the discrete time
unit step function.
To do this, we will be :
declaring the time vectors initially
then we will define the signals
then we will be creating the figure
lastly we will be using the subplot to create separate axes
then we will be using the axis function as axis([xmin xmax ymin ymax])
which will make the plot more presentable
%}

%-time
n = -5 : 5 ;%-Discrete time
t = -5:0.01:5;%-Continuous time (fine resolution)

%-signals
u_discrete = n>= 0; %Discrete Unit Step
u_continuous = t>= 0; %Continuous Unit Step

%-create figure
figure;

%----- LeftSubplot:Discrete Time
subplot(2,1,1);
stem(n, u_discrete, 'r', 'filled');
title('Discrete-Time Unit Step u[n]');
xlabel('n');
ylabel('u[n]');
grid on;
axis([-10 10 -0.2 1.2]);


% ----- Right subplot: Continuous Time
subplot(2,1,2);
plot(t, u_continuous, 'b', 'LineWidth', 2);
title('Continuous-Time Unit Step x(t)');
xlabel('t');
ylabel('x(t)');
grid on;
axis([-10 10 -0.2 1.2]);

