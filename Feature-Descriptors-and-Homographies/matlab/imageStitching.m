function [ panoImg ] = imageStitching(img1, img2, H2to1)
%IMAGESTITCHING Summary of this function goes here
%   Detailed explanation goes here

%  [locs1, desc1] = briefLite(img1);
%  [locs2, desc2] = briefLite(img2);
% 
%  matches = briefMatch(desc1,desc2);

% H = computeH(locs1(matches(:,1),1:2), locs2(matches(:,2),1:2));
% H2to1  = computeH([457, 462, 700, 600; 116,401,475,216], [123,137,392,280;155,465,515,266]);
 
    warpedImg = warpH(img2, H2to1, [size(img1,1) size(img1,2)+size(img2,2)]);
    
    %overlay
    panoImg = blend(img1, warpedImg, [size(img1,1) size(img1,2)+size(img2,2)]);

end

