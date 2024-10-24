clc; clear all; close all;

% Define simulation parameters(Eq 60)
k = 2000;
mu = 1; 
v = 2; 
h = 0.01;
k1 = 5; 
k2 = 5; 
k3 = 5; 
k4 = 5;

% Allocate memory for states
x = zeros(k,1); 
y = zeros(k,1); 
xh = zeros(k,1); 
yh = zeros(k,1);
u = zeros(k:1);

t = 0:h:(k-1)*h; % Time vector

% Control input
p = 0.1*sin(5*t);

% Initial conditions
x(1) = 2; 
y(1) = 6; 
xh(1) = 1; 
yh(1) = 1;

% Simulation loop
for i = 1:k-1
    yh(i+1) = yh(i) - h*mu*sign_function(yh(i)) - h*v*sign_function(x(i)) + h*k3*sign_function(x(i)-xh(i)) + h*k4*(x(i)-xh(i));
    xh(i+1) = xh(i) +  h*k1*sqrt(abs(x(i)-xh(i)))*sign_function(x(i)-xh(i)) + h*k2*(x(i)-xh(i)) + h*yh(i+1);
    y(i+1) = y(i) - h*mu*sign_function(yh(i+1)) - h*v*sign_function(x(i)+ h*(y(i) - h*mu*sign_function(yh(i)) - h*v*sign_function(x(i)))) + h*p(i+1);
    x(i+1) = x(i) + h*y(i+1);
end

% Calculate errors (assuming errors are the difference between actual and estimated states)
e1 = x - xh; % Error for x
e2 = y - yh; % Error for y

% Assuming s is defined appropriately for your system
s = e1+e2; 

u=-mu*sign_function(yh)-v*sign_function(x); %Equation 58

figure(1)
plot(x,y)
xlabel('x')
ylabel('y')
hold on
plot(xh,yh)
xlabel('x_{hat}')
ylabel('y_{hat}')
grid on
legend('x_k vs y_k','x_{hat} vs y_{hat}')
title('States with observer')

figure(2)
plot(t,u)
xlabel('t')
ylabel('u')
grid on
legend('Control u_k')
title('Control vs time')

figure(3)
plot(t,xh,t,yh,t,e1,t,e2,':r')
grid on
legend('x_{hat} vs y_{hat}','e_{1,k}','e_{2,k}')
title('State and error vs time')

figure(4)
plot(t,sign_function(yh),t,e1)
xlabel('t')
grid on
title('Sliding variable with time')
legend('y_{hat}','e_{1,k}')