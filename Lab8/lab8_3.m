% 3.1
% Создаем обучающее множество
t0 = 0;
tn = 10;
dt = 0.01;
n = (tn - t0) / dt + 1;
fun = @(k)sin(k.^2 - 2 * k + 3);
fun2 = @(y, u)y ./ (1 + y.^2) + u.^3;
u = zeros(1, n);
u(1) = fun(0);
x = zeros(1, n);
for i = 2 : n
    t = t0 + (i - 1) * dt;
    x(i) = fun2(x(i - 1), u(i - 1));
    u(i) = fun(t);
end

% 3.2
% Задаем глубину погружения временного ряда
D = 3;
ntrain = 700;
nval = 200;
ntest = 97;

% 3.3
% Объединяем подмножества в обучающую выборку
trainInd = 1 : ntrain;
valInd = ntrain + 1 : ntrain + nval;
testInd = ntrain + nval + 1 : ntrain + nval + ntest;

% 3.5
% Создаем сеть
net = narxnet(1 : 3, 1 : 3, 10);
net.trainFcn = 'trainlm';

% 3.6
% Разделяем обучающее множество
net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;

% 3.9
% Задаем параметры обучения
net.trainParam.epochs = 2000;
net.trainParam.max_fail = 2000;
net.trainParam.goal = 1.0e-10;

[Xs, Xi, Ai, Ts] = preparets(net, con2seq(u), {}, con2seq(x)); 

% 3.10
% Обучаем сеть
net = train(net, Xs, Ts, Xi, Ai);
view(net);

% 3.12
% Расчитываем выход сети
Y = sim(net, Xs, Xi);

figure
subplot(3,1,1)
plot(t0:dt:tn, u, '-b'),grid
ylabel('control')
subplot(3,1,2)
plot(t0:dt:tn, x, '-b', t0:dt:tn, [x(1:D) cell2mat(Y)], '-r'), grid
ylabel('state')
subplot(3,1,3)
plot(t0+D*dt:dt:tn, x(D+1:end) - cell2mat(Y)), grid
ylabel('error')
xlabel('t')