function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)
%GETFILTERBANK Summary of this function goes here
%   Detailed explanation goes here

K = 140;
alpha = 130;

filterBank = reshape(gaborFilterBank(5,8,39,39),40,1);

T = size(image_names,1);
F = size(filterBank,1);
N = 3 * F;

%pre allocate space
allResp = zeros(alpha*T, N);

for i = 1:length(image_names)
    disp(i);
    I = imread(image_names{i});
    imgResponses = extractFilterResponses(I,filterBank);
    pixels = randperm(size(imgResponses,1),alpha);
    pixelResp = imgResponses(pixels,:);
    
    start_i = 1 + (i-1)*alpha;
    end_i = start_i + alpha - 1;
    allResp( start_i:end_i, : ) = pixelResp;
    
end
[~, dictionary] = kmeans(allResp, K, 'EmptyAction', 'drop');
end

