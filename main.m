% Combined Subject
%% Without Feedback
load('woFB_td.mat');
paraInit = [1, 50];
[para_woFB_td, ~] = optWrapper(paraInit, allTarget, allResponse, 'bads');

load('woFB_asd.mat');
paraInit = [1, 50];
[para_woFB_asd, ~] = optWrapper(paraInit, allTarget, allResponse, 'bads');

%% With Feedback1
load('wFB1_td.mat');
paraInit = [1, 50];
[para_wFB1_td, ~] = optWrapper(paraInit, allTarget, allResponse, 'bads');

load('wFB1_asd.mat');
paraInit = [1, 50];
[para_wFB1_asd, ~] = optWrapper(paraInit, allTarget, allResponse, 'bads');

%% With Feedback2
load('wFB2_td.mat');
paraInit = [1, 50];
[para_wFB2_td, ~] = optWrapper(paraInit, allTarget, allResponse, 'bads');

load('wFB2_asd.mat');
paraInit = [1, 50];
[para_wFB2_asd, ~] = optWrapper(paraInit, allTarget, allResponse, 'bads');

%% Plot Parameter Change
figure; subplot(1, 2, 1);
hold on; grid on;
plot([0.8, 2, 3.2], [para_woFB_td(1), para_wFB1_td(1), para_wFB2_td(1)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [para_woFB_asd(1), para_wFB1_asd(1), para_wFB2_asd(1)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Prior Parameter');

subplot(1, 2, 2);
hold on; grid on;
plot([0.8, 2, 3.2], [1/para_woFB_td(2), 1/para_wFB1_td(2), 1/para_wFB2_td(2)], '--o', 'LineWidth', 2);
plot([0.8, 2, 3.2], [1/para_woFB_asd(2), 1/para_wFB1_asd(2), 1/para_wFB2_asd(2)], '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Noise Parameter');

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
scatter(allTarget/180*pi, allResponse - allTarget, 1, colors(1, :));
% xlim([0, 1]); ylim([-20, 20]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Normal Control - woFB');

load('wFB2_td.mat');
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis(para_wFB2_td, 0.95, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2, 'Color', colors(2, :));
scatter(allTarget/180*pi, allResponse - allTarget, 1, colors(2, :));
% xlim([0, 1]); ylim([-20, 20]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)');
title('Bias, Normal Control - wFB2');

%% Model - Data scatter Plot, ASD
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias, lb, ub] = modelVis(para_woFB_asd, 0.68, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2);

[~, theta, bias, lb, ub] = modelVis(para_wFB2_asd, 0.68, 0.1);
errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.2);

title('Bias, ASD'); xlim([0, 1]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB2'});
