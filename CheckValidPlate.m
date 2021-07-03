function [result] = CheckValidPlate(upper_left, upper_right, lower_left, lower_right, Params)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

result = true;

if (abs(upper_left(2)-upper_right(2)) > Params.CheckValidPlate.height_tol || ...
    abs(lower_left(2)-lower_right(2)) > Params.CheckValidPlate.height_tol || ...
    abs(upper_left(1)-lower_left(1)) > Params.CheckValidPlate.width_tol || ...
    abs(upper_right(1)-lower_right(1)) > Params.CheckValidPlate.width_tol)
    result = false;
end

end

