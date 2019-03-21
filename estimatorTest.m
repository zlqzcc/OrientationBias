%% Define Prior
stepSize = 0.01; stmSpc = -2 * pi : stepSize : 3 * pi;
prior = 2 - abs(sin(2 * stmSpc)); nrmConst = 1.0 / trapz(stmSpc, prior);
prior = prior * nrmConst;

priorDensity = @(support) (2 - abs(sin(support))) * nrmConst;
plot(stmSpc / pi, prior, 'LineWidth', 2); grid on;
xlabel('radius (pi)'); ylabel('p(theta)');

%% Estimator

noiseLevelsMap = 0.05;
thetas = 0 : 0.05 : 1.01 * pi;

% noiseLevelsMap = 0.05;
% thetas = 0;

figure; hold on;
for idx = 1 : length(noiseLevelsMap)
    noiseLevel = noiseLevelsMap(idx);
    estimates = arrayfun(@(theta) averageEstimateMap(stmSpc, prior, theta, noiseLevel), thetas);
    bias = estimates - thetas;
    
    plot(thetas/pi, bias/pi*180, 'LineWidth', 2);
end
title('Bias, Homogeneous Noise');
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;

function [meanEst] = averageEstimateMap(stmSpc, prior, theta, noiseLevel)
[ests, prob] = estimatorMapping(stmSpc, prior, theta, noiseLevel);

delta = 0.001;
unDomain = min(ests) : delta : max(ests);
probDnst = interp1(ests, prob, unDomain);

mass = probDnst * delta;

estimateSin = sum(mass .* sin(unDomain));
estimateCos = sum(mass .* cos(unDomain));
meanEst = atan(estimateSin / estimateCos);

if(theta > 0.25*pi && theta < 0.75 * pi)
    if(meanEst <= 0)
        meanEst = meanEst + pi;
    end
elseif(theta > 0.75 * pi)
    meanEst = meanEst + pi;
end
end
