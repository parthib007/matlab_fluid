%% 
clear all;
close all;
clc

%% Defining polynomial
poly_p = [3 5 7]

%% First derivative
p_der = polyder(poly_p)
p_der_val = polyval(p_der,0)

%% Central difference method
h = 0.2;
x0 = 0;
p_der_cdm = (polyval(poly_p,x0+h)-polyval(poly_p,x0-h))/(2*h)

%%

