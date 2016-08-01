function [H2to1] = ransacH(matches, locs1, locs2, nIter, tol)

iterNum = nIter;
thDist = tol;

x = (locs1(matches(:,1),1:2)');
y = (locs2(matches(:,2),1:2)');

ptNum = size(x,2);

inlrNum = zeros(1,iterNum);
fLib = cell(1,iterNum);

for p = 1:iterNum
    % 1. fit using  random points
    sampleIdx = randperm(ptNum,4);
    H2to1 = computeH(x(:,sampleIdx),y(:,sampleIdx));
    
    % 2. count the inliers
    n = size(y,2);
    pts = H2to1*[y;ones(1,n)];
    pts = pts(1:2,:)./repmat(pts(3,:),2,1);
    dist = sum((x-pts).^2,1);
    
    inlier1 = find(dist < thDist);
    inlrNum(p) = length(inlier1);
    fLib{p} = computeH(x(:,inlier1),y(:,inlier1));
end

% 3. choose the coef with the most inliers
[~,idx] = max(inlrNum);
H2to1 = fLib{idx};

end