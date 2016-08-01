function [ M ] = LucasKanadeAffine( It, It1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

deltaP = [1;1];

p = zeros(1,6);

[Xt,Yt] = meshgrid(1:size(It,2), 1:size(It,1));
Xp = Xt(:);
Yp = Yt(:);

while norm(deltaP) > 0.01
    W = [1+p(1) p(3) p(5);
            p(2) 1+p(4) p(6)];
    warpx = W(1)*Xt + W(3)*Yt + W(5);
    warpy = W(2)*Xt + W(4)*Yt + W(6);
    
    warped = interp2(Xt, Yt, It1, warpx, warpy);
    
    %remove the NAN
    warped(isnan(warped)) = 0;
    
    mask = zeros(size(It,1), size(It,2));
    mask = mask | (warpx >=1 & warpx <= size(It,2));
    mask = mask & (warpy >=1 & warpy <= size(It,1));
    
    error = It - warped;
    error = mask .* error;
    error = error(:);
    
    [dIx, dIy] = gradient(warped);
    dIx = mask .* dIx;
    dIy = mask .* dIy;
    grads = double([dIx(:) dIy(:)]);
    
    SD = [grads(:,1).*Xp grads(:,2).*Xp grads(:,1).*Yp grads(:,2).*Yp grads(:,1) grads(:,2)];

    H = SD' * SD;
    size(H);
    hes = SD' * error;
    
    deltaP = H\hes;
    size(deltaP);
    p = p + deltaP';

end
    
M = [1+p(1),p(3),p(5);p(2),1+p(4),p(6); 0, 0, 1];
    
end

