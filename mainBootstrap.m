nRuns = 100;
para_td  = zeros(nRuns, 7);
para_asd = zeros(nRuns, 7);

%% Control Group
paraInit  = [repmat([1.5, 200], [1, 3]), 0.01];
optOption = 'bads';

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
    
    para_td(idx, :) = optWrapper(paraInit, ...
        target_woFB_resample, response_woFB_resample, ...
        target_wFB1_resample, response_wFB1_resample, ...
        target_wFB2_resample, response_wFB2_resample, optOption, 'final');
end

%% ASD Group
paraInit  = [repmat([1.5, 200], [1, 3]), 0.01];
optOption = 'bads';

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
    
    para_td(idx, :) = optWrapper(paraInit, ...
        target_woFB_resample, response_woFB_resample, ...
        target_wFB1_resample, response_wFB1_resample, ...
        target_wFB2_resample, response_wFB2_resample, optOption, 'final');
end

%% Plot (with errorbars)
