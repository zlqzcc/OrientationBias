function allPara = fitSubjects(dataDir)

paraInit  = [1.5, 150, 0.015];
optOption = 'bads';

allPara = [];
files = dir(dataDir);
for file = files'
    data = load(fullfile(file.folder, file.name));
    target   = data.target;
    response = data.target + data.bias;
    para = optWrapper(paraInit, target, response, optOption);
    
    allPara = [allPara; para];
end
end
