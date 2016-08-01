function [ CCenters, CMemberships ] = MeanShift(data, bandwith, stopThresh)
%MEANSHIFT Summary of this function goes here
%   Detailed explanation goes here

weights = data(:,end);
X = data(:,1:end-1);
[N,F] = size(X);

Xmeans = zeros(N,F);
for i=1:N
   Xi = X(i,:);
   
   diff = stopThresh + 1;
   while(diff > stopThresh)
       
       dist = bsxfun(@minus, X, Xi);
       dist = sqrt(sum(dist.^2,2));
       
       idx = dist < bandwith/2;
       
       XtmpMean = sum(bsxfun(@times, X(idx,:), weights(idx,:))) / sum(weights(idx,:));
       
       diff = norm(XtmpMean - Xi);
     
       Xi = XtmpMean;
   end
   
   Xmeans(i,:) = Xi; 
end

distThresh = norm(max(X)-min(X))/100;
CCenters = Xmeans(1,:);
CMemberships = zeros(N,1);
CMemberships(1) = 1;

for i=2:N
   Xi = Xmeans(i,:);
   
   [cdist, pos] = min(pdist2(CCenters,Xi));
   if cdist < distThresh
      CMemberships(i) = pos; 
   else
      CCenters = [CCenters; Xi]; 
      CMemberships(i) = size(CCenters,1);
   end
    
end

end

