function [ locs, desc ] = briefLiteRotation( im )
%BRIEFLITE Summary of this function goes here
%   Detailed explanation goes here

sigma0 = 1;
k = sqrt(2);
levels = [-1 0 1 2 3 4];
th_c = 0.03;
th_r = 12;

im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end

[~, gradientDir] = gradient(im);

%making 72 bins to be more precise
reshapedDir = reshape(gradientDir,1,size(gradientDir,1)*size(gradientDir,2));
histogram = hist(reshapedDir,72);
maxBin = max(histogram);

rotationAngle = -180 + find(histogram == maxBin)*5;

imRotated = imrotate(im,rotationAngle);


[locs, GaussianPyramid] = DoGdetector(imRotated, sigma0, k, levels, th_c, th_r);

%makeTestPattern(9,256);
load('testPattern.mat')

[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);

% apply the inverse rotation to the location determined on the rotated
% image. Note that imrotate works with angles so we have to be consistent.
 theta = -rotationAngle;
 rotationMatrix = ([cosd(theta), -sind(theta); sind(theta), cosd(theta)]);
 
 rotatedLocs = flipud(locs(:,1:2)');
 rotatedLocs = rotationMatrix * rotatedLocs;
 rotatedLocs = flipud(rotatedLocs)';
 
 locs = rotatedLocs;
%  maxY = max(rotatedLocs(:,2))
%  d1 = size(im,1) - maxY;
%  if(d1 < 0)
%     rotatedLocs(:,2) = rotatedLocs(:,2) + (d1);
%  end
%  
%  maxX = max(rotatedLocs(:,1))
%  d1 = size(im,2) - maxX;
%  if(d1<0)
%     rotatedLocs(:,1) = rotatedLocs(:,1) + (d1);
%  end
%  
%  
%  
%   %deal with clipping below
%  minY = min(rotatedLocs(:,2))
%  if(minY < 0)
%     rotatedLocs(:,2) = rotatedLocs(:,2) - minY;
%  end
%  
%  minX = min(rotatedLocs(:,1))
%  if(minX<0)
%     rotatedLocs(:,1) = rotatedLocs(:,1) - minX;
%  end
% 
% %  locs(:,1:2) = rotatedLocs';
%  
%  for i=1:size(locs,1) 
%     plot(rotatedLocs(i,1),rotatedLocs(i,2),'r.', 'MarkerSize', 10)
%  end

end

