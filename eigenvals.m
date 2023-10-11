clc;
clear;

syms phi(t) delta(t) omega(t) beta(t) v;

% v = 4;
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

A = [0 0 1 0;
    0 0 0 1;
    (M(2)*(g*K_0(3)+v.^2*K_2(3))-M(4)*(g*K_0(1)+v.^2*K_2(1)))/det(M) (M(2)*(g*K_0(4)+v.^2*K_2(4))-M(4)*(g*K_0(2)+v.^2*K_2(2)))/det(M) v*(C_1(3)*M(2)-C_1(1)*M(4))/det(M) v*(C_1(4)*M(2)-C_1(2)*M(4))/det(M);
    (M(3)*(g*K_0(1)+v.^2*K_2(1))-M(1)*(g*K_0(3)+v.^2*K_2(3)))/det(M) (M(3)*(g*K_0(2)+v.^2*K_2(2))-M(1)*(g*K_0(4)+v.^2*K_2(4)))/det(M) v*(C_1(1)*M(3)-C_1(3)*M(1))/det(M) v*(C_1(2)*M(3)-C_1(4)*M(1))/det(M)];

eigen_values = eig(A);

% to get v_w take i = 1 or 2, for v_c i=3. 
%
% eqn = real(eigen_values(i)) == 0;
% S = solve(eqn, v, 'MaxDegree', 4);
% R = round(S,6);
% disp (R);

v_w = 4.292383;
v_c = 6.024262;

v = 0:0.2:10;
hold on;
grid on;
xlim([0, 10]);
ylim([-10 10]);
xline(v_w, '-','Stable');
xline(v_c);
xline(0.68, '--');
fplot(real(eigen_values(1)));
fplot(real(eigen_values(2)));
fplot(real(eigen_values(3)));
fplot(real(eigen_values(4)));
fplot(imag(eigen_values(1)), '--r');
fplot(imag(eigen_values(2)), '--r');
fplot(imag(eigen_values(3)), '--r');
fplot(imag(eigen_values(4)), '--r');

rectangle('Position',[v_w, -10, v_c-v_w, 20], 'FaceColor',[0.5, 0.5, 0.5, 0.2]);
xlabel('v (m/s)');
ylabel('Eigenvalue \lambda');
xticks([0 0.68 2 4 4.292383 6 8 10]);
xticklabels({'0','V_d' ,'2','4','V_w','6 V_c','8','10',});
