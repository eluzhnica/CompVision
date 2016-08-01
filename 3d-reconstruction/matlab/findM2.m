close all

load('../data/intrinsics.mat');
load('../data/some_corresp.mat');
load('../data/templeCoords.mat');
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1));
F = eightpoint(pts1, pts2, M);

M1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
E = essentialMatrix(F, K1, K2);
M2s = camera2(E);
M2 = findM2F(M1, M2s, pts1, pts2);
P = triangulate(M1,pts1,M2, pts2);
%save('q2_5.mat','M2','pts1','pts2','P');

