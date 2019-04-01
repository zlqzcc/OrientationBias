function negLlhd = dataLlhd(priorScale, intNoise, mtrNoise, input, response)
stepSize = 0.01; stmSpc = 0 : stepSize : 2 * pi;
priorUnm = 2 - priorScale * abs(sin(2 * stmSpc));
nrmConst = 1.0 / trapz(stmSpc, priorUnm);
prior = @(support) (2 - priorScale * abs(sin(2 * support))) * nrmConst;

% Circular stimulus and sensory space in between [0, 2 * pi]
delta  = 0.01;
stmSpc = 0 : delta : 2 * pi;
snsSpc = 0 : delta : 2 * pi;

priorDnst = prior(stmSpc);
F = cumtrapz(stmSpc, priorDnst) * 2 * pi;

ivsStmSpc = interp1(F, stmSpc, snsSpc, 'linear', 'extrap');
ivsPrior  = prior(ivsStmSpc);

% theat_hat(measurement)
estimates = arrayfun(@(msmt) thetaEstimator(ivsStmSpc, ivsPrior, stmSpc, snsSpc, delta, intNoise, msmt), snsSpc);

logLlhd = zeros(1, length(input));
parfor idx = 1:length(input)
    [domain, probDnst] = estimatorPDF(stmSpc, F, intNoise, estimates, input(idx));
    probDnst = motorConv(mtrNoise, domain, probDnst)
    
    dataProb = interp1(domain, probDnst, response(idx), 'linear', 'extrap');
    % zero probability threshold
    if(dataProb < 1e-6)
        dataProb = 1e-6;
    end
    logLlhd(idx) = log(dataProb);
end

negLlhd = -sum(logLlhd);
end

