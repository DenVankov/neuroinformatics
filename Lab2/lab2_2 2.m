% 2.1
% Задание входной последовательности
h = 0.025;

X = 0:h:6;
Y = sin((X.^2) - 6 * X + 3);

Pn = con2seq(Y);

% 2.2
% Инициализация задержки и скорости обучения
delays = [1 2 3];
net = newlin([-1 1], 1, delays, maxlinlr(cell2mat(Pn),'bias'));

% 2.3
% Инициализация сети
net.inputweights{1,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net = init(net);

% 2.4
% Обучение на 600 эпохах
Pi = con2seq(Y(1:3));
P = Pn(4:end);
T = Pn(4:end);

net.trainParam.epochs = 600;
net.trainParam.goal = 0.000001;
net = adapt(net, P, T, Pi);
net = train(net, P, T);
E = cell2mat(Pn) - cell2mat(sim(net, Pn));

figure
plot(X, E, 'r');
title('Error');

figure
referenceLine = plot(X, Y, 'r');
hold on;

% 2.6
predictionLine = plot(X, cell2mat(sim(net, Pn)), 'b');

legend([referenceLine,predictionLine],'Target', 'Predicted');
title('Comparsion')
hold off;

% 2.7
X = 0:h:15;
Y = sin((X.^2) - 6 * X + 3);
Pn = con2seq(Y);

E = cell2mat(Pn) - cell2mat(sim(net, Pn));

figure
plot(X, E, 'r');
title('Error');

figure
referenceLine = plot(X, Y, 'r');
hold on;

predictionLine = plot(X, cell2mat(sim(net, Pn)), 'b');

legend([referenceLine,predictionLine],'Target', 'Predicted');
title('Comparsion')
hold off;
