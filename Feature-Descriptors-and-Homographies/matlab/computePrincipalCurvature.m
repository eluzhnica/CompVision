function [PrincipalCurvature] = computePrincipalCurvature(DoGPyramid)
[m, n, l] = size(DoGPyramid);
PrincipalCurvature = zeros(m, n, l);

for k = 1:l
    [Dx, Dy] = gradient(DoGPyramid(:,:,k));
    [Dxx, Dxy] = gradient(Dx);
    [Dyx, Dyy] = gradient(Dy);
    
    for i = 1:m
        for j = 1:n
            H = [Dxx(i,j) Dxy(i,j); Dyx(i,j) Dyy(i,j)];
            PrincipalCurvature(i,j,k) = trace(H)^2/det(H);
        end
    end
    
end

end