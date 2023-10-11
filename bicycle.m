clc;
clear;

% Set initial values for bicycle plot
c_rw = [0 0 0] ;    % center of rear wheel
c_fv = [0 0 0] ;    % begining of frame vertical
c_fh = [0 0 2] ;    % begining of frame horizontal part
c_fw = [0 6 0] ;    % center of front wheel
c_fav = [0 6 0];    % beginnig of front angled vertical
c_hb = [0 3 3];   % centre of handlebar
c_fwv = [0 6 0];    % centre of front wheel vertical
theta = linspace(0,2*pi);
length = linspace(0,2);
length_hb = linspace(-1,1);
r = 1;

% Initial tilt and steer angles
PHI_INIT = 5*pi/180;
DELTA_INIT = 0;

% Plot the bicycle
x_rw = c_rw(1)+0*sin(theta);
y_rw = c_rw(2)+r*sin(theta);
z_rw = c_rw(3)+r*cos(theta);
rear_wheel = [x_rw; y_rw; z_rw];

x_fv = c_fv(1)+0*length;
y_fv = c_fv(2)+0*length;
z_fv = c_fv(3)+1*length;
rear_frame_vert = [x_fv; y_fv; z_fv];

x_fh = c_fh(1)+0*length;
y_fh = c_fh(2)+2*length;
z_fh = c_fh(3)+0*length;
rear_frame_horizontal = [x_fh; y_fh; z_fh];

x_fw=c_fw(1)+0*sin(theta);
y_fw=c_fw(2)+r*sin(theta);
z_fw=c_fw(3)+r*cos(theta);
front_wheel = [x_fw; y_fw; z_fw];

x_fav=c_fav(1)+0*length;
y_fav=c_fav(2)-1.5*length;
z_fav=c_fav(3)+1.5*length;
front_angled_vertical = [x_fav; y_fav; z_fav];

x_hb=c_hb(1)+length_hb;
y_hb=c_hb(2)+0*length_hb;
z_hb=c_hb(3)+0*length_hb;
handlebar = [x_hb; y_hb; z_hb];

x_fwv=c_fwv(1)+0*length;
y_fwv=c_fwv(2)+0*length;
z_fwv=c_fwv(3)+1/2*length;
front_wheel_vertical = [x_fwv; y_fwv; z_fwv];

hold on;
graph_rw = plot3(rear_wheel(1),rear_wheel(2),rear_wheel(3), 'LineWidth',2, 'Color',[0 0 1]);
graph_fv = plot3(rear_frame_vert(1),rear_frame_vert(2),rear_frame_vert(3), 'LineWidth',2, 'Color',[0 0 1]);
graph_fh = plot3(rear_frame_horizontal(1), rear_frame_horizontal(2), rear_frame_horizontal(3), 'LineWidth',2, 'Color',[0 0 1]);
graph_fw = plot3(front_wheel(1), front_wheel(2), front_wheel(3), 'LineWidth',2, 'Color',[1 0 0]);
graph_fav = plot3(front_angled_vertical(1), front_angled_vertical(2), front_angled_vertical(3), 'LineWidth',2, 'Color',[1 0 0]);
graph_hb = plot3(handlebar(1), handlebar(2), handlebar(3), 'LineWidth', 2, 'Color',[1 0 0]);
graph_fwv = plot3(front_wheel_vertical(1), front_wheel_vertical(2), front_wheel_vertical(3), 'LineWidth', 2, 'Color',[1 0 0]);


% Plot the trace of wheels on xy plane
fw_trace = animatedline(c_fw(1), c_fw(2), c_fw(3)-r, 'Color','red', 'LineStyle','--');
rw_trace = animatedline(c_rw(1), c_rw(2), c_rw(3)-r, 'Color','blue');

axis equal
grid on


% Start solving whipple bicycle model computations

syms phi(t) delta(t) omega(t) beta(t) T Y;

v = 5;  % Constant velocity
k = 1;
g = 9.81;  % Gravitational attraction coefficient
T_phi = 0;
T_delta = -94*sin(pi/10)*delta*0.08*0.72/1.02;

X = [phi; delta; omega; beta];
T_vect = [T_phi; T_delta];


% WHipple-Carvallo model parameters 
Names = ['IBxx' 'IBxz' 'IByy' 'IBzz' 'IFxx' 'IFyy' 'IHxx' 'IHxz' 'IHyy' 'IHzz' 'IRxx' 'IRyy' 'c' 'g' 'lambda' 'mB' 'mF' 'mH' 'mR' 'rF' 'rR' 'w' 'xB' 'xH' 'zB' 'zH' 'v' 'k'];
Value = [9.2 2.4 11 2.8 0.1405 0.28 0.05892 -0.00756 0.06 0.00708 0.0603 0.12 0.08 9.81 pi/10 85 3 4 2 0.35 0.3 1.02 0.3 0.9 -0.9 -0.7 v k];
P = struct('IBxx', 9.2, 'IBxz', 2.4, 'IByy', 11, 'IBzz', 2.8, 'IFxx', 0.1405, 'IFyy', 0.28, 'IHxx', 0.05892, 'IHxz', -0.00756, 'IHyy', 0.06, 'IHzz', 0.00708, 'IRxx', 0.0603, 'IRyy', 0.12, 'c', 0.08, 'g', 9.81, 'lambda', 0.3141592653589793, 'mB', 85, 'mF', 3, 'mH', 4, 'mR', 2, 'rF', 0.35, 'rR', 0.3, 'w', 1.02, 'xB', 0.3, 'xH', 0.9, 'zB', -0.9, 'zH', -0.7, 'v', v, 'k', k);

[M, C_1, K_0, K_2] = compute_benchmark_bicycle_matrices(P);

A = [0 0 1 0;
    0 0 0 1;
    (M(2)*(g*K_0(3)+v.^2*K_2(3))-M(4)*(g*K_0(1)+v.^2*K_2(1)))/det(M) (M(2)*(g*K_0(4)+v.^2*K_2(4))-M(4)*(g*K_0(2)+v.^2*K_2(2)))/det(M) v*(C_1(3)*M(2)-C_1(1)*M(4))/det(M) v*(C_1(4)*M(2)-C_1(2)*M(4))/det(M);
    (M(3)*(g*K_0(1)+v.^2*K_2(1))-M(1)*(g*K_0(3)+v.^2*K_2(3)))/det(M) (M(3)*(g*K_0(2)+v.^2*K_2(2))-M(1)*(g*K_0(4)+v.^2*K_2(4)))/det(M) v*(C_1(1)*M(3)-C_1(3)*M(1))/det(M) v*(C_1(2)*M(3)-C_1(4)*M(1))/det(M)];

B = [0 0;
    0 0;
    M(4)/det(M) -M(2)/det(M);
    -M(3)/det(M) M(1)/det(M)];


% Solving ODE numerically
ODE = diff(X) == A*X + B*T_vect;

[DEsys,  Subs] = odeToVectorField(ODE);
DEfync = matlabFunction(DEsys, 'Vars', {T, Y});
tspan = [0,50];
init_value = [PHI_INIT DELTA_INIT 0 0];
[T, Y] = ode45(DEfync, tspan, init_value);

static_delt = Y(:,2);
static_phi = Y(:,1);


view(15, 30);
pause(3);

%Animation
% 813 - number of entry points in numerical solution for tspan 0:50 -
% natural duration of simulation

for t = 1:1:813
    dt = 0.06;
    delta_front = static_delt(t);
    phi = static_phi(t);
    velocity = [0 v 0];

    d_xi = v*delta_front/1.02;

    % Check if bicycle fell
    if abs(phi) >= pi/2
        break
    end
    
    % Move parts of bicycle

    [v_1, v_2, v_3] = rotate_z(velocity(1), velocity(2), velocity(3), d_xi);
    velocity = [v_1 v_2 v_3];

    mov_part_1 = c_rw;
    c_rw = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_1);
    x_rw = c_rw(1)+0*sin(theta);
    y_rw = c_rw(2)+r*sin(theta);
    z_rw = c_rw(3)+r*cos(theta);

    mov_part_2 = c_fv;
    c_fv = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_2);
    x_fv = c_fv(1)+0*length;
    y_fv = c_fv(2)+0*length;
    z_fv = c_fv(3)+1*length;
    
    mov_part_3 = c_fh;
    c_fh = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_3);
    x_fh = c_fh(1)+0*length;
    y_fh = c_fh(2)+2*length;
    z_fh = c_fh(3)+0*length;
    
    mov_part_4 = c_fw;
    c_fw = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_4);
    x_fw = c_fw(1)+0*sin(theta);
    y_fw = c_fw(2)+r*sin(theta);
    z_fw = c_fw(3)+r*cos(theta);

    mov_part_5 = c_fav;
    c_fav = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_5);
    x_fav=c_fav(1)+0*length;
    y_fav=c_fav(2)-1.5*length;
    z_fav=c_fav(3)+1.5*length;
    
    mov_part_6 = c_hb;
    c_hb = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_6);
    x_hb=c_hb(1)+length_hb;
    y_hb=c_hb(2)+0*length_hb;
    z_hb=c_hb(3)+0*length_hb;

    mov_part_7 = c_fwv;
    c_fwv = move_bicycle_part(velocity(1)*dt, velocity(2)*dt, mov_part_7);
    x_fwv = c_fwv(1)+0*length;
    y_fwv = c_fwv(2)+0*length;
    z_fwv = c_fwv(3)+1/2*length;

    % Rotate parts of bicycle

    [x_1, y_1, z_1] = rotate_y(x_rw, y_rw, z_rw, phi);
    [x, y, z] = rotate_z(x_1, y_1, z_1, d_xi);
    set(graph_rw,'XData',x,'YData',y,'ZData',z);

    [x_1, y_1, z_1] = rotate_y(x_fv, y_fv, z_fv, phi);
    [x, y, z] = rotate_z(x_1, y_1, z_1, d_xi);
    set(graph_fv,'XData',x,'YData',y,'ZData',z);

    addpoints(rw_trace, x, y, -1+0*z);

    [x_1, y_1, z_1] = rotate_y(x_fh, y_fh, z_fh, phi);
    [x, y, z] = rotate_z(x_1, y_1, z_1, d_xi);
    set(graph_fh,'XData',x,'YData',y,'ZData',z);

    [x_1, y_1, z_1] = rotate_z(x_fw, y_fw-(c_fh(2)+4), z_fw, delta_front);
    [x_2, y_2, z_2] = rotate_y(x_1, y_1+(c_fh(2)+4), z_1, phi);
    [x, y, z] = rotate_z(x_2, y_2, z_2, d_xi);
    set(graph_fw,'XData',x,'YData',y,'ZData',z);

    [x_1, y_1, z_1] = rotate_z(x_fav, y_fav-(c_fh(2)+4), z_fav, delta_front);
    [x_2, y_2, z_2] = rotate_y(x_1, y_1+(c_fh(2)+4), z_1, phi);
    [x, y, z] = rotate_z(x_2, y_2, z_2, d_xi);
    set(graph_fav,'XData',x,'YData',y,'ZData',z);

    [x_1, y_1, z_1] = rotate_z(x_hb, y_hb-(c_fh(2)+4), z_hb, delta_front);
    [x_2, y_2, z_2] = rotate_y(x_1, y_1+(c_fh(2)+4), z_1, phi);
    [x, y, z] = rotate_z(x_2, y_2, z_2, d_xi);
    set(graph_hb,'XData',x,'YData',y,'ZData',z);

    [x_1, y_1, z_1] = rotate_z(x_fwv, y_fwv-(c_fh(2)+4), z_fwv, delta_front);
    [x_2, y_2, z_2] = rotate_y(x_1, y_1+(c_fh(2)+4), z_1, phi);
    [x, y, z] = rotate_z(x_2, y_2, z_2, d_xi);
    set(graph_fwv,'XData',x,'YData',y,'ZData',z);
      
    addpoints(fw_trace, x, y, -1+0*z);

    % Move visible axis with bicycle 
    zlim([-1 4]);
    xlim([c_rw(1)-10, c_rw(1)+10]);
    ylim([c_rw(2)-10, c_rw(2)+10]);
    drawnow
end