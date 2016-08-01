function [ loc ] = getLocalExtrema( DoGPyramid, DogLevels, PrincipalCurvature, th_contrast, th_r)
%GETLOCALEXTREMA Summary of this function goes here
%   Detailed explanation goes here

hLocalMax = vision.LocalMaximaFinder;
hLocalMax.MaximumNumLocalMaxima = size(DoGPyramid,1)*size(DoGPyramid,2);
hLocalMax.NeighborhoodSize = [3 3];
hLocalMax.Threshold = th_contrast;

loc = [];

for l=1:length(DogLevels)
    levelExtrema = step(hLocalMax, DoGPyramid(:,:,l));
    
    for p=1:size(levelExtrema,1)
        i = levelExtrema(p,2);
        j = levelExtrema(p,1);
        
        if(PrincipalCurvature(i,j) > th_r)
            if(l==1)
                if(DoGPyramid(i,j,1) > DoGPyramid(i,j,2))
                    loc = [loc; [j,i,1]];
                end
            elseif (l==length(DogLevels))
                if(DoGPyramid(i,j,l) > DoGPyramid(i,j,l-1))
                    loc = [loc; [j,i,1]];
                end
            else
                if(DoGPyramid(i,j,l) > DoGPyramid(i,j,l-1) && DoGPyramid(i,j,l) > DoGPyramid(i,j,l+1))
                    loc = [loc; [j,i,l]];
                end
            end
        end
    end
end

end

