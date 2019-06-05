function negLlhd = dataLlhd(priorScale, intNoise, mtrNoise, input, response)
%DATALLHD Calculate the negative log likelihood for given parameter and
%dataset (target - response pair).

% Transform data to [0, 2 * pi] space
input = input / 180 * 2 * pi;
response = response / 180 * 2 * pi;

input(input < 0) = input(input < 0) + 2 * pi;
response(response < 0) = response(response < 0) + 2 * pi;

input(input > 2 * pi) = input(input > 2 * pi) - 2 * pi;
response(response > 2 * pi) = response(response > 2 * pi) - 2 * pi;

% Prior distribution
prior = priorHandle(priorScale);

% Circular stimulus and sensory space in between [0, 2 * pi]
delta  = 0.01;
stmSpc = 0 : delta : 2 * pi;
snsSpc = 0 : delta : 2 * pi;

% Mapping (CDF)
priorDnst = prior(stmSpc);
F = cumtrapz(stmSpc, priorDnst) * 2 * pi;

ivsStmSpc = interp1(F, stmSpc, snsSpc, 'linear', 'extrap');
ivsPrior  = prior(ivsStmSpc);

% Calculate the function theat_hat(measurement)
estimates = arrayfun(@(msmt) thetaEstimator(ivsStmSpc, ivsPrior, stmSpc, snsSpc, delta, intNoise, msmt), snsSpc);

logLlhd = zeros(1, length(input));
parfor idx = 1:length(input)
    [domain, probDnst] = estimatorPDF(stmSpc, F, intNoise, estimates, input(idx));
    
    % Motor noise disabled
    % probDnst = motorConv(mtrNoise, domain, probDnst)
    
    dataProb = interp1(domain, probDnst, response(idx), 'linear', 'extrap');
    % Zero probability threshold
    if(dataProb < 1e-10)
        dataProb = 1e-10;
    end
    logLlhd(idx) = log(dataProb);
end

negLlhd = -sum(logLlhd);
end

