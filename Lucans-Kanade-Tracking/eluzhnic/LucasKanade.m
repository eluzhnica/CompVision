function [ u,v ] = LucasKanade( It, It1, rect, init_guess )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (~exist('init_guess', 'var') || isempty(init_guess))
    init_guess = [0;0];
end
 
deltap = init_guess;

[Xt,Yt] = meshgrid(rect(1):rect(3), rect(2):rect(4));
template = interp2(It,Xt,Yt);
[gTx,gTy] = gradient(template);

%the Jacobian, W(x;p) = [x+p1;y+p2] => jacobian = [1 0;0 1]
%compute steepest descent
%[n^2 x2]
stpd = double([gTx(:), gTy(:)]);

%hessian [2 x 2]
hessian = stpd' * stpd;

count = 0;
while (count < 150)
   count = count + 1;
   u = deltap(1);
   v = deltap(2);
   
   [X,Y] = meshgrid(rect(1)+u : rect(3)+u, rect(2)+v : rect(4)+v);
   warpimg = interp2(It1, X,Y);
   
   %[nxn]
   err = warpimg - template;
   
   %[n^2 x1]
   err = err(:);
   
   %[2x1] = [2 x 2] \ (([2xn^2] x [n^2x1]) = [2x1])
   deltap_t = hessian\(stpd' * err);
   
   deltap = deltap - deltap_t;
   if (norm(deltap_t) < 0.01)
        break;
   end
end

end

