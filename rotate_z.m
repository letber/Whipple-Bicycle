function [x_rotz, y_rotz, z_rotz] = rotate_z(x, y, z, delta)
%ROTATE_Z Function to rotate part of the bicycle around Z axis
%   (x, y, z) - coordinates of part before rotation
%   delta - angle of rotation
%   [x_rotz, y_rotz, z_rotz] - coordinates of part after rotation
    x_rotz = x*cos(delta) - y*sin(delta);
    y_rotz = x*sin(delta) + y*cos(delta);
    z_rotz = z;
end
