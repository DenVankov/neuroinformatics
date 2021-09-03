t0 = 0;
tn = 2;
h = 0.01;
n = (tn - t0) / h + 1;

X = t0:h:tn;
Y = sin(0.5 * (X.^2) - 5 * X);

% 2.1
% Создание сети и конфигурация под множества
% Метод сопряженных градиентов Полака-Рибейры
net = feedforwardnet(15, 'traincgp');
net = configure(net, X, Y);

% 2.2
% Train test split (обучающая и контрольная)
trainInd = 1 : floor(n * 0.9);
valInd = floor(n * 0.9) + 1 : n;
net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = [];

% 2.3
net = init(net);

% 2.4
net.trainParam.epochs = 2000;
net.trainParam.max_fail = 600;
net.trainParam.goal = 1.0e-8;

% 2.5
% Обучение сети
net = train(net, X, Y);

% 2.7
R = sim(net, X);
sqrt(mse(Y(trainInd) - R(trainInd)))
sqrt(mse(Y(valInd) - R(valInd)))

figure;
hold on;
% Эталонные значения
plot(X, Y, '-b');
title("Comparsion")
% Предсказанные значения
plot(X, R, '-r');
grid on;

figure;
% Ошибка
plot(X, Y - R);
title("Error")
grid on;