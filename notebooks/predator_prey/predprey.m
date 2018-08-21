function [xdot, ydot]  = predprey( x, p )

    xdot = x(1) * (x(1) - 0.1) * (1 - x(1)) - 1.5 * x(1) * x(2);
    ydot = x(1) * x(2) - p(1) * x(1) - p(2);

end
