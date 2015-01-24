% ¼ÆËãÍ¼ÏñµÄHogÌØÕ÷
clc;
clear all;
close all;

I=imread('hog.png');
I_gray=rgb2gray(I);
F=hog(I_gray);