function [estimates, probDnst] = estimatorMapping(stmSpc, prior, stimulus, intNoise)
% ESTIMATORMAPPING   Compute p(v'|v)
%                    expressed in stimulus space
%                    Special implementation for directional statistics

% Mapping from measurement to (homogeneous) sensory space
F = cumtrapz(stmSpc, prior);
snsMeasurement = interp1(stmSpc, F, stimulus);

% P(m | theta), expressed in sensory space
estLB = max(0, snsMeasurement - 6 * intNoise);
estUB = min(1, snsMeasurement + 6 * intNoise);
estSnsSpc    = estLB : 0.001 : estUB;
estIvsStmSpc = interp1(F, stmSpc, estSnsSpc, 'linear', 'extrap');
estIvsPrior  = interp1(stmSpc, prior, estIvsStmSpc, 'linear', 'extrap');

% P(m | theta), expressed in sensory space; Compute an estimate for each measurement
measurementDist = normpdf(estSnsSpc, snsMeasurement, intNoise);
estimates = arrayfun(@(measurements) measurementEstimator(estIvsStmSpc, estIvsPrior, estSnsSpc, measurements, intNoise), estSnsSpc);

% Change of Variable
probDnst = abs(gradient(estSnsSpc, estimates)) .* measurementDist;
if(sum(isnan(estimates)) > 0 || sum(isnan(probDnst)) > 0)
    error('NaN Occurred.');
end

% Estimator given measurement m (theta_hat function)
    function [estimate] = measurementEstimator(ivsStmSpc, ivsPrior, snsSpc, snsMeasurement, intNoise)
        msmtStim = interp1(F, stmSpc, snsMeasurement, 'linear', 'extrap');
        
        delta  = 0.001;
        unStmSpc = min(ivsStmSpc) : delta : max(ivsStmSpc);
        
        likelihoodDist = normpdf(snsSpc, snsMeasurement, intNoise);
        score   = likelihoodDist .* ivsPrior;
        if(sum(isnan(ivsStmSpc)) > 0 || sum(isnan(score)) > 0 || sum(isnan(unStmSpc)) > 0)
            error('NaN Occurred.');
        end
        unScore = interp1(ivsStmSpc, score, unStmSpc);
        
        % L2 loss, Posterior mean
        posteriorDist = unScore / trapz(unStmSpc, unScore);
        posteriorMass = posteriorDist * delta;
        
        estimateSin = sum(posteriorMass .* sin(unStmSpc));
        estimateCos = sum(posteriorMass .* cos(unStmSpc));
        
        estimate = atan(estimateSin / estimateCos);
                
        nCycle = floor((msmtStim - 0.25 * pi) / (0.5*pi));
        nCount = floor(nCycle /2) + 1;
        if(mod(nCycle, 2) == 0)
            if(estimate <= 0)
                estimate = estimate + nCount * pi;
            else
                estimate = estimate + (nCount - 1) * pi;
            end
        else
            estimate = estimate + nCount * pi;
        end                                       
    end
end
