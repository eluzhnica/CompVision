load('../data/sylvseq.mat');
load('../data/sylvbases.mat')

rect = [102,62,156,108];
rect1 = rect;
width = abs(rect(1) - rect(3));
height = abs(rect(2) - rect(4));

[h,w,s] = size(frames);
rects = zeros(s,4);

for i=1:s-1
    i
    img = im2double(frames(:,:,i));
    imshow(img);
    hold on;
    rectangle('Position',[rect(1), rect(2), width, height], 'LineWidth',2, 'EdgeColor', 'g');
    rectangle('Position',[rect1(1), rect1(2), width, height], 'LineWidth',2, 'EdgeColor', 'r');
    hold off;

    pause(0.01);
    
    It = img;
    It1 = im2double(frames(:,:,i+1));
    
    [u,v] = LucasKanadeBasis(It, It1, rect, bases);
    [u1,v1] = LucasKanade(It, It1, rect1);
   
    rect = [rect(1)+u, rect(2)+v, rect(3)+u, rect(4)+v];
    rect = round(rect);
    
    rect1 = [rect1(1)+u1, rect1(2)+v1, rect1(3)+u1, rect1(4)+v1];
    rect1 = round(rect1);
    
    rects(i+1,:) = rect;
end

save('sylvseqrects.mat', 'rects');