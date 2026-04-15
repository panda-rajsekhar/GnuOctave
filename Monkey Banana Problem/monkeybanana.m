clear; clc; close all;

% ---------------- ENVIRONMENT ----------------
door = [0, 1.5];
window = [4, 1.5];
middle = [2, 1.5];

banana_pos = [2, 1.5, 3.5];
box_height = 1.5;

% ---------------- INITIAL STATE ----------------
monkey_pos = [door, 0];
box_pos = [window, 0];
has_banana = false;

% ---------------- DRAW FUNCTION ----------------
function draw_scene(monkey_pos, box_pos, has_banana, banana_pos, box_height, title_text)

    clf; hold on; grid on;
    view(45, 25);

    xlim([0 5]); ylim([0 3]); zlim([0 4]);

    xlabel("X"); ylabel("Y"); zlabel("Z");
    title(title_text);

    % Floor
    fill3([0 5 5 0], [0 0 3 3], [0 0 0 0], [0.9 0.9 0.9]);

    % Banana (hanging)
    scatter3(banana_pos(1), banana_pos(2), banana_pos(3), 200, 'y', 'filled');

    % Draw box (3D cube)
    bx = box_pos(1); by = box_pos(2);
    h = box_height;

    X = [bx-0.3 bx+0.3 bx+0.3 bx-0.3 bx-0.3 bx+0.3 bx+0.3 bx-0.3];
    Y = [by-0.3 by-0.3 by+0.3 by+0.3 by-0.3 by-0.3 by+0.3 by+0.3];
    Z = [0 0 0 0 h h h h];

    faces = [1 2 3 4;
             5 6 7 8;
             1 2 6 5;
             2 3 7 6;
             3 4 8 7;
             4 1 5 8];

    patch('Vertices',[X' Y' Z'], 'Faces',faces, ...
          'FaceColor','blue','FaceAlpha',0.6);

    % Monkey
    if has_banana
        color = 'g';
    else
        color = 'r';
    end

    scatter3(monkey_pos(1), monkey_pos(2), monkey_pos(3)+0.3, ...
             150, color, 'filled');

    % Banana in hand
    if has_banana
        scatter3(monkey_pos(1), monkey_pos(2), monkey_pos(3)+0.8, ...
                 120, 'y', 'filled');
    end

    pause(0.05);
end

% ---------------- SMOOTH MOVE FUNCTION ----------------
function pos = move_smooth(start_pos, end_pos, steps)
    pos = zeros(steps, 3);
    for i = 1:steps
        t = i / steps;
        pos(i, :) = start_pos * (1 - t) + end_pos * t;
    end
end

% ---------------- SIMULATION ----------------
disp("🐵🍌 3D MONKEY BANANA SIMULATION 🍌🐵");

% Step 1: Move monkey to box
path = move_smooth(monkey_pos, [box_pos(1), box_pos(2), 0], 50);
for i = 1:size(path,1)
    monkey_pos = path(i,:);
    draw_scene(monkey_pos, box_pos, has_banana, banana_pos, box_height, "Moving to Box");
end

% Step 2: Push box to middle
path = move_smooth([box_pos(1), box_pos(2), 0], [middle(1), middle(2), 0], 60);
for i = 1:size(path,1)
    box_pos = path(i,:);
    monkey_pos = path(i,:);
    draw_scene(monkey_pos, box_pos, has_banana, banana_pos, box_height, "Pushing Box");
end

% Step 3: Climb box
steps = 40;
for i = 1:steps
    monkey_pos(3) = (i/steps) * box_height;
    draw_scene(monkey_pos, box_pos, has_banana, banana_pos, box_height, "Climbing Box");
end

% Step 4: Grab banana
if abs(monkey_pos(1) - banana_pos(1)) < 0.2
    has_banana = true;
end

for i = 1:20
    draw_scene(monkey_pos, box_pos, has_banana, banana_pos, box_height, "Grabbing Banana");
end

% Final
if has_banana
    disp("🎉 GOAL ACHIEVED 🎉");
else
    disp("❌ FAILED");
end
