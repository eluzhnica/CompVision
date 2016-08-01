function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%compute the extremas
img2_x = size(img2,1);
img2_y = size(img2,2);
img2_xpp = ones(3,4);
img2_xpp(:,1) = [1;1;1];
img2_xpp(:,2) = [img2_y;1;1];
img2_xpp(:,3) = [1;img2_x;1];
img2_xpp(:,4) = [img2_y;img2_x;1];
img2_xpp_w = H2to1*img2_xpp;
img2_xpp_w = bsxfun (@rdivide, img2_xpp_w, img2_xpp_w(3,:));

%apply traslations
y_trans = abs(min(0 , min(img2_xpp_w(2,:))));
x_trans = abs(min(0 , min(img2_xpp_w(1,:))));

%combined image size
x_max = max(size(img1,2),max(img2_xpp_w(1,:)));
x_min = min(1, min(img2_xpp_w(1,:)));
y_max = max(size(img1,1),max(img2_xpp_w(2,:)));
y_min = min(1, min(img2_xpp_w(2,:)));
combined_width = x_max - x_min;
combined_height = y_max - y_min;

fin_width = 1280;
fin_height = floor(combined_height*(fin_width/combined_width));

%compute M matrix
scale = fin_width/combined_width;
y_trans = y_trans*scale;
x_trans = x_trans*scale;
M = [scale 0 x_trans; 0 scale y_trans; 0 0 1];

img1_warped = warpH(img1, M, [fin_height, fin_width]);
img2_warped = warpH(img2, M*H2to1, [fin_height, fin_width]);

%blend images
out_size = [fin_height, fin_width];
panoImg = blend(img1_warped, img2_warped, out_size);

end