function [para, fval] = optWrapper(init, allTarget, allResponse)
targetRadius = allTarget/180 * pi;
responseRadius = allResponse/180 * pi;

targetRadius(targetRadius < 0)   = targetRadius(targetRadius < 0) + 2 * pi;
responseRadius(responseRadius < 0) = responseRadius(responseRadius < 0) + 2 * pi;

opts = optimset('fminsearch');
opts.Display = 'iter';
opts.TolX = 1e-4;
opts.TolFun = 1e-4;
opts.MaxFunEvals = 200;

objFunc = @(para)dataLlhd(para(1), para(2), targetRadius, responseRadius);
[para, fval, ~, ~] = fminsearchbnd(objFunc, init, [0, 1], [2, 200], opts);
end

