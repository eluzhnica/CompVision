function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses
 

%Convert input Image to Lab
doubleI = double(I);
if size(doubleI,3)==1
   doubleI = repmat(doubleI, 1,1,3);
end

[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);

%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);



%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===

for i=1:length(filterBank)
   filterToApply = filterBank{i}; 
   
   % reshaping to a column vector
   filterResponses(:, 3*i-2) = reshape(imfilter(L, filterToApply), pixelCount,1);
   filterResponses(:, 3*i-1) = reshape(imfilter(a, filterToApply), pixelCount,1);
   filterResponses(:, 3*i) = reshape(imfilter(b, filterToApply), pixelCount,1);
end

filterResponses = abs(filterResponses);

end
