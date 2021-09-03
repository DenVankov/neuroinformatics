% 2.1
% ��������� ���������� ���������
phi = 0 : 0.025 : 2 * pi;
r = phi.*2;
x = [r .* cos(phi); r .* sin(phi)];
xseq = con2seq(x);

plot(x(1, :), x(2, :), '-r', 'LineWidth', 2);

% 2.2
% �������� ������������ ���� ������� ���������������
net = feedforwardnet([10 1 10], 'trainlm');
net = configure(net, xseq, xseq);

% 2.3
% ������������� ������� �������������
net = init(net);
view(net);

% 2.4
% ��������� ��������
net.trainParam.epochs = 200;
net.trainParam.goal = 1.0e-5;

% 2.5
% ��������
net = train(net, xseq, xseq);

% 2.6
% ����� ����
yseq = sim(net, xseq);
y = cell2mat(yseq);

% 2.7
% ����������� ���������� ���������
plot(x(1, :), x(2, :), '-r', y(1, :), y(2, :), '-b', 'LineWidth', 2);