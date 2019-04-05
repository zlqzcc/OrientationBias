function allPara = fitSubjects(dataDir, group)
%FITSUBJECTS Load data and run the fit for individual subject.

dir_woFB = dir(fullfile(dataDir, 'woFB', group, '*.mat'));
dir_wFB1 = dir(fullfile(dataDir, 'wFB1', group, '*.mat'));
dir_wFB2 = dir(fullfile(dataDir, 'wFB2', group, '*.mat'));
nSub = length(dir_woFB);

paraInit  = [repmat([1.5, 200], [1, 3]), 0.01];
optOption = 'bads';

allPara = zeros([nSub, 7]);
for idx = 1:nSub
    data = load(fullfile(dir_woFB(idx).folder, dir_woFB(idx).name));
    target_woFB   = data.target;
    response_woFB = data.target + data.bias;
    
    data = load(fullfile(dir_wFB1(idx).folder, dir_wFB1(idx).name));
    target_wFB1   = data.target;
    response_wFB1 = data.target + data.bias;
    
    data = load(fullfile(dir_wFB2(idx).folder, dir_wFB2(idx).name));
    target_wFB2   = data.target;
    response_wFB2 = data.target + data.bias;
    
    allPara(idx, :) = ...
        optWrapper(paraInit, target_woFB, response_woFB, target_wFB1, response_wFB1, target_wFB2, response_wFB2, optOption);
end
end
