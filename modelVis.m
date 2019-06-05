function [prior, thetas, bias, biasLB, biasUB] = modelVis(para, ci, incr)
%MODELVIS Visualization of the model fitting results.
%   Syntax:
%   [prior, thetas, bias, biasLB, biasUB] = modelVis(para, ci, incr)
%
%   Inputs:
%       para    - Best fitted model parameter.
%       ci      - Confidence internal (between 0 and 1) for the errorbars.
%       incr    - Increments between point within [0, pi] for the calculation.
%
%   Outputs:
%       prior   - A function handle of prior distribution.
%       thetas  - Domain for the calculation.
%       bias    - Bias as a function of thetas.
%       biasLB  - Lower CI of bias as a function of thetas.
%       biasUB  - Upper CI of bias as a function of thetas.

if ~exist('incr','var')
    incr = 0.05;
    init = 0.01;
else
    init = 0.1;
end
priorScale = para(1);
intNoise   = para(2);
mtrNoise   = para(3);

stepSize = 0.01; stmSpc = 0 : stepSize : 2 * pi;
prior = priorHandle(priorScale);

% Calculate Bias
noiseLevel = intNoise;
thetas = init : incr : 2 * pi;

estimate = zeros(3, length(thetas));
for idx = 1:length(thetas)
    [estimate(1, idx), estimate(2, idx), estimate(3, idx)] = ...
        averageEstimate(prior, noiseLevel, mtrNoise, thetas(idx), ci);
end

bias   = (estimate(1, :) - thetas) / (2 * pi) * 180;
biasLB = (estimate(2, :) - thetas) / (2 * pi) * 180;
biasUB = (estimate(3, :) - thetas) / (2 * pi) * 180;
thetas = thetas / (2 * pi) * 180;

    function [estMean, estLB, estUB] = averageEstimate(prior, noiseLevel, mtrNoise, theta, ci)
        % mean estimate
        [ests, prob] = estimatorCircular(prior, noiseLevel, mtrNoise, theta);
        
        delta = 0.01;
        unDomain = min(ests) : delta : max(ests);
        probDnst = interp1(ests, prob, unDomain);
        
        mass = probDnst * delta;
        
        estimateSin = sum(mass .* sin(unDomain));
        estimateCos = sum(mass .* cos(unDomain));
        estMean = atan(estimateSin / estimateCos);
        
        if(estimateCos < 0)
            estMean = estMean + pi;
        elseif(estimateCos > 0 && estMean < 0)
            estMean = estMean + 2 * pi;
        end
        
        % interval estimate
        if(theta < 0.5 * pi)
            ests(ests > pi) = ests(ests > pi) - 2 * pi;
        elseif(theta > 1.5 * pi)
            ests(ests < pi) = ests(ests < pi) + 2 * pi;
        end
        [ests, sortIdx] = sort(ests);
        prob = prob(sortIdx);
        ests = ests(prob > 0);
        prob = prob(prob > 0);
        
        [cdf, uIdx] = unique(cumtrapz(ests, prob), 'stable');
        quantileLB = (1 - ci) / 2;
        quantileUB = 1 - quantileLB;
        
        estLB = interp1(cdf, ests(uIdx), quantileLB);
        estUB = interp1(cdf, ests(uIdx), quantileUB);
    end
end
