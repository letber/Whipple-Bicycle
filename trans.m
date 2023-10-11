clc;
clear;

% Initial tilt and steer angles
PHI_INIT = 10*pi/180;
DELTA_INIT = 0;

syms phi(t) delta(t) omega(t) beta(t) T Y;

v = 4;
k = 1;
g = 9.81;
T_phi = 0;
T_delta = -94*sin(pi/10)*delta*0.08*0.72/1.02;

X = [phi; delta; omega; beta];
T_vect = [T_phi; T_delta];

Names = ['IBxx' 'IBxz' 'IByy' 'IBzz' 'IFxx' 'IFyy' 'IHxx' 'IHxz' 'IHyy' 'IHzz' 'IRxx' 'IRyy' 'c' 'g' 'lambda' 'mB' 'mF' 'mH' 'mR' 'rF' 'rR' 'w' 'xB' 'xH' 'zB' 'zH' 'v' 'k'];
Value = [9.2 2.4 11 2.8 0.1405 0.28 0.05892 -0.00756 0.06 0.00708 0.0603 0.12 0.08 9.81 pi/10 85 3 4 2 0.35 0.3 1.02 0.3 0.9 -0.9 -0.7 v k];
P = struct('IBxx', 9.2, 'IBxz', 2.4, 'IByy', 11, 'IBzz', 2.8, 'IFxx', 0.1405, 'IFyy', 0.28, 'IHxx', 0.05892, 'IHxz', -0.00756, 'IHyy', 0.06, 'IHzz', 0.00708, 'IRxx', 0.0603, 'IRyy', 0.12, 'c', 0.08, 'g', 9.81, 'lambda', 0.3141592653589793, 'mB', 85, 'mF', 3, 'mH', 4, 'mR', 2, 'rF', 0.35, 'rR', 0.3, 'w', 1.02, 'xB', 0.3, 'xH', 0.9, 'zB', -0.9, 'zH', -0.7, 'v', v, 'k', k);

[M, C_1, K_0, K_2] = compute_benchmark_bicycle_matrices(P);

disp(M);
disp(C_1);
disp(K_0);
disp(K_2);

A = [0 0 1 0;
    0 0 0 1;
    (M(2)*(g*K_0(3)+v.^2*K_2(3))-M(4)*(g*K_0(1)+v.^2*K_2(1)))/det(M) (M(2)*(g*K_0(4)+v.^2*K_2(4))-M(4)*(g*K_0(2)+v.^2*K_2(2)))/det(M) v*(C_1(3)*M(2)-C_1(1)*M(4))/det(M) v*(C_1(4)*M(2)-C_1(2)*M(4))/det(M);
    (M(3)*(g*K_0(1)+v.^2*K_2(1))-M(1)*(g*K_0(3)+v.^2*K_2(3)))/det(M) (M(3)*(g*K_0(2)+v.^2*K_2(2))-M(1)*(g*K_0(4)+v.^2*K_2(4)))/det(M) v*(C_1(1)*M(3)-C_1(3)*M(1))/det(M) v*(C_1(2)*M(3)-C_1(4)*M(1))/det(M)];

B = [0 0;
    0 0;
    M(4)/det(M) -M(2)/det(M);
    -M(3)/det(M) M(1)/det(M)];


ODE = diff(X) == A*X + B*T_vect;

[DEsys,  Subs] = odeToVectorField(ODE);
DEfync = matlabFunction(DEsys, 'Vars', {T, Y});
tspan = [0,50];
init_value = [PHI_INIT DELTA_INIT 0 0];
[T, Y] = ode45(DEfync, tspan, init_value);

plot(T, Y(:,1));
hold on;
plot(T, Y(:,2));
grid on;
legend('phi', 'delta', 'omega', 'beta');
