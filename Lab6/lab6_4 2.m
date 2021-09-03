% Вариант 6
P = [0.5 0.7 0.4 0.6 -0.7 -1.3 0.5 1.3 -0.2 0.7 -1 -0.2
     0.7 -0.4 -1 -1.5 -1.4 0.9 -0.6 -1.4 -0.4 0.8 -0.1 0.4];
T = [-1 -1 1 1 -1 -1 1 -1 -1 -1 -1 -1];

Ti = T;
Ti(Ti == 1) = 2;
Ti(Ti == -1) = 1;
Ti = ind2vec(Ti);

% 4.3
% Создаем сеть
net = lvqnet(12, 0.1);
net = configure(net, P, Ti);
view(net)
net.IW{1,1};
net.LW{2,1};

% 4.4
% Обучаем
net.trainParam.epochs = 300;
net = train(net, P, Ti);

% 4.6
% Проверка качества обучения
[X,Y] = meshgrid([-1.5 : 0.1 : 1.5], [-1.5 : 0.1 : 1.5]);
res = sim(net, [X(:)'; Y(:)']);
res = vec2ind(res) - 1;
figure;
plotpv([X(:)'; Y(:)'], res);
point = findobj(gca,'type','line');
set(point,'Color','g');
hold on;
plotpv(P, max(0, T));