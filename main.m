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
[~, theta, bias] = modelVis(para_woFB_td);
plot(theta/pi, bias/pi*180, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB1_td);
plot(theta/pi, bias/pi*180, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB2_td);
plot(theta/pi, bias/pi*180, 'LineWidth', 2);

title('Bias, Normal Control'); xlim([0, 1]); ylim([-10, 10]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});

%% Plot Model Prediction, ASD
subplot(1, 2, 2); hold on; grid on;
[~, theta, bias] = modelVis(para_woFB_asd);
plot(theta/pi, bias/pi*180, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB1_asd);
plot(theta/pi, bias/pi*180, 'LineWidth', 2);

[~, theta, bias] = modelVis(para_wFB2_asd);
plot(theta/pi, bias/pi*180, 'LineWidth', 2);

title('Bias, ASD'); xlim([0, 1]); ylim([-10, 10]);
xlabel('Orientation (pi)'); ylabel('Bias (deg)'); grid on;
legend({'woFB', 'wFB1', 'wFB2'});
