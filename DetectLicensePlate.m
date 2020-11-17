function [LicensePlateMask] = DetectLicensePlate(im_RGB, Params)
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

%%%%%
if(Params.DetectLicensePlate.is_debug)
    figure();
    imshow(im_HSV,[]);
    title('im_HSV');
    impixelinfo;
end
%%%%%

% create a mask of pixels with yellow hue and specific saturation level only 
yellow_mask =(((h>=Params.DetectLicensePlate.h_low_thresh) & (h<=Params.DetectLicensePlate.h_high_thresh)) ...
                & (s>Params.DetectLicensePlate.s_low_thresh) &(v>Params.DetectLicensePlate.v_low_thresh));

%%%%%
if(Params.DetectLicensePlate.is_debug)
    figure();
    imshow(yellow_mask,[]);
    title('yellow_mask');
end
%%%%%

% filter mask by Eccentricity property
mask = bwpropfilt(yellow_mask, 'Eccentricity', [Params.DetectLicensePlate.eccentricity_low_thresh, Params.DetectLicensePlate.eccentricity_high_thresh]);

%%%%%
if(Params.DetectLicensePlate.is_debug)
    figure();
    imshow(mask,[]);
    title('mask - after Eccentricity filter');
end
%%%%%

% filter mask by EulerNumber property
mask = bwpropfilt(mask, 'EulerNumber', [Params.DetectLicensePlate.eulerNum_low_thresh, Params.DetectLicensePlate.eulerNum_high_thresh]);

%%%%%
if(Params.DetectLicensePlate.is_debug)
    figure();
    imshow(mask,[]);
    title('mask - after EulerNumber filter');
end
%%%%%

% se = strel('disk',3);
% mask = imclose(mask,se);

%%%%%
% if(Params.DetectLicensePlate.is_debug)
%     figure();
%     imshow(mask,[]);
%     title('mask - after imclose');
% end
%%%%%

% fill holes in the mask
filled_mask = imfill(mask,'holes');

%%%%%
if(Params.DetectLicensePlate.is_debug)
    figure();
    imshow(filled_mask,[]);
    title('mask - after filling holes');
end
%%%%%

% get information on all components in the mask
stats = regionprops(filled_mask, 'all');
area = [stats.Area];

% take only the component\s with the maximal area in the mask
white_plate = bwpropfilt(filled_mask, 'Area', [max(area)-1, max(area)+1]);

% convert mask to uint8
LicensePlateMask = uint8(white_plate);

end

