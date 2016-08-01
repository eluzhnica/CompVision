function [refinedBBoxes ] = nms(bboxes, bandwidth, K)
stopThresh = bandwidth/1000;
refinedBBoxes = [];

w = bboxes(:,end);
w = 1 + (w - min(w(:)))/ (max(w(:)) - min(w(:)));
bboxes(:,end) = w;

[CCenters, CMemberships] = MeanShift(bboxes, bandwidth, stopThresh);
for i = 1:size(CCenters,1)
    boxMembership = bboxes(CMemberships==i,:);
    [~, pos] = max(boxMembership(:,end));
    refinedBBoxes = [refinedBBoxes; boxMembership(pos,:)];
end

if K<size(refinedBBoxes,1)
    [~,I]=sort(refinedBBoxes(:,end));
    refinedBBoxes=refinedBBoxes(I,:); 
    refinedBBoxes = refinedBBoxes(end-K+1:end,:);
end