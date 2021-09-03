% 1.1
% Генерация обучающего множества
trange = 0 : 0.025 : 2 * pi;
x = ellipse(trange, 0.7, 0.2, 0, -0.1, -pi / 6);
xseq = con2seq(x);

plot(x(1, :), x(2, :), '-r', 'LineWidth', 2);

% 1.2
% Создание сети
net = feedforwardnet(1, 'trainlm');
net.layers{1}.transferFcn = 'purelin';

net = configure(net, xseq, xseq);
net = init(net);
view(net);

% 1.4
% Параметры обучения
net.trainParam.epochs = 100;
net.trainParam.goal = 1.0e-5;

% 1.5
% Обучение
net = train(net, xseq, xseq);
display(net);

% 1.7
% Выход сети
yseq = sim(net, xseq);
y = cell2mat(yseq);

% 1.8
% Отображение обучающего множества
plot(x(1, :), x(2, :), '-r', y(1, :), y(2, :), '-b', 'LineWidth', 2);