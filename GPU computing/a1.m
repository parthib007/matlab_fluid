clc
close all;
clear all;

x=10/3
format short

x=10/3
format long

x=10/3
format bank

x=10/3
fprintf('text')

x=20/7
disp('text')

%%
clc
close all;
clear all;

t=0:pi/20:2*pi;
y=sin(t);
plot(t,y);
xlabel('X axis')
ylabel('Y axis')
title('Sine wave')

%%
t=0:pi/100:2*pi;
y=sin(t);
plotyy(t,y,t,y,'plot','stem');
xlabel('t')
ylabel('sin(t)')
title('Two Y axes')

%%
clc
close all;
clear all;

t=0:pi/10:2*pi;
plot(exp(i*t),'-o')
axis equal

%%
a=[1 2 3];
2*a

a=[4 5 6];
b=[1 2 3];
%a*b
a.*b

%%
clc
close all;
clear all;
x=-1:0.1:1;
y=((x+2).^2).*(x.^3+1);
plot(x,y)
title('problem 7')

%%
clc
close all;
clear all;
x=1:0.01:2;
y=(x.^2)./(x.^3+1)
plotyy(x,y,x,y)
title('problem 8')