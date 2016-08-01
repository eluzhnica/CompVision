im1 = imread('../data/pf_scan_scaled.jpg');

im1 = im2double(im1);
if size(im1,3)==3
    im1= rgb2gray(im1);
end

im2 = imread('../data/pf_desk.jpg');

i2m = im2double(im2);
if size(im2,3)==3
    im2= rgb2gray(im2);
end

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

matches = briefMatch(desc1,desc2);
plotMatches(im1,im2,matches, locs1,locs2);

%  hold on;
% 
%  for i=f
%      plot(locs1(i,1),locs1(i,2),'g.', 'MarkerSize', 12)
%  end
%  
%  for i=f
%      plot(size(im1,2) + locs2(i,1), locs2(i,2),'b.', 'MarkerSize', 12)
%  end
%  
%  hold off;