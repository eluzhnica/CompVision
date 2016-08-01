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

x2 = zeros(size(x1,1),1);
y2 = x2;
for i=1:size(x2,1)
   [x2(i),y2(i)] = epipolarCorrespondence(im1,im2,F,x1(i),y1(i));
end
P = triangulate(M1,[x1,y1] , M2, [x2,y2]);

%save('q2_7.mat', 'F', 'pts1','pts2');
scatter3(P(:,1), P(:,2), P(:,3),2)