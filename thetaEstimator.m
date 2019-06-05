function [estimate] = thetaEstimator(ivsStmSpc, ivsPrior, stmSpc, snsSpc, delta, intNoise, snsMsmt)
%THETAESTIMATOR Calculate theta_hat given the sensory measurement.

% Estimator given measurement m (theta_hat function)
likelihoodDist = vonmpdf(snsSpc, snsMsmt, intNoise);
score = likelihoodDist .* ivsPrior;
if(sum(isnan(ivsStmSpc)) > 0 || sum(isnan(score)) > 0)
    error('NaN Occurred.');
end

stmScore = interp1(ivsStmSpc, score, stmSpc, 'linear', 'extrap');
% L2 loss, posterior mean
posteriorDist = stmScore / trapz(stmSpc, stmScore);
posteriorMass = posteriorDist * delta;

estimateSin = sum(posteriorMass .* sin(stmSpc));
estimateCos = sum(posteriorMass .* cos(stmSpc));

estimate = atan(estimateSin / estimateCos);

if(estimateCos < 0)
    estimate = estimate + pi;
elseif(estimateCos > 0 && estimate < 0)
    estimate = estimate + 2 * pi;
end

end