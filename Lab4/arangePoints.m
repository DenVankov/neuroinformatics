function [X, Y] = arangePoints(a, b, xc, yc, alpha, h)
	t = 0:h:2 * pi;
	
	X = xc + a * cos(t) * cos(alpha) - b * sin(t) * sin(alpha);
	Y = yc + b * cos(t) * sin(alpha) + a * sin(t) * cos(alpha);