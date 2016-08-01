function [ moving_image ] = SubtractDominantMotion( image1, image2 )
%SUBTRACTDOMINANTMOTION Summary of this function goes here
%   Detailed explanation goes here

threshold = 0.0005;

M = LucasKanadeAffine(image1, image2);

warped = warpH(image1, M, [size(image2,1) size(image2,2)]);

[X, Y] = meshgrid(1:size(image1,2), 1:size(image2,1));
wx = M(1,1)*X + M(1,2)*Y + M(1,3);
wy = M(2,1)*X + M(2,2)*Y + M(2,3);

mask = zeros(size(image2,1), size(image2,2));
mask = mask | (wx >=1 & wx <= size(image2,2));
mask = mask & (wy >=1 & wy <= size(image2,1));

dI = abs(image2 - warped);
dI = dI/255;
dI = mask .* dI;

moving_image = image2 .* (dI > threshold);

end

