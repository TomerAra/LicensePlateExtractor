function [corners, status] = DetectPlateCorners(mask_im, Params)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

all_corners = detectHarrisFeatures(mask_im, 'FilterSize', Params.DetectPlateCorners.harris_filter_size);
corners = all_corners.selectStrongest(4);

corner_points = corners.Location;

[~,left_corners_indices] = mink(corner_points(:,1), 2);
[~,right_corners_indices] = maxk(corner_points(:,1), 2);

left_corners = corner_points(left_corners_indices,:);
left_corners = sortrows(left_corners, 2);

right_corners = corner_points(right_corners_indices,:);
right_corners = sortrows(right_corners, 2);

upper_left = left_corners(1,:);
lower_left = left_corners(2,:);

upper_right = right_corners(1,:);
lower_right = right_corners(2,:);

points_array = [upper_left ; upper_right ; lower_left ; lower_right];

corners = cornerPoints(points_array);

% check if a plate was found
status = false;
if(check_valid_plate(upper_left, upper_right, lower_left, lower_right, Params))
    status = true;
end

end

