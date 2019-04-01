%% Without Feedback
load('allData_woFB_td.mat');

paraInit = [1, 200];
[para_woFB, fval1] = optWrapper(paraInit, allTarget, allResponse);

%% With Feedback1
load('allData_wFB1_td.mat');

paraInit = [1, 50];
[para_wFB1, fval2] = optWrapper(paraInit, allTarget, allResponse);

%% With Feedback2
load('allData_wFB2_td.mat');

paraInit = [1, 50];
[para_wFB2, fval3, ~, ~] = optWrapper(paraInit, allTarget, allResponse);