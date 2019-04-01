%% Define Prior
stepSize = 0.01; stmSpc = 0 : stepSize : 2 * pi;

scaling = 1.25;
prior = 2 - scaling * abs(sin(2 * stmSpc)); 
nrmConst = 1.0 / trapz(stmSpc, prior);
prior = prior * nrmConst;

figure; hold on;
priorDensity = @(support) (2 - scaling * abs(sin(2 * support))) * nrmConst;

plot(stmSpc / pi, priorDensity(stmSpc), 'LineWidth', 2); grid on;
xlabel('radius (pi)'); ylabel('p(theta)'); 

%% Estimator
kappa = 50;
[domain, probDnst] = estimatorCircular(priorDensity, kappa, 1.0 * pi);

figure;
plot(domain / pi * 180, probDnst, 'LineWidth', 2); grid on;

%% Calculate Bias
noiseLevels = 50;
thetas = 0.01 : 0.05 : 1.01 * pi;

figure; hold on;
for idx = 1 : length(noiseLevels)
    noiseLevel = noiseLevels(idx);
    estimates = arrayfun(@(theta) averageEstimate(priorDensity, noiseLevel, theta), thetas);
    bias = estimates - thetas;
    
    plot(thetas/pi, bias/pi*180, 'LineWidth', 2);
end
title('Bias, Homogeneous Noise');
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;

function [meanEst] = averageEstimate(prior, noiseLevel, theta)
[ests, prob] = estimatorCircular(prior, noiseLevel, theta);

delta = 0.01;
unDomain = min(ests) : delta : max(ests);
probDnst = interp1(ests, prob, unDomain);

mass = probDnst * delta;

estimateSin = sum(mass .* sin(unDomain));
estimateCos = sum(mass .* cos(unDomain));
meanEst = atan(estimateSin / estimateCos);

if(estimateCos < 0)
    meanEst = meanEst + pi;
elseif(estimateCos > 0 && meanEst < 0)
    meanEst = meanEst + 2 * pi;
end

end