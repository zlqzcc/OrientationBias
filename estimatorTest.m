%% Define Prior
stepSize = 0.001; stmSpc = -2 * pi : stepSize : 3 * pi;

scaling = 1.95;
prior = 2 - scaling * abs(sin(2 * stmSpc)); nrmConst = 1.0 / trapz(stmSpc, prior);
prior = prior * nrmConst;

subplot(1, 2, 1); hold on;
priorDensity = @(support) (2 - scaling * abs(sin(2 * support))) * nrmConst;

plotRange = 0 : 0.01 : pi;
plot(plotRange / pi, priorDensity(plotRange), 'LineWidth', 2); grid on;
xlabel('radius (pi)'); ylabel('p(theta)'); ylim([0, 0.3]);

%% Estimator
noiseLevelsMap = 0.01;
thetas = 0 : 0.05 : 1.01 * pi;

subplot(1, 2, 2); hold on;
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
