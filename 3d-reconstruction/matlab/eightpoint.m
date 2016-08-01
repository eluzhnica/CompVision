function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

pts1 = pts1 ./ M;
pts2 = pts2 ./ M;

X1 = pts1(:,1);
Y1 = pts1(:,2);
X2 = pts2(:,1);
Y2 = pts2(:,2);

A = [X1.*X2 X2.*Y1 X2 Y2.*X1 Y2.*Y1 Y2 X1 Y1 ones(size(X1))];

[~,~,V] = svd(A);
f = V(:,9);
F = reshape(f,3,3)';

[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

T = eye(3)/M;
T(3,3)=1;
F = refineF(F, pts1, pts2);
F = T*F*T;

%save('q2_1.mat','F','M','pts1','pts2');

end

