function [prior, thetas, bias, biasLB, biasUB] = modelVis(para, ci, incr)
if ~exist('incr','var')     
      incr = 0.025;
end
priorScale = para(1);
intNoise   = para(2);
mtrNoise   = para(3);

stepSize = 0.01; stmSpc = 0 : stepSize : 2 * pi;

prior = 2 - priorScale * abs(sin(2 * stmSpc));
nrmConst = 1.0 / trapz(stmSpc, prior);
prior = @(support) (2 - priorScale * abs(sin(2 * support))) * nrmConst;

% Calculate Bias
noiseLevel = intNoise;
thetas = 0.1 : incr : 1.1 * pi;

estimate = zeros(3, length(thetas));
for idx = 1:length(thetas)
    [estimate(1, idx), estimate(2, idx), estimate(3, idx)] = ...
        averageEstimate(prior, noiseLevel, mtrNoise, thetas(idx), ci);
end

bias   = (estimate(1, :) - thetas) / pi * 180;
biasLB = (estimate(2, :) - thetas) / pi * 180;
biasUB = (estimate(3, :) - thetas) / pi * 180;
thetas = thetas / pi;

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
        if(theta < 0.25 * pi)
            ests(ests > pi) = ests(ests > pi) - 2 * pi;
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
