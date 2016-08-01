function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made

%total times to run
n = 200;

threshold = 0.0008;
npts = size(pts1,1);
bestError = realmax;
bestF = [];
bestInliers = [];

X1 = [pts1, ones(npts,1)];
X2 = [pts2, ones(npts,1)];

for i=1:n
    
    model_pts_idx = randperm(npts,7);
    model_pts1 = pts1(model_pts_idx,:);
    model_pts2 = pts2(model_pts_idx,:);
    
    Fcandidates = sevenpoint(model_pts1, model_pts2, M);
    
    for i_f=1:numel(Fcandidates)
        F = Fcandidates{i_f};
        
        totalError = 0;
        allInliers = [];
        for i_x=1:npts
            pointError = abs(X2(i_x,:)*F*X1(i_x,:)');
            if(pointError < threshold)
                allInliers = [allInliers i_x];
            end
            totalError = totalError + pointError;
        end
        
        if  numel(allInliers)>numel(bestInliers) || ( totalError < bestError && numel(allInliers)>=numel(bestInliers) )
            bestError = totalError;
            bestInliers = allInliers;
            bestF = F;
        end
        
    end
    
end
F = bestF;
end