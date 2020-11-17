function [corners] = DetectPlateCorners(mask_im, Params)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

all_corners = detectHarrisFeatures(mask_im, 'FilterSize', Params.DetectPlateCorners.harris_filter_size);
corners = all_corners.selectStrongest(4);

end

