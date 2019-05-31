% Run the fit for combined subject, plot the results
%% Control Group
optOption = 'bads';

% Load data file and run the fitting procedure
subData = load('woFB_td.mat');
target_woFB = subData.allTarget; response_woFB = subData.allResponse;
[para_td_woFB, fval_td_woFB] = optWrapperNmr([1.8, 5], target_woFB, response_woFB, optOption);

subData = load('wFB1_td.mat');
target_wFB1 = subData.allTarget; response_wFB1 = subData.allResponse;
[para_td_wFB1, fval_td_wFB1] = optWrapperNmr([1.6, 5], target_wFB1, response_wFB1, optOption);

subData = load('wFB2_td.mat');
target_wFB2 = subData.allTarget; response_wFB2 = subData.allResponse;
[para_td_wFB2, fval_td_wFB2] = optWrapperNmr([1.5, 5], target_wFB2, response_wFB2, optOption);

%% ASD Group
optOption = 'bads';

subData = load('woFB_asd.mat');
target_woFB = subData.allTarget; response_woFB = subData.allResponse;
[para_asd_woFB, fval_asd_woFB] = optWrapperNmr([1.8, 5], target_woFB, response_woFB, optOption);

subData = load('wFB1_asd.mat');
target_wFB1 = subData.allTarget; response_wFB1 = subData.allResponse;
[para_asd_wFB1, fval_asd_wFB1] = optWrapperNmr([1.6, 5], target_wFB1, response_wFB1, optOption);

subData = load('wFB2_asd.mat');
target_wFB2 = subData.allTarget; response_wFB2 = subData.allResponse;
[para_asd_wFB2, fval_asd_wFB2] = optWrapperNmr([1.5, 5], target_wFB2, response_wFB2, optOption);

%% Plot Parameter Change
figure; subplot(2, 1, 1);
hold on; grid on;
plot([0.8, 2, 3.2], [para_td_woFB(1),  para_td_wFB1(1),  para_td_wFB2(1)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [para_asd_woFB(1), para_asd_wFB1(1), para_asd_wFB2(1)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Prior Parameter');

subplot(2, 1, 2);
hold on; grid on;
plot([0.8, 2, 3.2], sqrt([1/para_td_woFB(2),  1/para_td_wFB1(2),  1/para_td_wFB2(2)]), '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], sqrt([1/para_asd_woFB(2), 1/para_asd_wFB1(2), 1/para_asd_wFB2(2)]), '--o', 'LineWidth', 2);

legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Internal Noise Parameter');

%% Plot Model Prediction, Normal
figure; subplot(1, 2, 1); hold on; grid on;
[prior_woFB_td, theta, bias] = modelVis([para_td_woFB, 0], 0.68);
plot(theta, bias, 'LineWidth', 2);

[prior_wFB1_td, theta, bias] = modelVis([para_td_wFB1, 0], 0.68);
plot(theta, bias, 'LineWidth', 2);

[prior_wFB2_td, theta, bias] = modelVis([para_td_wFB2, 0], 0.68);
plot(theta, bias, 'LineWidth', 2);

title('Bias, Control');
xlabel('Orientation (deg)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Plot Model Prediction, ASD
subplot(1, 2, 2); hold on; grid on;
[prior_woFB_asd, theta, bias] = modelVis([para_asd_woFB, 0], 0.68);
plot(theta, bias, 'LineWidth', 2);

[prior_wFB1_asd, theta, bias] = modelVis([para_asd_wFB1, 0], 0.68);
plot(theta, bias, 'LineWidth', 2);

[prior_wFB2_asd, theta, bias] = modelVis([para_asd_wFB2, 0], 0.68);
plot(theta, bias, 'LineWidth', 2);

title('Bias, ASD');
xlabel('Orientation (deg)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Show Prior Distribution
domain = 0 : 0.01 : pi;
figure; subplot(1, 2, 1); hold on; grid on;
plot(domain, prior_woFB_td(domain), 'LineWidth', 2);
plot(domain, prior_wFB1_td(domain), 'LineWidth', 2);
plot(domain, prior_wFB2_td(domain), 'LineWidth', 2);
xlabel('Radius (pi)'); ylabel('Probability Density');
legend({'woFB', 'wFB1', 'wFB2'}); 
title('Prior across sessions, Control')

subplot(1, 2, 2); hold on; grid on;
plot(domain, prior_woFB_asd(domain), 'LineWidth', 2);
plot(domain, prior_wFB1_asd(domain), 'LineWidth', 2);
plot(domain, prior_wFB2_asd(domain), 'LineWidth', 2);
xlabel('Radius (pi)'); ylabel('Probability Density');
legend({'woFB', 'wFB1', 'wFB2'});
title('Prior across sessions, ASD')

%% Model - Data scatter Plot, Control
figure;
colors = get(gca, 'colororder');

load('woFB_td.mat');
subplot(1, 2, 1); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_td_woFB, 0], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(1, :));
scatter(allTarget, allResponse - allTarget, 0.5, colors(1, :));
ylim([-40, 40]);
xlabel('Orientation (deg)'); ylabel('Bias (deg)');
title('Bias, Control - woFB');

load('wFB2_td.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_td_wFB2, 0], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(2, :));
scatter(allTarget, allResponse - allTarget, 0.5, colors(2, :));
ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Control - wFB2');

%% Model - Data scatter Plot, ASD
figure;
colors = get(gca, 'colororder');

load('woFB_asd.mat');
subplot(1, 2, 1); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_asd_woFB, 0], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(1, :));
scatter(allTarget, allResponse - allTarget, 0.5, colors(1, :));
ylim([-40, 40]);
xlabel('Orientation deg)'); ylabel('Bias (deg)');
title('Bias, ASD - woFB');

load('wFB2_asd.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_asd_wFB2, 0], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(2, :));
scatter(allTarget, allResponse - allTarget, 0.5, colors(2, :));
ylim([-40, 40]);
xlabel('Orientation (deg)'); ylabel('Bias (deg)');
title('Bias, ASD - wFB2');
