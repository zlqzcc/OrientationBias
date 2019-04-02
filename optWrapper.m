function [para, fval] = optWrapper(init, allTarget, allResponse, optFunc)
targetRadius = allTarget/180 * pi;
responseRadius = allResponse/180 * pi;

targetRadius(targetRadius < 0)   = targetRadius(targetRadius < 0) + 2 * pi;
responseRadius(responseRadius < 0) = responseRadius(responseRadius < 0) + 2 * pi;

lb = [0, 1, 1e-2];
ub = [2, 500, 0.25];
objFunc = @(para)dataLlhd(para(1), para(2), para(3), targetRadius, responseRadius);

if (strcmp(optFunc, 'fminsearch'))
    opts = optimset('fminsearch');
    opts.Display = 'iter';
    opts.TolX = 1e-4;
    opts.TolFun = 1e-4;
    
    [para, fval] = fminsearchbnd(objFunc, init, [0, 1], [2, 200], opts);
elseif (strcmp(optFunc, 'fmincon'))
    opts = optimoptions('fmincon');
    opts.Display = 'iter';
    opts.TolX = 1e-4;
    opts.TolFun = 1e-4;
    
    [para, fval] = fmincon(objFunc, init, [], [], [], [], lb, ub, [], opts);
elseif (strcmp(optFunc, 'bads'))
    plb = [0.1, 40, 0.01];
    pub = [2, 400, 0.1];
    [para, fval] = bads(objFunc, init, lb, ub, plb, pub);
else
    error('Invalid optimization option.');
end
end

