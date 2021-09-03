% 3.1
% Задание входной последовательности
h = 0.01;
X = 0:h:3.5;

% Входное множество
x = sin(-2 * X.^2 + 7 * X);

% Эталонный выход
Y = 0.125 * sin(-2 * X.^2 + 7 * X - pi);

% 3.2
% Расширение входного множества с глубиной погружения
D = 4;
Q = length(x);
P = zeros(D, Q);

for i=1:D
    P(i, i:Q) = x(1:Q - i + 1);
end

% 3.3
% Иницализация сети
net = newlind(P, Y);

% Вывод полученных весов и смещения
display(["Weights: ", num2str(net.IW{1,1})]);
display(["Biases: ", num2str(net.b{1})]);

T = sim(net, P);

% Погрешность
E = Y - T;

figure
err = plot(X, E, 'r');
title('Error');
legend(err,'Error');

% Эталонные значения
figure
referenceLine = plot(X, Y, 'r');
set(referenceLine, 'linewidth', 3);
hold on;

% Предсказанные значения
approximationLine = plot(X, T, '--b');
set(approximationLine, 'linewidth', 3);
legend([referenceLine,approximationLine],'Target', 'Predicted');
title('Comparsion')
hold off;