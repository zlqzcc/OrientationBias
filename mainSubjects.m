%% Fit Individual Subject
% Normal control
dataDir = './Data_mat_files';
group   = 'td';
allPara_td = fitSubjects(dataDir, group);

% ASD
dataDir = './Data_mat_files';
group   = 'asd';
allPara_asd = fitSubjects(dataDir, group);

%% Box plot of parameter change across session, normal control
figure;
subplot(3, 2, 1);
boxplot([allPara_td(:, 1), allPara_td(:, 3), allPara_td(:, 5)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0.0, 2]);
title('prior (scale), control');

subplot(3, 2, 3);
boxplot(sqrt([1./allPara_td(:, 2), 1./allPara_td(:, 4), 1./allPara_td(:, 6)]), 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0, 0.2]);
title('internal noise, control');

subplot(3, 2, 5);
boxplot(allPara_td(:, end), 'Labels', {'woFB/wFB1/wFB2'});
title('motor noise, control');

%% Box plot of parameter change across session, ASD
subplot(3, 2, 2);
boxplot([allPara_asd(:, 1), allPara_asd(:, 3), allPara_asd(:, 5)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0.0, 2]);
title('prior (scale), ASD');

subplot(3, 2, 4);
boxplot(sqrt([1./allPara_asd(:, 2), 1./allPara_asd(:, 4), 1./allPara_asd(:, 6)]), 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0, 0.2]);
title('internal noise, ASD');

subplot(3, 2, 6);
boxplot(allPara_asd(:, end), 'Labels', {'woFB/wFB1/wFB2'});
title('motor noise, ASD');
