clear all; close all; clc;
img=imread('aPICT0025.JPG');
grayimg=rgb2gray(img);
[cannyimg,thresh]=edge(grayimg,'canny');
disp(thresh);


