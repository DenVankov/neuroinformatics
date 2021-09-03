% Вариант 6 Ваньков Денис М80-407Б-17

% 1.1
% Входные данные
P = [-0.5 4.9 -2.1 -2.1 0 1.3;
     -4 -1.7 -4.4 -4.6 2.6 -4.2];
T = [0 0 0 0 1 0];

% 1.2
% Инициализация сети
net = newp([-5 5; -5 5], [0 1]);
% Вывод инормации о сети
display(net);
view(net);

% 1.3.1
% Весовые коэффициенты
net.inputWeights{1,1}.initFcn = 'rands';
% Смещения
net.biases{1}.initFcn = 'rands';
% Инициализация
net = init(net);
disp('Random Weights: ');
disp(net.IW{1,1});
disp('Random Biases : ');
disp(net.b{1});
% Отображение точек и прямой
plotpv(P, T);
% line1 = plotpc(net.IW{1}, net.b{1});
% set(line1, 'Color', 'g');
grid;
hold on;

% 1.3.2
net = Driver_func(net, P, T, 2, 0.3);

% 1.3.3
line2 = plotpc(net.IW{1}, net.b{1});

% 1.4.1
net = init(net);
disp(['Random Weights: ', num2str(net.IW{1,1})]);
disp(['Random Biases : ', num2str(net.b{1})]);
disp(' ');

% 1.4.2
net.trainParam.epochs = 50;
net = train(net, P, T);

disp(['New Weights: ', num2str(net.IW{1,1})]);
disp(['New Biases : ', num2str(net.b{1})]);

% 1.4.3
% Cоздаем тестовые точки
testpoints = -5 + (5+5)*rand(2,3);
testclasses = net(testpoints);

plotpv(testpoints, testclasses);
point = findobj(gca,'type','line');
set(point,'Color','red');
hold on
plotpv(P, T)
plotpc(net.IW{1},net.b{1});
grid on
hold off