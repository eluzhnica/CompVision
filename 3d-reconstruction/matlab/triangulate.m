function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%

% Make homogeneous
p1 = [ p1, ones(size(p1, 1),1)];
p2 = [ p2, ones(size(p2, 1),1)];

K1 = [];
K2 = [];
load('../data/intrinsics.mat');

p1 = inv(K1)*p1';
p2 = inv(K2)*p2';
p1=p1';
p2=p2';

sz = size(p1, 1);

solution = zeros(sz,4);
solution(:,4) = ones(sz,1);

for i=1:sz
point_1 = p1(i,:);
point_2 = p2(i,:);

A = [M1(3,1)*point_1(1)-M1(1,1), M1(3,2)*point_1(1)-M1(1,2), M1(3,3)*point_1(1)-M1(1,3);
     M1(3,1)*point_1(2)-M1(2,1), M1(3,2)*point_1(2)-M1(2,2), M1(3,3)*point_1(2)-M1(2,3);
     M2(3,1)*point_2(1)-M2(1,1), M2(3,2)*point_2(1)-M2(1,2), M2(3,3)*point_2(1)-M2(1,3);
     M2(3,1)*point_2(2)-M2(2,1), M2(3,2)*point_2(2)-M2(2,2), M2(3,3)*point_2(2)-M2(2,3)
    ];

y = [M1(1,4)-M1(3,4)*p1(1);
     M1(2,4)-M1(3,4)*p1(2);
     M2(1,4)-M2(3,4)*p2(1);
     M2(2,4)-M2(3,4)*p2(2)];

s = A\y;
solution(i,1:3)= s';
end

P = solution;

e1 = M1*P';
divider = [ones(2,sz);e1(3,:)];
e1 = e1 ./ divider;
e1 = e1' - p1;

e2 = M2*P';
divider = [ones(2,sz);e2(3,:)];
e2 = e2 ./ divider;
e2 = e2' - p2;

error = sum(e1,2).^2 + sum(e2,2).^2;
error = sum(error);

P = P(:,1:3);

end

