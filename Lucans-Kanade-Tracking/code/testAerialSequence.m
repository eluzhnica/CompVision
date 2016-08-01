load('../data/aerialseq.mat');

[h,w,s] = size(frames);

for i=1:s-1
    i
    img = im2double(frames(:,:,i));
   
    It = img;
    It1 = im2double(frames(:,:,i+1));
    
    [moving] = SubtractDominantMotion(It, It1);
    
    imshow(It1);
    hold on;
    
    [px, py] = find(moving > 0);
    
    plot(py,px,'r.','MarkerSize',2)
    
    hold off;
    
    pause(0.05);
end
