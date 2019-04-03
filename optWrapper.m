function [para, fval] = optWrapper(init, target_woFB, response_woFB, target_wFB1, response_wFB1, target_wFB2, response_wFB2, optFunc, disp)
if ~exist('disp','var')
    disp = 'iter';
end

lb = [repmat([0, 1], [1, 3]), 1e-3];
ub = [repmat([2, 600], [1, 3]), 0.25];

objFunc = @(para) ...
    dataLlhd(para(1), para(2), para(end), target_woFB, response_woFB) + ...
    dataLlhd(para(3), para(4), para(end), target_wFB1, response_wFB1) + ...
    dataLlhd(para(5), para(6), para(end), target_wFB2, response_wFB2);

if (strcmp(optFunc, 'fminsearch'))
    opts = optimset('fminsearch');
    opts.Display = disp;
    opts.TolX = 1e-4;
    opts.TolFun = 1e-4;
    
    [para, fval] = fminsearchbnd(objFunc, init, [0, 1], [2, 200], opts);
elseif (strcmp(optFunc, 'fmincon'))
    opts = optimoptions('fmincon');
    opts.Display = disp;
    opts.TolX = 1e-4;
    opts.TolFun = 1e-4;
    
    [para, fval] = fmincon(objFunc, init, [], [], [], [], lb, ub, [], opts);
elseif (strcmp(optFunc, 'bads'))
    opts = bads('defaults');
    opts.Display = disp;
    plb = [repmat([0.1, 40], [1, 3]), 0.01];
    pub = [repmat([2, 500], [1, 3]), 0.1];
    [para, fval] = bads(objFunc, init, lb, ub, plb, pub, [], opts);
else
    error('Invalid optimization option.');
end

end