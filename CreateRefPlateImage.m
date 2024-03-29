function [ref_image_BW, new_corners] = CreateRefPlateImage(im,corners, plate_mask_RGB, Params)
%   This function creates an image of the license plate in 2D (projects it to 2D)
%   Parameters:
%   im - original image
%   corners - cornerPoints array with properties of Location, Metric, Count.
%             Set of 4 points represents the corners of the license plate in the image
%   plate_mask_RGB - 

points_array_2D = [1,1 ;
                800, 1 ;
                1, 200 ;
                800, 200];

top_l = corners.Location(1,:);
top_r = corners.Location(2,:);
bot_l = corners.Location(3,:);
bot_r = corners.Location(4,:);

% Calculate width and height of the image:
upper_left = [top_l(1) , min(top_l(2),top_r(2))];
lower_right = [bot_r(1) , max(bot_l(2),bot_r(2))];
width = lower_right(1) - upper_left(1);
height = lower_right(2) - upper_left(2);

% compute H for the transformation:
Rect = [0, 0; width, 0; 0, height; width, height];

% compute H matrix
% Hto2D = computeH(points_array_2D, corners.Location);
Hto2D = computeH(Rect, corners.Location);

tform = projective2d(Hto2D);

masked_im = im.*plate_mask_RGB;

masked_im_gray = rgb2gray(masked_im);

% ref_image = imwarp(masked_im_gray, tform);
ref_image = imwarp(masked_im_gray, tform ,'OutputView',imref2d( size(masked_im_gray) ));

ref_image = imcrop(ref_image, [0, 0, width, height]);

% normalize
ref_image_BW  = double(ref_image) / 255;

% histogram equalization
ref_image_BW = histeq(ref_image_BW);

% thresholding
ref_image_BW = ref_image_BW < Params.CreateRefPlateImage.th;

% resize image
ref_image_BW = imresize(ref_image_BW,[200 800]);

SE = strel('disk',Params.CreateRefPlateImage.se_radius);
 
ref_image_BW = imclose(ref_image_BW, SE);
ref_image_BW = imdilate(ref_image_BW, SE);
ref_image_BW = bwareafilt(ref_image_BW, [Params.CreateRefPlateImage.size_thresh, inf]);

end 