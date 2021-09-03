% 3.1
% Использование обобщенно-регрессионной нейронной сети
t0 = 0;
tn = 2;
h = 0.01;
n = (tn - t0) / h + 1;

t = t0:h:tn;
x = sin(0.5 * (t.^2) - 5 * t);

% 3.2
% Инициализация сети
spread = h;
[trainInd, testInd] = dividerand(n, .8, .2);
net = newgrnn(t, x, spread);
view(net);

y = sim(net, t);
fprintf('Error on train: %d\n', sqrt(mse(x(trainInd) - y(trainInd))));
fprintf('Error on test: %d\n',sqrt(mse(x(testInd) - y(testInd))));
 
% 3.5
figure
referenceLine = plot(t, x, 'r');

hold on;
approximationLine = plot(t, y, '-b');

grid on;
legend([referenceLine,approximationLine],'reference line', 'approximation line');
title("Comparsion");

figure;
plot(t, x - y, 'r');
title("Error");
grid on

net = newgrnn(t(trainInd), x(trainInd), spread);
y = sim(net, t);
figure
referenceLine = plot(t, x, 'r');
set(referenceLine, 'linewidth', 4);

hold on;
approximationLine = plot(t, y, '--b');
set(approximationLine, 'linewidth', 4);

grid on;
legend([referenceLine,approximationLine],'reference line', 'approximation line');
title("Comparsion");

figure;
plot(t, x - y, 'r');
title("Error");
grid on;