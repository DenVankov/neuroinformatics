% 3.1
% Генерация обучающего множества
phi = 0 : 0.025 : 2 * pi;
r = phi.*2;
x = [r .* cos(phi); r .* sin(phi); phi];
xseq = con2seq(x);

plot3(x(1, :), x(2, :), x(3, :), '-r', 'LineWidth', 2);

% 3.2
% Создание сети
net = feedforwardnet([10 2 10], 'trainlm');
net = configure(net, xseq, xseq);

% 3.3
% Инициализация весовых коэффициентов
net = init(net);
view(net);

% 3.4
% Параметры обучения
net.trainParam.epochs = 100;
net.trainParam.goal = 1.0e-5;

% 3.5
% Обучение сети
net = train(net, xseq, xseq);

% 3.7
% Выход сети
yseq = sim(net, xseq);
y = cell2mat(yseq);

% 3.8
% Отображение обучающего множества
plot3(x(1, :), x(2, :), x(3, :), '-r', y(1, :), y(2, :), y(3, :), '-b', 'LineWidth', 2);