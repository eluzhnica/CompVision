function [ DoGPyramid, DoGLevels ] = createDoGPyramid( GaussianPyramid,levels )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

DoGPyramid = zeros( size(GaussianPyramid,1), size(GaussianPyramid,2), length(levels)-1);

for i=2:length(levels)
   DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i-1); 
end

DoGLevels = levels(2:end);
end

