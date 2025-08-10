%In this program we will learn to code doraemon (a cartoon) using the power of matlab

% A dedicated readme file is being prepared to explain the code in detail

figure; %Opens a new graphical window
hold on; %Allows multiple graphical objects to be drawn on the same figure
axis equal; %It ensures equal scaling on both of the axes
axis off; %It handles the axis lines and ticks
title('Doraemon in GNU OCTAVE-MATLAB'); %As the name suggests add the title

%% Colors (we will be defining custom RGB color values to different parts of the subject)
blue    = [0.0, 0.6, 1.0];   % Body
white   = [1, 1, 1];         % Face & belly
red     = [1, 0, 0];         % Nose
yellow  = [1, 1, 0];         % Bell
black   = [0, 0, 0];         % Outline

t = linspace(0, 2*pi, 200); %It generates 200 evenly spaced angles between 0 to 2 pi , which is used to draw circles and ellipses

%% Head (blue)
fill(0 + 5*cos(t), 0 + 5*sin(t), blue, 'EdgeColor', black, 'LineWidth', 2); %It draws a blue circle with a radius of 5 units centered at the origin , representing the head

%% Face (white)
fill(0 + 4*cos(t), 0 + 4*sin(t), white, 'EdgeColor', black, 'LineWidth', 2); %It draws a smaller white circle with the radius 4 units placed inside the blue circle to represent the face

%% Eyes
% We will be drawing ellipses to make the eyes
fill(-1 + 1*cos(t), 2 + 1.3*sin(t), white, 'EdgeColor', black, 'LineWidth', 1.5);
fill( 1 + 1*cos(t), 2 + 1.3*sin(t), white, 'EdgeColor', black, 'LineWidth', 1.5);

% Pupils
fill(-0.5 + 0.3*cos(t), 2 + 0.4*sin(t), black);
fill( 0.5 + 0.3*cos(t), 2 + 0.4*sin(t), black);

%% Nose (red)
fill(0 + 0.5*cos(t), 1 + 0.5*sin(t), red, 'EdgeColor', black, 'LineWidth', 1.5);

% Mouth vertical line
plot([0, 0], [0.5, -1.5], 'k', 'LineWidth', 1.5);

%% Mouth - adjusted for symmetry and position
% Vertical line
plot([0, 0], [0.5, -2.0], 'k', 'LineWidth', 1.5);

% Symmetric smile arc
smile_theta = linspace(-pi/6, -5*pi/6, 100); % wider arc
smile_radius = 2.8;
smile_center = [0, -0.15]; % center below the vertical line end
plot(smile_center(1) + smile_radius*cos(smile_theta), ...
     smile_center(2) + smile_radius*sin(smile_theta), ...
     'k', 'LineWidth', 2);


%% Whiskers - moved lower by 0.5 units
% Left whiskers
plot([-4, -1.5], [1, 0.5], 'k', 'LineWidth', 1.5);
plot([-4, -1.5], [0, 0], 'k', 'LineWidth', 1.5);
plot([-4, -1.5], [-1, -0.5], 'k', 'LineWidth', 1.5);
% Right whiskers
plot([4, 1.5], [1, 0.5], 'k', 'LineWidth', 1.5);
plot([4, 1.5], [0, 0], 'k', 'LineWidth', 1.5);
plot([4, 1.5], [-1, -0.5], 'k', 'LineWidth', 1.5);

%% Collar
collar_y = -4.2;
fill([-3 3 3 -3], [collar_y collar_y -5 -5], red, 'EdgeColor', black, 'LineWidth', 2);

%% Bell
fill(0 + 0.7*cos(t), -4.7 + 0.7*sin(t), yellow, 'EdgeColor', black, 'LineWidth', 1.5);
plot([0, 0], [-4.7, -5.3], 'k', 'LineWidth', 2);

hold off;

