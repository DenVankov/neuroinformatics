% 3.1
P = [-0.8 -2.1 -3.9 2 2.8 -1.1 -2.8 -3.2;
 -2.5 -0.8 -0.1 -2.6 -4.3 -5 -5 -3.6];
T = [1 0 0 1 1 1 0 0;
 0 0 0 0 0 1 1 1 ];

% 3.2
net = newp([-5 5; -5 5], 2);
view(net);

net.inputWeights{1,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net = init(net);

% 3.3
disp('Random Weights: ');
disp(net.IW{1,1});
disp('Random Biases: ');
disp(net.b{1})

% 3.4
net.trainParam.epochs = 50;
net = train(net, P, T);
disp('Weights: ');
disp(net.IW{1,1});
disp('Biases: ')
disp(net.b{1});

plotpv(P, T);
plotpc(net.IW{1}, net.b{1});
grid;

testpoints = -5 + (5+5)*rand(2,5);
testclasses = net(testpoints);
plotpv([P testpoints], [T, testclasses]); 
point = findobj(gca,'type','line');
set(point,'Color','red');
hold on
plotpv(P, T);
plotpc(net.IW{1}, net.b{1});
hold off
