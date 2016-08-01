load('../data/carseq.mat');
rect = [60 117 146 152];
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
    hold off;

    pause(0.01);
    
    It = img;
    It1 = im2double(frames(:,:,i+1));
    
    [u,v] = LucasKanade(It, It1, rect);
    rect = [rect(1)+u, rect(2)+v, rect(3)+u, rect(4)+v];
    rect = round(rect);
    
    rects(i+1,:) = rect;
end

save('carseqrects.mat', 'rects');