%1.1 
% Формируем множество случайных точек в 8 классов
X = [0 1.5;
     0 1.5];
clusters = 8;
points = 10;
deviation = 0.1;
P = nngenc(X, clusters, points, deviation);

figure;
hold on;
grid on;
scatter(P(1, :), P(2, :), 5, [0 1 0], 'filled');

% 1.3
% Создаем сеть
net = competlayer(8);
net = configure(net, P);
view(net);
net.divideFcn = '';

% 1.4
% Обучаем
net.trainParam.epochs = 50;
net = train(net, P);

% 1.6
% Проверяем качество разбиения
R = zeros(2, 5) + 1.5 * rand(2, 5);
res = vec2ind(sim(net, R));

figure;
hold on;
grid on;
scatter(P(1, :), P(2, :), 5, [0 1 0], 'filled');
scatter(net.IW{1}(:, 1), net.IW{1}(:, 2), 5, [0 0 1], 'filled');
scatter(R(1, :), R(2, :), 5, [1 0 0], 'filled');