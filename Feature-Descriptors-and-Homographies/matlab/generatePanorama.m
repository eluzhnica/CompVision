function [ pano ] = generatePanorama(img1,img2)
%GENERATEPANORAMA Summary of this function goes here
%   Detailed explanation goes here

im1 = im2double(img1);
if size(im1,3)==3
    im1= rgb2gray(im1);
end


im2 = im2double(img2);
if size(im2,3)==3
    im2= rgb2gray(im2);
end

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

matches = briefMatch(desc1,desc2);

[H2to1] = ransacH(matches, locs1, locs2, 2150, 5);
 
% plotMatches(img1,img2, [pIdx',pIdx'], locs1(matches(:,1),1:2), locs2(matches(:,2),1:2));
% hold on;
% p = locs1(matches(:,1),1:2)
% p = p(pIdx,:)
% for i=1:size(p,1) 
%      plot(p(i,1),p(i,2),'g.', 'MarkerSize', 12)
% end
% hold off;
 
pano = imageStitching_noClip(img1, img2, H2to1);
end

