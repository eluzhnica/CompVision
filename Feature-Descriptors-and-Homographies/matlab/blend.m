function pano = blend(img1, img2, out_size)

% reference: http://stackoverflow.com/questions/23637908/how-to-blend-properly-stitching-images-in-matlab
% reference2: http://tobw.net/index.php?cat_id=2&project=Panorama+Stitching+Demo+in+Matlab

    %overlay
    frame = uint8(zeros([out_size 3]));
    frame(1:size(img1,1),1:size(img1,2),:) = img1;
    mask1 = (img2(:,:,1) == 0).*(img2(:,:,2) == 0).*(img2(:,:,3) == 0);
    mask2 = not(mask1);
    
    %fill image according to region (pulls right pixel using the masks)
    pano = uint8(zeros(size(img2)));
    pano(:,:,1) = uint8(mask1).*frame(:,:,1) + uint8(mask2).*img2(:,:,1);
    pano(:,:,2) = uint8(mask1).*frame(:,:,2) + uint8(mask2).*img2(:,:,2);
    pano(:,:,3) = uint8(mask1).*frame(:,:,3) + uint8(mask2).*img2(:,:,3);
    
end