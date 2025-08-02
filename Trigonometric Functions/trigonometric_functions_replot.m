x = 0:pi/100:2*pi;

subplot(3,2,1);
plot(x, sin(x));
legend('sin(x)');
title('sin(x)');
grid on;

subplot(3,2,2);
plot(x, cos(x));
legend('cos(x)');
title('cos(x)');
grid on;

% tan(x), mask where cos(x) is near 0
a = tan(x);
a(abs(cos(x)) < 0.01) = NaN;
subplot(3,2,3);
plot(x, a);
legend('tan(x)');
title('tan(x)');
ylim([-10 10]);
grid on;

% csc(x), mask where sin(x) is near 0
b = 1 ./ sin(x);
b(abs(sin(x)) < 0.01) = NaN;
subplot(3,2,4);
plot(x, b);
legend('csc(x)');
title('csc(x)');
ylim([-10 10]);
grid on;

% sec(x), mask where cos(x) is near 0
c = 1 ./ cos(x);
c(abs(cos(x)) < 0.01) = NaN;
subplot(3,2,5);
plot(x, c);
legend('sec(x)');
title('sec(x)');
ylim([-10 10]);
grid on;

% cot(x), mask where sin(x) is near 0
d = cot(x);
d(abs(sin(x)) < 0.01) = NaN;
subplot(3,2,6);
plot(x, d);
legend('cot(x)');
title('cot(x)');
ylim([-10 10]);
grid on;

