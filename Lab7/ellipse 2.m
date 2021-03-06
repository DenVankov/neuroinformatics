function [ o ] = ellipse( t, a, b, x0, y0, alpha )

x1 = a * cos(t); 
y1 = b * sin(t);
o = [x1 * cos(alpha) - y1 * sin(alpha) + x0;
     x1 * sin(alpha) + y1 * cos(alpha) + y0];
end