% Combined Subject
%% Without Feedback
paraInit  = [1, 150, 0.015];
optOption = 'bads';

load('woFB_td.mat');
[para_woFB_td] = optWrapper(paraInit, allTarget, allResponse, optOption);

load('woFB_asd.mat');
[para_woFB_asd] = optWrapper(paraInit, allTarget, allResponse, optOption);

%% With Feedback1
load('wFB1_td.mat');
[para_wFB1_td] = optWrapper(paraInit, allTarget, allResponse, optOption);

load('wFB1_asd.mat');
[para_wFB1_asd] = optWrapper(paraInit, allTarget, allResponse, optOption);

%% With Feedback2
load('wFB2_td.mat');
[para_wFB2_td] = optWrapper(paraInit, allTarget, allResponse, optOption);

load('wFB2_asd.mat');
[para_wFB2_asd] = optWrapper(paraInit, allTarget, allResponse, optOption);

%% Plot Parameter Change
figure; subplot(3, 1, 1);
hold on; grid on;
plot([0.8, 2, 3.2], [para_woFB_td(1), para_wFB1_td(1), para_wFB2_td(1)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [para_woFB_asd(1), para_wFB1_asd(1), para_wFB2_asd(1)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]); ylim([1.2, 1.7]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Prior Parameter');

subplot(3, 1, 2);
hold on; grid on;
plot([0.8, 2, 3.2], [1/para_woFB_td(2), 1/para_wFB1_td(2), 1/para_wFB2_td(2)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [1/para_woFB_asd(2), 1/para_wFB1_asd(2), 1/para_wFB2_asd(2)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
ax = gca;
ax.YRuler.Exponent = 0;
title('Int Noise Parameter');

subplot(3, 1, 3);
hold on; grid on;
plot([0.8, 2, 3.2], [para_woFB_td(3), para_wFB1_td(3), para_wFB2_td(3)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [para_woFB_asd(3), para_wFB1_asd(3), para_wFB2_asd(3)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Mtr Noise Parameter');

%% Plot Model Prediction, Normal
figure; subplot(1, 2, 1); hold on; grid on;
[~, theta, bias] = modelVis(para_woFB_td, 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB1_td, 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB2_td, 0.68);
plot(theta, bias, 'LineWidth', 2);

title('Bias, Normal Control'); xlim([0, 1]); ylim([-10, 10]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Plot Model Prediction, ASD
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias] = modelVis(para_woFB_asd, 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB1_asd, 0.68);
plot(theta, bias, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB2_asd, 0.68);
plot(theta, bias, 'LineWidth', 2);

title('Bias, ASD'); xlim([0, 1]); ylim([-10, 10]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Model - Data scatter Plot, Control
figure;
colors = get(gca,'colororder');

load('woFB_td.mat');
subplot(1, 2, 1); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis(para_woFB_td, 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(1, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(1, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Normal Control - woFB');

load('wFB2_td.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis(para_wFB2_td, 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(2, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(2, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Normal Control - wFB2');

%% Model - Data scatter Plot, ASD
figure;
colors = get(gca,'colororder');

load('woFB_asd.mat');
subplot(1, 2, 1); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis(para_woFB_asd, 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(1, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(1, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, ASD - woFB');

load('wFB2_asd.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis(para_wFB2_asd, 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(2, :));
scatter(allTarget/180, allResponse - allTarget, 0.5, colors(2, :));
xlim([0, 1]); ylim([-40, 40]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, ASD - wFB2');
