clc; clear all; close all;

% Define simulation parameters(Eq 44)
k = 1000;
w=5;
h = 0.01;
ke = 5; 
ks = 5; 
kx = 1.5;
Mv = 2; 
Mx = 1;

% Allocate memory for states
x = zeros(k,1); 
e = zeros(k,1); 
x_dot = zeros(k,1);
e_dot = zeros(k,1);
sx = zeros(k,1); 
se = zeros(k,1);
tau1 = zeros(k:1);
tau2 = zeros(k:1);

t = 0:h:(k-1)*h; % Time vector

% Control input(for simplicity)
p = 0.1*sin(w*t);

% Initial conditions
x(1) = 1; 
e(1) = 0; 
x_dot(1) = 0; 
e_dot(1) = 0;
sx(1) = 1.5;
se(1) = 0;

% Simulation loop
for i = 1:k-1
    tau1(i+1)=proj((se(i)-h*ks*se(i))/(h*Mv));
    tau2(i+1)=proj((sx(i)-h*ke*e_dot(i)-h*ks*se(i)-h*Mx*tau1(i+1))/(h*Mx));
    sx(i+1)=sx(i)-h*ke*e_dot(i)-h*ks*se(i)-h*Mv*tau1(i+1)-h*Mx*tau2(i+1)+h*x(i)*p(i+1);
    se(i+1)=se(i)-h*ks*se(i)-h*Mv*tau1(i+1)+h*x(i)*p(i+1);
    x(i+1)=(1/(1+h*kx))*(x(i)+h*sx(i+1));
    e(i+1)=(1/(1+h*ke))*(e(i)+h*se(i+1));
    x_dot(i+1)=(x(i+1)-x(i))/h;
    e_dot(i+1)=(e(i+1)-e(i))/h;
end

% Control
v=ke*e_dot+ks*se+Mv*sign_function(se);
u=-v-Mx*sign_function(sx)-kx*x_dot;

% Figures
figure(1)
plot(t,x,t,x_dot,t,e,t,e_dot)
xlabel('t')
grid on
legend('x','x^.','e','e^.')
title('States vs time')

figure(2)
plot(t,sx,t,se)
xlabel('t')
grid on
legend('s_{x,k}','s_{e,k}')
title('Sliding variables vs time')

figure(3)
plot(t,u)
xlabel('t')
ylabel('u')
grid on
legend('Control u_k')
title('Control vs time')

figure(4)
plot(t,tau1,t,tau2)
grid on
legend('\tau_1','\tau_2')
title('Multiplier vs time')