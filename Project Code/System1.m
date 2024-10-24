clc; clear all; close all;

% Define simulation parameters(Eq 10)
k = 10000; 
a = 1; 
h = 0.001;
alpha = 2; 
w = 5; 
%w = 100; % Uncomment this line for Fig 3

% Allocate memory for states
x = zeros(k,1);
e = zeros(k,1);
tau1 = zeros(k,1);
tau2 = zeros(k,1);

t = 0:h:(k-1)*h; % Time vector

% Control input
p=0.1*sin(w*t);

% Initial Conditions
x(1) = 1;
e(1) = 0.5;

% Simulation loop
for i = 1:k-1
    tau2(i+1)=proj(e(i)/(alpha*h));
    tau1(i+1)=proj((x(i)-alpha*h*tau2(i))/(a*h));
    x(i+1) = x(i) - a*h*tau1(i+1) -alpha*h*tau2(i+1) + h*p(i+1);
    e(i+1) = e(i) - alpha*h*tau2(i+1) + h*p(i+1);
end
figure(1)
plot(t,x,t,e,':r')
grid on
legend('x_k','e_k')
title('State and error vs time')

figure(2)
plot(t,tau1,t,tau2,t,(p/alpha),':g')
grid on
legend('\tau_1','\tau_2','\psi_k/\alpha')
title('Multiplier and Perturbation vs time')
