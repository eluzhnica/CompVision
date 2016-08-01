%briefRotTest
img = imread('../data/model_chickenbroth.jpg');
imshow(img);
img = rgb2gray(img);
img = im2double(img);

[locs, desc] = briefLite(img);
ratio = 0.8;

match = zeros(36,1);

for i = 1:36
    newimg = imrotate(img, 10*i);
    [newlocs, newdesc] = briefLite(newimg);
    
    matches = briefMatch(desc, newdesc, ratio);
    match(i) = size(matches,1);
    
end

plot(10:10:360, match);
title('BRIEF descriptors');
xlabel('degress');
ylabel('matches');

