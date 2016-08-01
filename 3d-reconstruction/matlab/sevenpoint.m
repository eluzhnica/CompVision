function [ F ] = sevenpoint( X, Y, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
    scale = [1/M 0 0; 0 1/M 0; 0 0 1];
    xscale = X ./ M;
    yscale = Y ./ M;
    pts1 = X;
    pts2 = Y;
    
    % Nx1 dimensional coordinate points.
    x = xscale(:,1);
    y = xscale(:,2);
    xp = yscale(:,1);
    yp = yscale(:,2);
    
    numPts = size(xp, 1);
    
    % Generate the Nx9 constraint matrix A.
    A = [x.*xp, ...
         x.*yp, ...
         x, ...
         y.*xp, ...
         y.*yp,  ...
         y,  ...
         xp,  ...
         yp,  ...
         ones(numPts, 1)];
    
    % Compute the SVD of A.
    [U, S, V] = svd(A);
    F1 = reshape(V(:,9), 3, 3);
    F2 = reshape(V(:,8), 3, 3);
    
    syms a;
    S = solve(0 == det(a*F1+(1-a)*F2), a);
    Sreal = real(double(S)); % could also use 'vpa' (variable precision arithmetic)
    
    F = cell(1,3);
    
    for iCell = 1:length(F)
        F{iCell} = Sreal(iCell)*F1 + (1-Sreal(iCell))*F2; 
        F{iCell} = scale'*F{iCell}*scale;
    end
    
%    save('q2_2.mat','F','M','pts1','pts2');


end

