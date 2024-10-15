clc;
clear all;
close all;
A = 3; B = 20; C = 9; D = 5;F = 20;
D_mag = 5*sqrt(10);
t = 0:0.02:5;
P1 = [0;0];
P4 = D*[-3;1];
delta = 0.174553;
ang_speed = [1 2 3];

theta = ang_speed(1)*t;
P2 = A*[cos(theta); sin(theta)]; 
alfa = atan(-1/3)+ pi;
E = sqrt((D_mag*cos(alfa)-A*cos(theta)).^2+(D_mag*sin(alfa)-A*sin(theta)).^2);
beta = acos((E.^2 + B^2 - C^2)./(2*E*B));
gamma = - asin((D_mag*sin(alfa) - A*sin(theta))./E)+pi;
omega = asin((D - (A*sin(theta) + B*sin(gamma+beta)))./C);
P3 = [(A*cos(theta) + B*cos(gamma+beta));(A*sin(theta) + B*sin(gamma+beta))];
% delta = 10 deg
P5 = P4 + [(F*cos(omega+delta));(F*sin(omega+delta))];
P5_up = P4 + [(F*cos(omega+delta));(F*sin(omega+delta))+10];
P5_down = P4 + [(F*cos(omega+delta));(F*sin(omega+delta))-10];
theta_3 = atan((D_mag*sin(omega)-A*sin(theta))./(D_mag + C*cos(omega)- A*cos(theta)).*1);
JACO = (((A*sin(theta - theta_3))./(C*sin(omega - theta_3 ))).*1);
P5_v = abs(JACO.*ang_speed(1)*20);

theta1 = ang_speed(2)*t;
P21 = A*[cos(theta1); sin(theta1)]; 
alfa1 = atan(-1/3)+ pi;
E1 = sqrt((D_mag*cos(alfa1)-A*cos(theta1)).^2+(D_mag*sin(alfa1)-A*sin(theta1)).^2);
beta1 = acos((E1.^2 + B^2 - C^2)./(2*E1*B));
gamma1 = - asin((D_mag*sin(alfa) - A*sin(theta1))./E1)+pi;
omega1 = asin((D - (A*sin(theta1) + B*sin(gamma1+beta1)))./C);
P31 = [(A*cos(theta1) + B*cos(gamma1+beta1));(A*sin(theta1) + B*sin(gamma1+beta1))];
% delta = 10 deg
P51 = P4 + [(F*cos(omega1+delta));(F*sin(omega1+delta))];
P5_up1 = P4 + [(F*cos(omega1+delta));(F*sin(omega1+delta))+10];
P5_down1 = P4 + [(F*cos(omega1+delta));(F*sin(omega1+delta))-10];
theta_31 = atan((D_mag*sin(omega1)-A*sin(theta1))./(D_mag + C*cos(omega1)- A*cos(theta1)).*1);
JACO1 = (((A*sin(theta1 - theta_31))./(C*sin(omega1 - theta_31 ))).*1);
P5_v1 = abs(JACO1.*ang_speed(2)*20);

theta2 = ang_speed(3)*t;
P22 = A*[cos(theta2); sin(theta2)]; 
alfa2 = atan(-1/3)+ pi;
E2 = sqrt((D_mag*cos(alfa2)-A*cos(theta2)).^2+(D_mag*sin(alfa2)-A*sin(theta2)).^2);
beta2 = acos((E2.^2 + B^2 - C^2)./(2*E2*B));
gamma2 = - asin((D_mag*sin(alfa) - A*sin(theta2))./E2)+pi;
omega2 = asin((D - (A*sin(theta2) + B*sin(gamma2+beta2)))./C);
P32 = [(A*cos(theta2) + B*cos(gamma2+beta2));(A*sin(theta2) + B*sin(gamma2+beta2))];
% delta = 10 deg
P52 = P4 + [(F*cos(omega2+delta));(F*sin(omega2+delta))];
P5_up2 = P4 + [(F*cos(omega2+delta));(F*sin(omega2+delta))+10];
P5_down2 = P4 + [(F*cos(omega2+delta));(F*sin(omega2+delta))-10];
theta_32 = atan((D_mag*sin(omega2)-A*sin(theta2))./(D_mag + C*cos(omega2)- A*cos(theta2)).*1);
JACO2 = (((A*sin(theta2 - theta_32))./(C*sin(omega2 - theta_32 ))).*1);
P5_v2 = abs(JACO2.*ang_speed(3)*20);

aera = 0;
x_left = 0;
x_right = 0;
angle = theta - gamma - beta;
J = P5_v/(ang_speed(1)*20)
for i=1:length(t);
   ani = subplot(2,1,1);
   P1_circle = viscircles(P1',0.02);
   P2_circle = viscircles(P2(:,i)',0.02);
   P3_circle = viscircles(P3(:,i)',0.02);
   P4_circle = viscircles(P4',0.02); 
   P5_circle = viscircles(P5(:,i)',0.02);
   
   A_bar = line([P1(1) P2(1,i)],[P1(2) P2(2,i)]);
   B_bar = line([P2(1,i) P3(1,i)],[P2(2,i) P3(2,i)]);
   C_bar = line([P3(1,i) P4(1)],[P3(2,i) P4(2)]);
   D_bar = line([P4(1) P5(1,i)],[P4(2) P5(2,i)]);
   E_bar = line([P5_down(1,i) P5_up(1,i)],[P5_down(2,i) P5_up(2,i)]);
   if angle(i) - 2*pi <= 0.05 
   x_left = P5(1,i);
   elseif angle(i) - 3*pi <= 0.05
   x_right = P5(1,i);
   end
   axis(ani,'equal');
   set(gca,'XLim',[-35 5],'YLim',[-5 35]);
   str1 = 'P5';
   str2 = ['Time elapsed: '  num2str(t(i)) ' s'];
   Time = text(-2,6,str2);
   pause(0.005);
   if i<length(t)
    delete(P1_circle);
    delete(P2_circle);
    delete(P3_circle);
    delete(P4_circle);
    delete(P5_circle);
    delete(A_bar);
    delete(B_bar);
    delete(C_bar);
    delete(D_bar);

    delete(Time);
     vel = subplot(2,1,2);
    plot(vel,t(1:i),P5_v(1:i),'r');hold on;
    plot(vel,t(1:i),P5_v1(1:i),'g');hold on;
    plot(vel,t(1:i),P5_v2(1:i),'b');
    legend('w=1rad/s','w=2rad/s','w=3rad/s')
    set(vel,'XLim',[0 5],'YLim',[0 100]);
    xlabel(vel, 'Time (s)');
    ylabel(vel, 'Amplitude (cm/s)');
    title(vel,'Speed of P5');
    grid on;
    
   end

end
aera = 20*(x_right - x_left)


