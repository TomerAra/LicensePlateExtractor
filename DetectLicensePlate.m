function [LicensePlateMask] = DetectLicensePlate(im_RGB)
% Detects a license plate in the image
%
% Two options:
% - Detects the License plate in the image and returns a binary mask of the plate
% - Can't detect any license plate in the image and returns an indicator for that
%
% Returns a mask of the license plate

% convert image to HSV
im_HSV = rgb2hsv(im_RGB);
h = im_HSV(:,:,1);
s = im_HSV(:,:,2);
v = im_HSV(:,:,3);

% create a mask of pixels with yellow hue and specific saturation level only 
yellow_mask =(((h>=0.1) & (h<=0.18)) & (s>0.35) &(v>0.5));

% filter mask by Eccentricity property
mask = bwpropfilt(yellow_mask, 'Eccentricity', [0.8 1]);

% filter mask by EulerNumber property
mask = bwpropfilt(mask, 'EulerNumber', [-50 -6]);

% fill holes in the mask
filled_mask = imfill(mask,'holes');

% get information on all components in the mask
stats = regionprops(filled_mask, 'all');
area = [stats.Area];

% take only the component\s with the maximal area in the mask
white_plate = bwpropfilt(filled_mask, 'Area', [max(area)-1, max(area)+1]);

% convert mask to uint8
LicensePlateMask = uint8(white_plate);

end

