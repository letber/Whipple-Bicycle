function [moving_part] = move_bicycle_part(x_offset, y_offset, center_moving_part)
%MOVE_BICYCLE - Returns center of moving part with given respective offsets
% 
%   x_offset - change of X coordinate of moving part's center
%   y_offset - change of Y coordinate of moving part's center
%   center_moving_part - center of moving part, arrray with 3 elements
%   
moving_part = [center_moving_part(1)+x_offset center_moving_part(2)+y_offset center_moving_part(3)];
end

