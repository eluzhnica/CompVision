load('q21_data.mat');

bandwidth =100;  
threshold = bandwidth*0.01; 
[CCenters,CMemberships] = MeanShift(data,bandwidth,threshold);
save('q21_result.mat', 'CCenters', 'CMemberships');

cnum  = size(CCenters,1);
figure; hold on; axis equal
set(gcf,'color','w');
cc=hsv(cnum);
for cIdx = 1:cnum
    members = find(CMemberships == cIdx);
    plot(data(members,1),data(members,2),'.','color',cc(cIdx,:));
    plot(CCenters(cIdx,1),CCenters(cIdx,2),'k+','MarkerSize',10,'lineWidth',2)      
end
