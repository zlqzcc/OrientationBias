%% Fit Individual Subject
% Normal control
dataDir = './Data_mat_files/woFB/td/*.mat';
para_woFB_td = fitSubjects(dataDir);

dataDir = './Data_mat_files/wFB1/td/*.mat';
para_wFB1_td = fitSubjects(dataDir);

dataDir = './Data_mat_files/wFB2/td/*.mat';
para_wFB2_td = fitSubjects(dataDir);

% ASD
dataDir = './Data_mat_files/woFB/asd/*.mat';
para_woFB_asd = fitSubjects(dataDir);

dataDir = './Data_mat_files/wFB1/asd/*.mat';
para_wFB1_asd = fitSubjects(dataDir);

dataDir = './Data_mat_files/wFB2/asd/*.mat';
para_wFB2_asd = fitSubjects(dataDir);

%% Box plot, normal control
figure;
subplot(3, 2, 1);
boxplot([para_woFB_td(:, 1), para_wFB1_td(:, 1), para_wFB2_td(:, 1)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0.0, 2]);
title('prior (scale), normal control');

subplot(3, 2, 3);
boxplot([1./para_woFB_td(:, 2), 1./para_wFB1_td(:, 2), 1./para_wFB2_td(:, 2)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0, 0.03]);
title('internal noise, normal control');

subplot(3, 2, 5);
boxplot([para_woFB_td(:, 3), para_wFB1_td(:, 3), para_wFB2_td(:, 3)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0, 0.025]);
title('motor noise, normal control');

%% Box plot, ASD
subplot(3, 2, 2);
boxplot([para_woFB_asd(:, 1), para_wFB1_asd(:, 1), para_wFB2_asd(:, 1)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0.0, 2]);
title('prior (scale), ASD');

subplot(3, 2, 4);
boxplot([1./para_woFB_asd(:, 2), 1./para_wFB1_asd(:, 2), 1./para_wFB2_asd(:, 2)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0, 0.03]);
title('internal noise, ASD');

subplot(3, 2, 6);
boxplot([para_woFB_asd(:, 3), para_wFB1_asd(:, 3), para_wFB2_asd(:, 3)], 'Labels',{'woFB', 'wFB1', 'wFB2'});
ylim([0, 0.025]);
title('motor noise, ASD');
