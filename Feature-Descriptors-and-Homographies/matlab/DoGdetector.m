function [ locs, GaussianPyramid ] = DoGdetector( im, sigma0, k, levels, th_contrast, th_r )
%DOGDETECTOR Summary of this function goes here
%   Detailed explanation goes here

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
principalCurvature = computePrincipalCurvature(DoGPyramid);
locs = [];
locs = getLocalExtrema(DoGPyramid, DoGLevels, principalCurvature, th_contrast, th_r);

end

