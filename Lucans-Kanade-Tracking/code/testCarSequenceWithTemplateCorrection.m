load('../data/carseq.mat');
rect = [60 117 146 152];
width = abs(rect(1) - rect(3));
height = abs(rect(2) - rect(4));

base_rect = rect;
base_template = im2double(frames(:,:,1));

[h,w,s] = size(frames);
rects = zeros(s,4);

for i=1:s-1
    i
    img = im2double(frames(:,:,i));
    size(img)
    imshow(img);
    hold on;
    rectangle('Position',[rect(1), rect(2), width, height], 'LineWidth',2, 'EdgeColor', 'g');
    hold off;

    pause(0.01);
    
    It = img;
    It1 = im2double(frames(:,:,i+1));
    size(It)
    size(It1)
    [u,v] = LucasKanade(It, It1, rect);
    rect1 = [rect(1)+u, rect(2)+v, rect(3)+u, rect(4)+v];
    rect1 = round(rect1);
    [u1,v1] = LucasKanade(base_template, It1, base_rect, ...
                        [rect(1) - base_rect(1) + u; rect(2) - base_rect(2) + v]);
                    
    rect2 = [base_rect(1)+u1, base_rect(2)+v1, base_rect(3)+u1, base_rect(4)+v1];
    rect2 = round(rect2);
    
    c = norm(rect2 - rect1);
    if(c<4)
       rect = rect2;
    end
    
    rects(i+1,:) = rect;
end

save('carseqrects-wcrt.mat', 'rects');