function [ locs, desc ] = briefLite( im )
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


[locs, ~] = DoGdetector(im, sigma0, k, levels, th_c, th_r);

%makeTestPattern(9,256);
load('testPattern.mat')

[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);

end

