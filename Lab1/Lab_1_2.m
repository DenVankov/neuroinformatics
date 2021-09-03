% 2.1
% Входные данные
P = [-0.5 4.9 -2.1 -2.1 0 1.3 -1;
     -4 -1.7 -4.4 -4.6 2.6 -4.2 3];
T = [0 0 1 0 1 0 1];

% 2.2
net = newp([-5 5; -5 5], [0 1]);

net.inputWeights{1,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net = init(net);
disp(['Random Weights: ', num2str(net.IW{1,1})]);
disp(['Random Biases : ', num2str(net.b{1})]);
disp(' ');

plotpv(P, T), grid
hold on;

% 2.3
net.trainParam.epochs = 50;
net = train(net, P, T);

plotpc(net.IW{1,1},net.b{1});
y = net(P);
mae(T - y)
hold off;
