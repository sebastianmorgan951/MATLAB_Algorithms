% This function will take in several parameters:
% 
% func: An anonymous function defined as "somefunc = @(x)(operations on x)"
% point1: A point used to start the iteration, try to get somewhat close to
%         the root you expect to see with this point, so if you expect to 
%         see the root around x=1, you could try this with x=0
% point2: This iteration requires two initial points, so you can make this
%         this point anything closeish to the function as well, with the
%         above example, you could try x=2
% max_iters: The number of iterations to force stop our alorithm at. This
%            prevents our algorithm from executing until no memory is left
% root_prox: This is how small we want the interval between our point1 and
%            point2 to be before we think we are close enough to the root
%            to stop and return. This secant algorithm will reduce the size
%            of this interval on each iteration (if our initial guesses are
%            good), so for a valid function and guesses, we can use this as
%            a stopping condition, as we know the root we wish to
%            approximate will lie in that interval (ex input: 10^(-8))
% zero_prox: If we evaluate one of the endpoints of our interval, and find
%            it within zero_prox of the value of 0, for example if 
%            abs(func(point1)) < zero_prox, then we can use this as a
%            stopping condition as well, as in this case we seem to be
%            close enough to 0 to consider our point to be a root. 
%
% With these parameters, our function will continuously find the secant
% line between these points, find where the secant line intersects with the
% x-axis, then use that point for our one of the points of an updated
% interval which contains the true root of our funtion.
%
% NOTE: If your initial guesses are not good enough, this method of
%       approximaion may diverge or simply not approximate the function, in
%       which case an error returns.
%
% NOTE: Setting root_prox or zero_prox to be less than (10^(-8)) is not
%       suggested, as beyond this point, roundoff errors may become a
%       significant factor, and the relative error of operations on such
%       small values grows significantly due to this roundoff error and
%       loss of significant figures.
%
function[ret] = secant_algorithm(func,point1,point2,max_iters,root_prox,zero_prox)
    k=0;
    disp("k = " + 0)
    disp("point1 = " + point1)
    f1 = func(point1);
    disp("function at point1 = " + f1)
    k=1;
    disp("k = " + 1)
    disp("point2 = " + point2)
    f2 = func(point2);
    disp("function at point2 = " + f2)
    for k = 2:max_iters
        if abs(f1) > abs(f2)
            saver = point2;
            point2 = point1;
            point1 = saver;
            saver = f2;
            f2 = f1;
            f1 = saver;
        end
        s = (point2-point1)/(f2-f1);
        point2 = point1;
        f2 = f1;
        point1 = point1 - (f1*s);
        f1 = func(point1);
        disp("k = " + k);
        disp("point1 = " + point1);
        disp("function at point1 = " + f1);
        if abs(f1) < zero_prox || abs(point2-point1) < root_prox
            ret = point1;
            return
        end
    end
    error("ERROR: We exceeded the maximum secant iterations allowed!")
end