% 2.1
% Формируем множество случайных точек в 8 классов
X = [0 1.5;
     0 1.5];
clusters = 8;
points = 10;
deviation = 0.1;
P = nngenc(X, clusters, points, deviation);

% 2.2
% Создаем сеть
net = newsom(X, [2 4]);
net.trainParam.epochs = 300;

net = selforgmap([2 4],'topologyFcn','hextop','distanceFcn','linkdist');

net = configure(net, X);

% 2.3
% Обучаем
net.divideFcn = '';
net = train(net, P);

figure(5)
plotsomhits(net,P)
figure(6)
plotsompos(net,P)

% 2.5
% Проверяем качество разбиения
R = zeros(2, 5) + 1.5 * rand(2, 5);
res = vec2ind(sim(net, R));

figure;
hold on;
grid on;
scatter(P(1, :), P(2, :), 5, [0 1 0], 'filled');
scatter(net.IW{1}(:, 1), net.IW{1}(:, 2), 5, [0 0 1], 'filled');
scatter(R(1, :), R(2, :), 5, [1 0 0], 'filled');
plotsom(net.IW{1, 1}, net.layers{1}.distances);
