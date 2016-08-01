% load all the data we need
addpath(genpath('../utils'));
addpath(genpath('external'));
addpath(genpath('../lib/esvm'));
load('../../data/bus_data.mat');
load('../../data/bus_esvm.mat');

image = '../../data/voc2007/';
pSize = 100;
alpha = 100;
K = 35; %will vary in a loop

sqBox = cell(1,length(models));
filterResponses = [];
origImg = [];

%get images from bounding boxes
for i=1:length(models)
   
    fprintf('i=%i/%i\n',i,length(models));
    
    %read image
    I = imread([image,models{i}.I]);
    
    imgBox = models{i}.gt_box;
    box = I(imgBox(2):imgBox(4),imgBox(1):imgBox(3),:);
    
    boxSq = imresize(box, [pSize pSize]);

    sqBox{i} = boxSq;
    rbox = rgb2gray(box);
    points = detectSURFFeatures(rbox);
    [imgResponses,~] = extractFeatures(rbox, points, 'Method','SURF', 'SURFSize', 128);    
    trow = randperm(size(imgResponses,1),min(alpha,size(imgResponses,1)));
    tresp = imgResponses(trow,:);    
    filterResponses = [filterResponses; tresp];
    origImg = [origImg; i*ones(numel(trow),1)];
    
end

avgPrecision = [];

for K=35:5:60
    [clusterBelonging, ~, ~, distanceToCenters] = kmeans(filterResponses, K, 'EmptyAction', 'drop');

    clusterRep = zeros(1,K);
    avgImages = cell(1,K);
    for i=1:K

        [~,pos] = min(distanceToCenters(:,i));
        clusterRep(i) = origImg(pos);
        idx_imgs = origImg(clusterBelonging==i);
        Iavg = zeros(pSize,pSize,3);
        for j=1:numel(idx_imgs)
            Iavg = Iavg + double(sqBox{idx_imgs(j)});
        end
        Iavg = uint8(Iavg/numel(idx_imgs));
        avgImages{i} = Iavg;
    end
    unique_mod = models(unique(clusterRep));
    
    
    params = esvm_get_default_params();
    params.detect_levels_per_octave = 3;
    [boundingBoxes] = batchDetectImageESVM(gtImages, unique_mod, params);
    [~,~,ap] = evalAP(gtBoxes,boundingBoxes);

    avgPrecision = [avgPrecision, ap];
    if(K==35)
        imdisp(avgImages);
    end

end
hold off;
plot(35:5:60, avgPrecision)
