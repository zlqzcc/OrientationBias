nRuns = 20;
all_para_td  = zeros(nRuns, 7);
all_para_asd = zeros(nRuns, 7);

%% Control Group
paraInit  = para_td;
optOption = 'fminsearch';

subData = load('woFB_td.mat');
target_woFB = subData.allTarget; response_woFB = subData.allResponse;

subData = load('wFB1_td.mat');
target_wFB1 = subData.allTarget; response_wFB1 = subData.allResponse;

subData = load('wFB2_td.mat');
target_wFB2 = subData.allTarget; response_wFB2 = subData.allResponse;

for idx = 1:nRuns
    fprintf('Bootstrap run %d / %d - Control group \n', idx, nRuns);
    
    [target_woFB_resample, response_woFB_resample] = resample(target_woFB, response_woFB);
    [target_wFB1_resample, response_wFB1_resample] = resample(target_wFB1, response_wFB1);
    [target_wFB2_resample, response_wFB2_resample] = resample(target_wFB2, response_wFB2);
    
    all_para_td(idx, :) = optWrapper(paraInit, ...
        target_woFB_resample, response_woFB_resample, ...
        target_wFB1_resample, response_wFB1_resample, ...
        target_wFB2_resample, response_wFB2_resample, optOption, 'iter');
end

%% ASD Group
paraInit  = para_asd;
optOption = 'fminsearch';

subData = load('woFB_asd.mat');
target_woFB = subData.allTarget; response_woFB = subData.allResponse;

subData = load('wFB1_asd.mat');
target_wFB1 = subData.allTarget; response_wFB1 = subData.allResponse;

subData = load('wFB2_asd.mat');
target_wFB2 = subData.allTarget; response_wFB2 = subData.allResponse;

for idx = 1:nRuns
    fprintf('Bootstrap run %d / %d - ASD group \n', idx, nRuns);
    
    [target_woFB_resample, response_woFB_resample] = resample(target_woFB, response_woFB);
    [target_wFB1_resample, response_wFB1_resample] = resample(target_wFB1, response_wFB1);
    [target_wFB2_resample, response_wFB2_resample] = resample(target_wFB2, response_wFB2);
    
    all_para_asd(idx, :) = optWrapper(paraInit, ...
        target_woFB_resample, response_woFB_resample, ...
        target_wFB1_resample, response_wFB1_resample, ...
        target_wFB2_resample, response_wFB2_resample, optOption, 'iter');
end

%% Plot Parameter Change
figure; subplot(2, 1, 1);
hold on; grid on;
errorbar([0.8, 2, 3.2], mean(all_para_td(:, [1, 3, 5])),  2 * std(all_para_td(:, [1, 3, 5])), '--o', 'LineWidth', 2);
errorbar([0.8, 2, 3.2], mean(all_para_asd(:, [1, 3, 5])), 2 * std(all_para_asd(:, [1, 3, 5])), '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Prior Parameter');

subplot(2, 1, 2);
hold on; grid on;
errorbar([0.8, 2, 3.2], mean(sqrt(1./all_para_td(:, [2, 4, 6]))),  2 * std(sqrt(1./all_para_td(:, [2, 4, 6]))), '--o', 'LineWidth', 2);
errorbar([0.8, 2, 3.2], mean(sqrt(1./all_para_asd(:, [2, 4, 6]))), 2 * std(sqrt(1./all_para_asd(:, [2, 4, 6]))), '--o', 'LineWidth', 2);
legend({'Normal', 'ASD'});
xlim([0.5, 3.5]); xticks([0.8, 2, 3.2]);
xticklabels({'woFB', 'wFB1', 'wFB2'});
title('Internal Noise Parameter');
suptitle('parameter change, combined subject');
