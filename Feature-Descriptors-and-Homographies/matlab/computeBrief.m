function [locs, desc] = computeBrief(im, locs, levels, compareX, compareY)

patchWidth = 9;
halfWidth = ceil(patchWidth/2);
patchSize = [patchWidth, patchWidth];
number = 0;

sigma0 = 1;
k = sqrt(2);
% levels = [-1 0 1 2 3 4];

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);

desc = zeros(length(locs), length(compareX));
newlocs = zeros(size(locs));

for index = 1: length(locs)
    x = locs(index, 1);
    y = locs(index, 2);
    l = locs(index, 3);
    
    % check for points that are in the boundary
    if x > 4 && x <= size(im, 2)-4 && y > 4 && y <= size(im,1)-4
        number = number + 1;
        newlocs(number, :) = locs(index, :);
        
        for i = 1:length(compareX)
            [x1, y1] = ind2sub(patchSize, compareX(i));
            [x2, y2] = ind2sub(patchSize, compareY(i));
            
            %compute the BRIEF descriptor
            if GaussianPyramid(y+x1-halfWidth, x+y1-halfWidth, l) < GaussianPyramid(y+x2-halfWidth, x+y2-halfWidth, l)
                desc(number, i) = 1;
            else
                desc(number, i) = 0;
            end
        end
        
    end
end

locs = newlocs(1:number, :);
desc = desc(1:number, :);
end