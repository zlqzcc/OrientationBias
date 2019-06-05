function [prior] = priorHandle(priorScale)
%PRIORHANDLE Generate prior distribution of the form 2 - s * |sin(x)|.

stepSize = 0.01; stmSpc = 0 : stepSize : 2 * pi;
priorUnm = 2 - priorScale * abs(sin(stmSpc));
nrmConst = 1.0 / trapz(stmSpc, priorUnm);
prior = @(support) (2 - priorScale * abs(sin(support))) * nrmConst;

end

