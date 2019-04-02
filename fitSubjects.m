function para = fitSubjects(dataDir)

paraInit  = [1, 150, 0.015];
optOption = 'bads';

files = dir(dataDir);

for file = files'
    data = load(fullfile(file.folder, file.name));
    target   = data.target;
    response = data.target + data.bias;
    [para_woFB_td] = optWrapper(paraInit, allTarget, allResponse, optOption);
end
end
