clc;
clear;
close all;

fm = 100;
Am = 1;
t = 0:0.00001:0.03;
x = Am*sin(2*pi*fm*t);

fs = 2000;
Ts = 1/fs;
ts = 0:Ts:0.03;
xs = Am*sin(2*pi*fm*ts);

N = length(xs);

delta = 0.15;
x_dm = zeros(1,N);
e_dm = zeros(1,N);
step = delta;

for i = 2:N
    if xs(i) >= x_dm(i-1)
        x_dm(i) = x_dm(i-1) + delta;
    else
        x_dm(i) = x_dm(i-1) - delta;
    end

    e_dm(i) = xs(i)-x_dm(i);
end

x_adm = zeros(1,N);
e_adm = zeros(1,N);
delta_adm = zeros(1,N);

delta_min = 0.02;
delta_max = 0.5;
delta0 = 0.05;
factor = 1.5;

delta_adm(1) = delta0;

for i = 2:N

    if xs(i) >= x_adm(i-1)
        x_adm(i) = x_adm(i-1) + delta_adm(i-1);
    else
        x_adm(i) = x_adm(i-1) - delta_adm(i-1);
    end

    e_adm(i) = xs(i)-x_adm(i);

    if i >= 3
        if (xs(i)-xs(i-1))*(xs(i-1)-xs(i-2)) > 0
            delta_adm(i) = min(delta_adm(i-1)*factor,delta_max);
        else
            delta_adm(i) = max(delta_adm(i-1)/factor,delta_min);
        end
    else
        delta_adm(i) = delta_adm(i-1);
    end
end

xr_dm = interp1(ts,x_dm,t,'previous','extrap');
xr_adm = interp1(ts,x_adm,t,'previous','extrap');

figure('Name','Delta Modulation','Color','w');

subplot(3,1,1);
plot(t,x,'b','LineWidth',1.5);
hold on;
stem(ts,xs,'r','filled');
grid on;
title('Input and Sampled Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input Signal','Sampled Signal');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

subplot(3,1,2);
plot(t,x,'b','LineWidth',1.5);
hold on;
stairs(t,xr_dm,'r','LineWidth',1.5);
grid on;
title('Delta Modulation');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input Signal','DM Staircase Approximation');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

subplot(3,1,3);
stem(ts,e_dm,'m','filled');
grid on;
title('Delta Modulation Quantization Error');
xlabel('Time (seconds)');
ylabel('Error');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

figure('Name','Adaptive Delta Modulation','Color','w');

subplot(4,1,1);
plot(t,x,'b','LineWidth',1.5);
hold on;
stem(ts,xs,'r','filled');
grid on;
title('Input and Sampled Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input Signal','Sampled Signal');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

subplot(4,1,2);
plot(t,x,'b','LineWidth',1.5);
hold on;
stairs(t,xr_adm,'r','LineWidth',1.5);
grid on;
title('Adaptive Delta Modulation');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input Signal','ADM Staircase Approximation');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

subplot(4,1,3);
stem(ts,e_adm,'m','filled');
grid on;
title('Adaptive Delta Modulation Quantization Error');
xlabel('Time (seconds)');
ylabel('Error');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

subplot(4,1,4);
stairs(ts,delta_adm,'k','LineWidth',1.5);
grid on;
title('Adaptive Step Size');
xlabel('Time (seconds)');
ylabel('Step Size');

text(0.5,0.5,'240106010052','Units','normalized',...
'HorizontalAlignment','center',...
'VerticalAlignment','middle',...
'FontSize',18,'FontWeight','bold',...
'Color',[0.82 0.82 0.82],'Rotation',35);

fprintf('Delta Modulation Step Size = %f\n',delta);
fprintf('Adaptive Delta Minimum Step Size = %f\n',delta_min);
fprintf('Adaptive Delta Maximum Step Size = %f\n',delta_max);