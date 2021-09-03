% [9, 2, 3]
number9 = [-1 -1 -1 -1 +1 +1 +1 +1 +1 +1;
           -1 -1 -1 -1 +1 +1 +1 +1 +1 +1;
           -1 -1 -1 -1 +1 +1 -1 -1 +1 +1;
           -1 -1 -1 -1 +1 +1 -1 -1 +1 +1;
           -1 -1 -1 -1 +1 +1 -1 -1 +1 +1;
           -1 -1 -1 -1 +1 +1 -1 -1 +1 +1;
           -1 -1 -1 -1 +1 +1 +1 +1 +1 +1;
           -1 -1 -1 -1 +1 +1 +1 +1 +1 +1;
           -1 -1 -1 -1 -1 -1 -1 -1 +1 +1;
           -1 -1 -1 -1 -1 -1 -1 -1 +1 +1;
           -1 -1 -1 -1 +1 +1 +1 +1 +1 +1;
           -1 -1 -1 -1 +1 +1 +1 +1 +1 +1];
       
number2 = [+1 +1 +1 +1 +1 +1 +1 +1 -1 -1;
           +1 +1 +1 +1 +1 +1 +1 +1 -1 -1;
           -1 -1 -1 -1 -1 -1 +1 +1 -1 -1;
           -1 -1 -1 -1 -1 -1 +1 +1 -1 -1;
           -1 -1 -1 -1 -1 -1 +1 +1 -1 -1;
           +1 +1 +1 +1 +1 +1 +1 +1 -1 -1;
           +1 +1 +1 +1 +1 +1 +1 +1 -1 -1;
           +1 +1 -1 -1 -1 -1 -1 -1 -1 -1;
           +1 +1 -1 -1 -1 -1 -1 -1 -1 -1;
           +1 +1 -1 -1 -1 -1 -1 -1 -1 -1;
           +1 +1 +1 +1 +1 +1 +1 +1 -1 -1;
           +1 +1 +1 +1 +1 +1 +1 +1 -1 -1];
       
number3 = [-1 -1 +1 +1 +1 +1 +1 +1 -1 -1;
           -1 -1 +1 +1 +1 +1 +1 +1 +1 -1;
           -1 -1 -1 -1 -1 -1 -1 +1 +1 -1;
           -1 -1 -1 -1 -1 -1 -1 +1 +1 -1;
           -1 -1 -1 -1 -1 -1 -1 +1 +1 -1;
           -1 -1 -1 -1 +1 +1 +1 +1 -1 -1;
           -1 -1 -1 -1 +1 +1 +1 +1 -1 -1;
           -1 -1 -1 -1 -1 -1 -1 +1 +1 -1;
           -1 -1 -1 -1 -1 -1 -1 +1 +1 -1;
           -1 -1 -1 -1 -1 -1 -1 +1 +1 -1;
           -1 -1 +1 +1 +1 +1 +1 +1 +1 -1;
           -1 -1 +1 +1 +1 +1 +1 +1 -1 -1];

P = [number9(:), number2(:), number3(:)];

% 3.1
% ���������� ������ ������� ����
Q = 3;

eps = 1 / (Q - 1);

% ������ �����������
R = 10 * 12;

IW = [number9(:)'; number2(:)'; number3(:)'];
b = ones(Q, 1) * R;

a = zeros(Q, Q);
for i = 1:Q
    a(:,i) = IW * P(:, i) + b;
end

% 3.3
% ���������� ������ ������� ����

net = newhop(a);
net.biasConnect(1) = 0;
net.layers{1}.transferFcn = 'poslin';

net.LW{1, 1} = eye(Q, Q) * (1 + eps) - ones(Q, Q) * eps;
view(net);

%3.4 ������ ������ � ������ ��������� ������
iterations = 600;
in = number2(:);
A = IW * in + b;
R = sim(net, {1 iterations}, {}, A);
A = R{iterations};
 
index = A == max(A);
A = IW(index, :)';

R = reshape(A, 12, 10);
R(R >= 0) = 2;
R(R < 0) = 1;
map = [1, 1, 1; 0, 0, 0];
image(R);
colormap(map)
axis off
axis image

% 3.5
% ���������� 20%
iterations = 600;
r = rand([12, 10]);
M = 0.2;
in = number9;

for i = 1:12
    for j = 1:10
        if r(i, j) < M
            in(i, j) = -in(i, j);
        end
    end
end

% �����������
in = in(:);
R = reshape(in, 12, 10);
R(R >=0) = 2;
R(R < 0) = 1;
map = [1, 1, 1; 0, 0, 0];
figure('Name', '9');
image(R);
colormap(map)
axis off
axis image
 
% �������������
A = IW * in + b;
R = sim(net, {1 iterations}, {}, A);
A = R{iterations};
index = A == max(A);
A = IW(index, :)';
 
R = reshape(A, 12, 10);
R(R >=0) = 2;
R(R < 0) = 1;
map = [1, 1, 1; 0, 0, 0];
figure
image(R);
colormap(map)
axis off
axis image

% 3.6
% ���������� 30%
iterations = 600;
r = rand([12, 10]);
M = 0.3;
in = number2;

%����������
for i = 1:12
    for j = 1:10
        if r(i, j) < M
            in(i, j) = -in(i, j);
        end
    end
end

% �����������
in = in(:);
R = reshape(in, 12, 10);
R(R >=0) = 2;
R(R < 0) = 1;
map = [1, 1, 1; 0, 0, 0];
figure('Name', '2');
image(R);
colormap(map)
axis off
axis image
 
% �������������
A = IW * in + b;
R = sim(net, {1 iterations}, {}, A);
A = R{iterations};
index = find(A == max(A));
A = IW(index, :)';
 
R = reshape(A, 12, 10);
R(R >=0) = 2;
R(R < 0) = 1;
map = [1, 1, 1; 0, 0, 0];
figure
image(R);
colormap(map)
axis off
axis image