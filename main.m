% Combined Subject
%% Control Group
paraInit  = [repmat([1.5, 200], [1, 3]), 0.01];
optOption = 'bads';

subData = load('woFB_td.mat');
target_woFB = subData.allTarget; response_woFB = subData.allResponse;

subData = load('wFB1_td.mat');
target_wFB1 = subData.allTarget; response_wFB1 = subData.allResponse;

subData = load('wFB2_td.mat');
target_wFB2 = subData.allTarget; response_wFB2 = subData.allResponse;

[para_td] = optWrapper(paraInit, target_woFB, response_woFB, target_wFB1, response_wFB1, target_wFB2, response_wFB2, optOption);

%% ASD Group
paraInit  = [repmat([1.5, 200], [1, 3]), 0.01];
optOption = 'bads';

subData = load('woFB_asd.mat');
target_woFB = subData.allTarget; response_woFB = subData.allResponse;

subData = load('wFB1_asd.mat');
target_wFB1 = subData.allTarget; response_wFB1 = subData.allResponse;

subData = load('wFB2_asd.mat');
target_wFB2 = subData.allTarget; response_wFB2 = subData.allResponse;

[para_asd] = optWrapper(paraInit, target_woFB, response_woFB, target_wFB1, response_wFB1, target_wFB2, response_wFB2, optOption);

%% Plot Parameter Change
figure; subplot(2, 1, 1);
hold on; grid on;
plot([0.8, 2, 3.2], [para_td(1), para_td(3), para_td(5)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [para_asd(1), para_asd(3), para_asd(5)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Prior Parameter');

subplot(2, 1, 2);
hold on; grid on;
plot([0.8, 2, 3.2], [1/para_td(2), 1/para_td(4), 1/para_td(6)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [1/para_asd(2), 1/para_asd(4), 1/para_asd(6)], '--o', 'LineWidth', 2);
ax = gca;
ax.YRuler.Exponent = 0;

legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Internal Noise Parameter');

%% Plot Model Prediction, Normal
figure; subplot(1, 2, 1); hold on; grid on;
[~, theta, bias] = modelVis([para_td(1:2), para_td(end)], 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis([para_td(3:4), para_td(end)], 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis([para_td(5:6), para_td(end)], 0.68);
plot(theta, bias, 'LineWidth', 2);

title('Bias, Control'); xlim([0, 1]); ylim([-10, 10]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Plot Model Prediction, ASD
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias] = modelVis([para_asd(1:2), para_asd(end)], 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis([para_asd(3:4), para_asd(end)], 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis([para_asd(5:6), para_asd(end)], 0.68);
plot(theta, bias, 'LineWidth', 2);

title('Bias, ASD'); xlim([0, 1]); ylim([-10, 10]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Model - Data scatter Plot, Control
figure;
colors = get(gca,'colororder');

load('woFB_td.mat');
subplot(1, 2, 1); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_td(1:2), para_asd(end)], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(1, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(1, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Control - woFB');

load('wFB2_td.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_td(5:6), para_asd(end)], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(2, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(2, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Control - wFB2');

%% Model - Data scatter Plot, ASD
figure;
colors = get(gca,'colororder');

load('woFB_asd.mat');
subplot(1, 2, 1); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_asd(1:2), para_asd(end)], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(1, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(1, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, ASD - woFB');

load('wFB2_asd.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis([para_asd(5:6), para_asd(end)], 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(2, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(2, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, ASD - wFB2');
