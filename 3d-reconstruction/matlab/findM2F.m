% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat


function [M] = findM2F(M1, M2s, pts1, pts2)
bestscore = 0;
for i=1:4
    [P,~] = triangulate(M1, pts1, M2s(:,:,i), pts2);
    s = sum(P(3,:) > 0);
    if (s > bestscore)
        M = M2s(:,:,i);
        bestscore = s;
    end
end

end