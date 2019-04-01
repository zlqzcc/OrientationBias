function [priorDensity, thetas, bias] = modelVis(para)
priorScale = para(1);
intNoise   = para(2);

stepSize = 0.01; stmSpc = 0 : stepSize : 2 * pi;

prior = 2 - priorScale * abs(sin(2 * stmSpc));
nrmConst = 1.0 / trapz(stmSpc, prior);
priorDensity = @(support) (2 - priorScale * abs(sin(2 * support))) * nrmConst;

% Calculate Bias
noiseLevel = intNoise;
thetas = 0.01 : 0.05 : 1.01 * pi;

estimates = arrayfun(@(theta) averageEstimate(priorDensity, noiseLevel, theta), thetas);
bias = estimates - thetas;

    function [estMean] = averageEstimate(prior, noiseLevel, theta)
        [ests, prob] = estimatorCircular(prior, noiseLevel, theta);
        
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
    end
end
