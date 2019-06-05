function [para, fval] = optWrapperNmr(init, target, response, optFunc, disp)
%OPTWRAPPER Wrapper function for running the actual fitting procedure.

if ~exist('disp','var')
    disp = 'iter';
end

lb = [0, 0.1];
ub = [2, 100];

objFunc = @(para) dataLlhd(para(1), para(2), 0, target, response);

if (strcmp(optFunc, 'fminsearch'))
    opts = optimset('fminsearch');
    opts.Display = disp;
    opts.TolX = 1e-2;
    opts.TolFun = 1e-2;
    
    [para, fval] = fminsearchbnd(objFunc, init, lb, ub, opts);
elseif (strcmp(optFunc, 'fmincon'))
    opts = optimoptions('fmincon');
    opts.Display = disp;
    opts.TolX = 1e-4;
    opts.TolFun = 1e-4;
    
    [para, fval] = fmincon(objFunc, init, [], [], [], [], lb, ub, [], opts);
elseif (strcmp(optFunc, 'bads'))
    opts = bads('defaults');
    opts.Display = disp;
    plb = [0.6, 0.1];
    pub = [1.9, 20];
    [para, fval] = bads(objFunc, init, lb, ub, plb, pub, [], opts);
else
    error('Invalid optimization option.');
end

end