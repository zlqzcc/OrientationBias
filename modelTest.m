%% Bias pattern
figure;
subplot(2, 1, 2); hold on; grid on;

[prior, theta, bias] = modelVis([1.0, 5, 0.001], 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis([1.0, 2, 0.001], 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis([1.0, 0.5, 0.001], 0.68);
plot(theta, bias, 'LineWidth', 2);

xlabel('Orientation'); ylabel('Bias (deg)'); grid on;
legend({'low', 'mid', 'high'});

plot([45, 45], ylim, '--k', 'LineWidth', 2); 
plot([90, 90], ylim, '--k', 'LineWidth', 2); 
plot([135, 135], ylim, '--k', 'LineWidth', 2); 

subplot(2, 1, 1); hold on; grid on;

domain = 0 : 0.01 : 2 * pi;
plot(domain / (2 * pi) * 180, prior(domain), 'k', 'LineWidth', 2);
xlabel('Orientation'); ylabel('Probability Density'); grid on;

plot([45, 45], ylim, '--k', 'LineWidth', 2); 
plot([90, 90], ylim, '--k', 'LineWidth', 2); 
plot([135, 135], ylim, '--k', 'LineWidth', 2);

%% Full distribution pattern
figure; hold on;
colors = get(gca, 'colororder');

subplot(3, 1, 1);
[~, theta, bias, lb, ub] = modelVis([1.0, 5, 0.001], 0.68, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(1, :));

subplot(3, 1, 2);
[~, theta, bias, lb, ub] = modelVis([1.0, 2, 0.001], 0.68, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(2, :));

subplot(3, 1, 3);
[~, theta, bias, lb, ub] = modelVis([1.0, 1, 0.001], 0.68, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(3, :));

xlabel('Orientation (deg)'); ylabel('Bias (deg)');
