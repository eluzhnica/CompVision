function [boundingBoxes] = batchDetectImageESVM(imageNames, models, params)

numCores = 2;
imageDir = '../../data/voc2007';

% Close the pools, if any
try
    fprintf('Closing any pools...\n');
    delete(gcp('nocreate'));
catch ME
    disp(ME.message);
end
fprintf('Will process %d files in parallel to compute detection ...\n',length(imageNames));
fprintf('Starting a pool of workers with %d cores\n', numCores);
parpool('local',numCores);

l = length(imageNames);

boundingBoxes = cell(l,1);
parfor i=1:l
    I = imread(fullfile(imageDir, imageNames{i}));
    boundingBoxes{i} = esvm_detect(I,models,params);
end

save('boundingBoxes.mat','boundingBoxes');

delete(gcp('nocreate'));

end