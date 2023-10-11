function [x_rotx, y_rotx, z_rotx] = rotate_x(x, y, z, delta)
%ROTATE_X Function to rotate part of the bicycle around X axis
%   (x, y, z) - coordinates of part before rotation
%   delta - angle of rotation
%   [x_rotx, y_rotx, z_rotx] - coordinates of part after rotation
    x_rotx = x;
    y_rotx = y*cos(delta) - z*sin(delta);
    z_rotx = y*sin(delta) + z*cos(delta);
end
