% 1.1 
% ������� ������� ������������������
h = 0.025;

X = 0:h:6;
Y = sin((X.^2) - 6 * X + 3);

Pn = con2seq(Y);

% 1.2
% ������������� �������� � �������� ��������
delays = [1 2 3 4 5];
net = newlin([-1 1], 1, delays, 0.01);

% 1.3
% ������������� ����
net.inputweights{1,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net = init(net);

% 1.4 
% ��������� �� ����� �� 50�� �����
Pi = con2seq(Y(1:5));
P = Pn(6:end);
T = Pn(6:end);

for i = 1:50
    [net, Y, E] = adapt(net, P, T, Pi);
end

% ������ ��������
err = sqrt(mse(E));
display(err);

% ������������� ������� ������
figure

E = cell2mat(Pn) - cell2mat(sim(net, Pn));
plot(X, E, 'r');
title('Error');

%1.5
% ��������� ��������
figure
referenceLine = plot(X(6:end), cell2mat(T), 'r');
hold on;

% ������������� ��������
approximationLine = plot(X(6:end), cell2mat(Y), 'b');
legend([referenceLine,approximationLine],'Target', 'Approximated');
title('Comparsion');
hold off;