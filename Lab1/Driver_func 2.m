function net = Driver_func(net, P, T, iterations, learningRate)
	for j = 1:iterations
        for i = 1:6
        	p = P(:,i);
			t = T(:,i);
        	a = sim(net, p);
        	e = t - a;
            if (mae(e))
            	net.IW{1,1} = net.IW{1,1} + e * p' * learningRate;
            	net.b{1} = net.b{1} + e * learningRate;
            end
        end
        disp(['Iteration: ', num2str(j)]);
    	disp(['Error: ', num2str(mae(T - net(P)))]);
    	disp(['Weights: ', num2str(net.IW{1,1})]);
    	disp(['Biases : ', num2str(net.b{1})]);
        disp(' ');
	end
end