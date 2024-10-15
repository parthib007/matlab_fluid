clc;
clear all;
close all;

A = [2 9 0 0; 
    0 4 1 4;
    7 5 5 1;
    7 8 7 4];
b = [-1
    6
    0
    9];
a=[3 -2 4 -5];

t1 = A.*b
t2 = a+4
t3 = b.*a
t4 = a.*b'
t5 = A.*a'