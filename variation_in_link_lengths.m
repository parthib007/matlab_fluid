clc;
clear all;
close all;
A = 3; B = 20; C = 8; D = 4.8;F = 20  ; %defining link lengths
t = 0:0.05:10; %defining timestep for plotting
ang_speed = 2; %defining angular speed
theta = ang_speed*t;
P1 = [0;0];
P4 = D*[-3;1];
P2 = A*[cos(theta); sin(theta)]; 
alfa = atan(-1/3)+ pi;
D_mag = D*sqrt(10); % length of link D is actually 5*sqrt(10)
E = sqrt((D_mag*cos(alfa)-A*cos(theta)).^2+(D_mag*sin(alfa)-A*sin(theta)).^2);
beta = acos((E.^2 + B^2 - C^2)./(2*E*B));
gamma = - asin((D_mag*sin(alfa) - A*sin(theta))./E)+pi;
omega = asin((D - (A*sin(theta) + B*sin(gamma+beta)))./C);
P3 = [(A*cos(theta) + B*cos(gamma+beta));(A*sin(theta) + B*sin(gamma+beta))];
delta = 0.174553; % 10 degrees in radians
theta_3 = atan((D_mag*sin(omega)-A*sin(theta))./(D_mag + C*cos(omega)- A*cos(theta)).*1);
P5 = P4 + [(F*cos(omega+delta));(F*sin(omega+delta))]; % modeling wiper
P5_up = P4 + [(F*cos(omega+delta));(F*sin(omega+delta))+10]; % modeling wiper (upper end)
P5_down = P4 + [(F*cos(omega+delta));(F*sin(omega+delta))-10]; % modeling wiper (lower end)
P5_x = P5(1,:);
P5_y = P5(2,:);
P5_vx = diff(P5_x)./diff(t);
P5_vy = diff(P5_y)./diff(t);
P5_v = sqrt(P5_vx.^2 + P5_vy.^2); % calculating velocity using numerical differentiation (TURNED OUT TO BE WRONG)
area = 0;
x_left = 0;
x_right = 0;
angle = theta - gamma - beta;
for i=1:length(t);
   ani = subplot(2,1,1);
   P1_circle = viscircles(P1',0.05);
   P2_circle = viscircles(P2(:,i)',0.05);
   P3_circle = viscircles(P3(:,i)',0.05);
   P4_circle = viscircles(P4',0.05); 
   P5_circle = viscircles(P5(:,i)',0.05);
   
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
    plot(vel,t(1:i),P5_v(1:i)); %displaying the plot
    set(vel,'XLim',[0 10],'YLim',[0 30]);
    xlabel(vel, 'Time (s)');
    ylabel(vel, 'Amplitude (m/s');
    title(vel,'Speed of P5');
    grid on;
    
   end

end
area = 20*(x_left - x_right)


