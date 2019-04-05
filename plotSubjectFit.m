%% Control Group
dataDir = 'Data_mat_files';
group = 'td';

dir_woFB = dir(fullfile(dataDir, 'woFB', group, '*.mat'));
dir_wFB1 = dir(fullfile(dataDir, 'wFB1', group, '*.mat'));
dir_wFB2 = dir(fullfile(dataDir, 'wFB2', group, '*.mat'));
nSub = length(dir_woFB);

scatterSize = 10;
for idx = 1:nSub
    fig = figure('Renderer', 'painters', 'Position', [10 10 900 600]);
    set(gcf,'PaperOrientation','landscape');
    colors = get(gca,'colororder');
    
    data = load(fullfile(dir_woFB(idx).folder, dir_woFB(idx).name));
    subplot(2, 3, 4); hold on; grid on;
    [prior_woFB, theta, bias, lb, ub] = modelVis([allPara_td(idx, 1:2), allPara_td(idx, end)], 0.95, 0.2);
    errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(1, :));
    scatter(data.target/180, data.bias, scatterSize, colors(1, :));
    xlim([0, 1]); ylim([-40, 40]);
    xlabel('Orientation (pi)'); ylabel('Bias (deg)');
    title('Bias, Control - woFB');
    
    data = load(fullfile(dir_wFB1(idx).folder, dir_wFB1(idx).name));
    subplot(2, 3, 5); hold on; grid on;
    [prior_wFB1, theta, bias, lb, ub] = modelVis([allPara_td(idx, 3:4), allPara_td(idx, end)], 0.95, 0.2);
    errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(2, :));
    scatter(data.target/180, data.bias, scatterSize, colors(2, :));
    xlim([0, 1]); ylim([-40, 40]);
    xlabel('Orientation (pi)'); ylabel('Bias (deg)');
    title('Bias, Control - wFB1');
    
    data = load(fullfile(dir_wFB2(idx).folder, dir_wFB2(idx).name));
    subplot(2, 3, 6); hold on; grid on;
    [prior_wFB2, theta, bias, lb, ub] = modelVis([allPara_td(idx, 5:6), allPara_td(idx, end)], 0.95, 0.2);
    errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(3, :));
    scatter(data.target/180, data.bias, scatterSize, colors(3, :));
    xlim([0, 1]); ylim([-40, 40]);
    xlabel('Orientation (pi)'); ylabel('Bias (deg)');
    title('Bias, Control - wFB2');
    
    domain = 0 : 0.01 : pi;
    subplot(2, 3, 2); hold on; grid on;
    plot(domain, prior_woFB(domain), 'LineWidth', 2);
    plot(domain, prior_wFB1(domain), 'LineWidth', 2);
    plot(domain, prior_wFB2(domain), 'LineWidth', 2);
    xlim([0, pi]); ylim([0, 0.5]);
    xlabel('Radius (pi)'); ylabel('Probability Density');
    title('Prior across sessions, Control')
    
    suptitle(sprintf('Control Subject: %d', idx));
    set(gcf,'Visible','Off')
    
    saveDir = sprintf('./AllSubFigure/Control_%d', idx);
    print(fig, '-bestfit', saveDir, '-dpdf');
end

%% ASD Group
dataDir = 'Data_mat_files';
group = 'asd';

dir_woFB = dir(fullfile(dataDir, 'woFB', group, '*.mat'));
dir_wFB1 = dir(fullfile(dataDir, 'wFB1', group, '*.mat'));
dir_wFB2 = dir(fullfile(dataDir, 'wFB2', group, '*.mat'));
nSub = length(dir_woFB);

scatterSize = 10;
for idx = 1:nSub
    fig = figure('Renderer', 'painters', 'Position', [10 10 900 600]);
    set(gcf,'PaperOrientation','landscape');
    colors = get(gca,'colororder');
    
    data = load(fullfile(dir_woFB(idx).folder, dir_woFB(idx).name));
    subplot(2, 3, 4); hold on; grid on;
    [prior_woFB, theta, bias, lb, ub] = modelVis([allPara_asd(idx, 1:2), allPara_asd(idx, end)], 0.95, 0.2);
    errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(1, :));
    scatter(data.target/180, data.bias, scatterSize, colors(1, :));
    xlim([0, 1]); ylim([-40, 40]);
    xlabel('Orientation (pi)'); ylabel('Bias (deg)');
    title('Bias, ASD - woFB');
    
    data = load(fullfile(dir_woFB(idx).folder, dir_woFB(idx).name));
    subplot(2, 3, 5); hold on; grid on;
    [prior_wFB1, theta, bias, lb, ub] = modelVis([allPara_asd(idx, 3:4), allPara_asd(idx, end)], 0.95, 0.2);
    errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(2, :));
    scatter(data.target/180, data.bias, scatterSize, colors(2, :));
    xlim([0, 1]); ylim([-40, 40]);
    xlabel('Orientation (pi)'); ylabel('Bias (deg)');
    title('Bias, ASD - wFB1');
    
    data = load(fullfile(dir_wFB2(idx).folder, dir_wFB2(idx).name));
    subplot(2, 3, 6); hold on; grid on;
    [prior_wFB2, theta, bias, lb, ub] = modelVis([allPara_asd(idx, 5:6), allPara_asd(idx, end)], 0.95, 0.2);
    errorbar(theta, bias, bias - lb, ub - bias, 'LineWidth', 1.0, 'Color', colors(3, :));
    scatter(data.target/180, data.bias, scatterSize, colors(3, :));
    xlim([0, 1]); ylim([-40, 40]);
    xlabel('Orientation (pi)'); ylabel('Bias (deg)');
    title('Bias, ASD - wFB2');
    
    domain = 0 : 0.01 : pi;
    subplot(2, 3, 2); hold on; grid on;
    plot(domain, prior_woFB(domain), 'LineWidth', 2);
    plot(domain, prior_wFB1(domain), 'LineWidth', 2);
    plot(domain, prior_wFB2(domain), 'LineWidth', 2);
    xlim([0, pi]); ylim([0, 0.5]);
    xlabel('Radius (pi)'); ylabel('Probability Density');
    title('Prior across sessions, ASD')
    
    suptitle(sprintf('ASD Subject: %d', idx));
    set(gcf,'Visible','Off')
    
    saveDir = sprintf('./AllSubFigure/ASD_%d', idx);
    print(fig, '-bestfit', saveDir, '-dpdf');
end
