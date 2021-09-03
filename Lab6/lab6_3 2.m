%3.1
N = 20;
T = -1.5 * ones(2, N) + 3 * rand(2, N);

figure;
hold on;
grid on;
plot(T(1,:), T(2,:), '-V', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);

% 3.3
% Создаем и обучаем
net = selforgmap(N);
net = configure(net, T);
view(net);
net.divideFcn = '';
net.trainParam.epochs = 600;
net = train(net, T);

% 3.4
% Координаты городов и центры кластеров
figure;
hold on;
grid on;
plotsom(net.IW{1,1}, net.layers{1}.distances);
plot(T(1,:), T(2,:), 'V', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
