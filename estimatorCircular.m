function [domain, probDnst] = estimatorCircular(prior, intNoise, stimulus)
% Circular stimulus and sensory space in between [0, 2 * pi]
delta  = 0.01;
stmSpc = 0 : delta : 2 * pi;
snsSpc = 0 : delta : 2 * pi;

priorDnst = prior(stmSpc);
F = cumtrapz(stmSpc, priorDnst) * 2 * pi;

ivsStmSpc = interp1(F, stmSpc, snsSpc, 'linear', 'extrap');
ivsPrior  = prior(ivsStmSpc);
estimates = arrayfun(@(msmt) thetaEstimator(ivsStmSpc, ivsPrior, stmSpc, snsSpc, delta, intNoise, msmt), snsSpc);

[domain, probDnst] = estimatorPDF(stmSpc, F, intNoise, estimates, stimulus);
end
