% 2.1
% Создаем обучающее множество
k1 = 0 : 0.025 : 1;
p1 = sin(4 * pi * k1);
t1 = -ones(size(p1));
k2 = 2.38 : 0.025 : 4.1;
g = @(k)cos(cos(k) .* k.^2 + 5*k);
p2 = g(k2);
t2 = ones(size(p2));
R = {1; 3; 5};
P = [repmat(p1, 1, R{1}), p2, repmat(p1, 1, R{2}), p2, repmat(p1, 1, R{3}), p2];
T = [repmat(t1, 1, R{1}), t2, repmat(t1, 1, R{2}), t2, repmat(t1, 1, R{3}), t2];
Pseq = con2seq(P);
Tseq = con2seq(T);

% 2.2
% Создаем сеть
net = distdelaynet({0 : 4, 0 : 4}, 8, 'trainoss');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.divideFcn = '';

% 2.3
% Конфигурируем сеть
net = configure(net, Pseq, Tseq);
view(net);

% 2.4
% Формируем массивы ячеек для функции обучения
[Xs, Xi, Ai, Ts] = preparets(net, Pseq, Tseq); 

% 2.5
% Задаем параметры обучения
net.trainParam.epochs = 100;
net.trainParam.goal =  1.0e-5;

% 2.6
% Обучаем сеть
net = train(net, Xs, Ts, Xi, Ai);

% 2.8
% Расчитываем выход сети
Y = sim(net, Xs, Xi, Ai);

figure;
hold on;
grid on;
plot(cell2mat(Ts), '-b');
plot(cell2mat(Y), '-r');

% 2.9
% Преобразовываем значения по правилу
Yc = zeros(1, numel(Y));
for i = 1 : numel(Y)
    if Y{i} >= 0
        Yc(i) = 1;
    else
        Yc(i) = -1;
    end
end