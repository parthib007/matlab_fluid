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
E = sqrt((D_magcos(alfa)-Acos(theta)).^2+(D_magsin(alfa)-Asin(theta)).^2);
beta = acos((E.^2 + B^2 - C^2)./(2*EB));
gamma = - asin((D_magsin(alfa) - Asin(theta))./E)+pi;
omega = asin((D - (Asin(theta) + Bsin(gamma+beta)))./C);
P3 = [(Acos(theta) + Bcos(gamma+beta));(Asin(theta) + Bsin(gamma+beta))];
% delta = 10 deg
P5 = P4 + [(Fcos(omega+delta));(Fsin(omega+delta))];
P5_up = P4 + [(Fcos(omega+delta));(Fsin(omega+delta))+10];
P5_down = P4 + [(Fcos(omega+delta));(Fsin(omega+delta))-10];
theta_3 = atan((D_magsin(omega)-Asin(theta))./(D_mag + Ccos(omega)- Acos(theta)).*1);
JACO = (((Asin(theta - theta_3))./(Csin(omega - theta_3 ))).*1);
P5_v = abs(JACO.*ang_speed(1)*20);

theta1 = ang_speed(2)*t;
P21 = A*[cos(theta1); sin(theta1)];
alfa1 = atan(-1/3)+ pi;
E1 = sqrt((D_magcos(alfa1)-Acos(theta1)).^2+(D_magsin(alfa1)-Asin(theta1)).^2);
beta1 = acos((E1.^2 + B^2 - C^2)./(2E1B));
gamma1 = - asin((D_magsin(alfa) - Asin(theta1))./E1)+pi;
omega1 = asin((D - (Asin(theta1) + Bsin(gamma1+beta1)))./C);
P31 = [(Acos(theta1) + Bcos(gamma1+beta1));(Asin(theta1) + Bsin(gamma1+beta1))];
% delta = 10 deg
P51 = P4 + [(Fcos(omega1+delta));(Fsin(omega1+delta))];
P5_up1 = P4 + [(Fcos(omega1+delta));(Fsin(omega1+delta))+10];
P5_down1 = P4 + [(Fcos(omega1+delta));(Fsin(omega1+delta))-10];
theta_31 = atan((D_magsin(omega1)-Asin(theta1))./(D_mag + Ccos(omega1)- Acos(theta1)).*1);
JACO1 = (((Asin(theta1 - theta_31))./(Csin(omega1 - theta_31 ))).*1);
P5_v1 = abs(JACO1.*ang_speed(2)*20);

theta2 = ang_speed(3)*t;
P22 = A*[cos(theta2); sin(theta2)];
alfa2 = atan(-1/3)+ pi;
E2 = sqrt((D_magcos(alfa2)-Acos(theta2)).^2+(D_magsin(alfa2)-Asin(theta2)).^2);
beta2 = acos((E2.^2 + B^2 - C^2)./(2E2B));
gamma2 = - asin((D_magsin(alfa) - Asin(theta2))./E2)+pi;
omega2 = asin((D - (Asin(theta2) + Bsin(gamma2+beta2)))./C);
P32 = [(Acos(theta2) + Bcos(gamma2+beta2));(Asin(theta2) + Bsin(gamma2+beta2))];
% delta = 10 deg
P52 = P4 + [(Fcos(omega2+delta));(Fsin(omega2+delta))];
P5_up2 = P4 + [(Fcos(omega2+delta));(Fsin(omega2+delta))+10];
P5_down2 = P4 + [(Fcos(omega2+delta));(Fsin(omega2+delta))-10];
theta_32 = atan((D_magsin(omega2)-Asin(theta2))./(D_mag + Ccos(omega2)- Acos(theta2)).*1);
JACO2 = (((Asin(theta2 - theta_32))./(Csin(omega2 - theta_32 ))).*1);
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