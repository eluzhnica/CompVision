function [H2to1] = computeH(p1, p2)

    %get number of examples (N)
    N = size(p1,2);

    %append the 3rd column (of 1's)
    p2 = [p2; ones(1,N)]; %P2 is now 3xN

    %use these points to create the A matrix
    A = zeros(2*N,9);
    for i=1:N
        u = p1(1,i);
        v = p1(2,i);
        p2t = p2(:,i)';
        A(2*i - 1, :) = [p2t 0 0 0 -u*p2t];
        A(2*i, :) = [0 0 0 p2t -v*p2t];
    end
    
    [U,S,V] = svd(A);
     H2to1 = V(:,size(V,2));
     H2to1 = reshape(H2to1, 3,3).';
  
    
end