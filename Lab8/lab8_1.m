% 1.1 - 1.2
% Парсим данные
fileID = fopen('Data.txt','r');
formatSpec = '%f %f';
sizeData = [1 Inf];
wolf_dataset = fscanf(fileID,formatSpec,sizeData);
fclose(fileID);

% 1.3
% Сглаживание
x = wolf_dataset;
x = smooth(x, 12);

% 1.4
% Задаем глубину погружения временного ряда
D = 5;
ntrain = 500;
nval = 100;
ntest = 50;

% 1.5
% Объеденяем подмножества в обучающую выборку
% 1 - 500
trainInd = 1 : ntrain;
% 501 - 600
valInd = ntrain + 1 : ntrain + nval;
% 601 - 650
testInd = ntrain + nval + 1 : ntrain + nval + ntest;

% 1.7
% Создаем сеть
net = timedelaynet(1:D,8,'trainlm'); 
net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;

% 1.6
% Преобразуембучающее множество
x = con2seq(x(1:ntrain+nval+ntest)');

% 1.9
% Конфигурируем сеть под обучающее множество
net = configure(net, x, x);

% 1.10
% Инициализируем весовые коэффициенты
net = init(net);

% 1.11
% Задаем параметры обучения
net.trainParam.epochs = 2000;
net.trainParam.max_fail = 2000;
net.trainParam.goal = 1.0e-5;
view(net);

% 1.12
% Обучаем сеть
[Xs, Xi, Ai, Ts] = preparets(net, x, x);
net = train(net, Xs, Ts, Xi, Ai);

% 1.14
% Расчитываем выход сети
Y = sim(net, Xs, Xi);

figure;
hold on;
grid on;
plot(cell2mat(x), '-b');
plot([cell2mat(Xi) cell2mat(Y)], '-r');

figure;
hold on;
grid on;
plot([cell2mat(Xi) cell2mat(Y)] - cell2mat(x), '-r');

xm = cell2mat(x);
ym = cell2mat(Y);

figure;
hold on;
grid on;
plot(xm(ntrain + nval + 1 : ntrain + nval + ntest), '-b');
plot(ym(ntrain + nval - 9 : ntrain + nval + ntest - 10), '-r');