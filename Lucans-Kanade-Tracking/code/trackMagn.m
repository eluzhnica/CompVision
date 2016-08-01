v = VideoReader('monitorMang.mp4');

frame = readFrame(v);

s = 180;
while(s>0)
   frame = readFrame(v); 
   s = s -1
end

s = 75;
while(s > 0)
    if(s < 10)
        pause(2);
    end
    imshow(readFrame(v))
    s = s - 1
end
frame = imresize(frame,0.3);
imshow(frame);
I = rgb2gray(frame);
[x,y] = ginput(4);

img = im2double(I);
rect = [min(x) min(y) max(x) max(y)];
width = abs(rect(1) - rect(3));
height = abs(rect(2) - rect(4));

rects = [];
i = 0;
while hasFrame(v)
    i = i + 1
    imshow(img);
    hold on;
    rectangle('Position',[rect(1), rect(2), width, height], 'LineWidth',2, 'EdgeColor', 'g');
    hold off;

    pause(0.01);
    It = img;
    It1 = rgb2gray(im2double(imresize(readFrame(v),0.3)));
    'enxhi'
    imshow(It1)
    pause(0.01)
    
    [u1,v1] = LucasKanade(It, It1, rect);
    rect = [rect(1)+u1, rect(2)+v1, rect(3)+u1, rect(4)+v1];
    rect = round(rect);
    
    rects = [rects; rect];
    img = It1;
end

v = VideoReader('monitorMang.mp4');
i = 1
while hasFrame(v)
   imshow(readFrame(v));
    i  = i+1;
    rect = rects(i,:);
    hold on;
    rectangle('Position',[rect(1), rect(2), width, height], 'LineWidth',2, 'EdgeColor', 'g');
    hold off;

    pause(0.01);   
end

save('magn.mat', 'rects');