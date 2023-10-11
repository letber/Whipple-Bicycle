function [x_roty, y_roty, z_roty] = rotate_y(x, y, z, delta)
%ROTATE_Y Function to rotate part of the bicycle around Z axis
%   (x, y, z) - coordinates of part before rotation
%   delta - angle of rotation
%   [x_roty, y_roty, z_roty] - coordinates of part after rotation
    x_roty = z*sin(delta) + x*cos(delta);
    y_roty = y;
    z_roty = z*cos(delta) - x*sin(delta);
end
