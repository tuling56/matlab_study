 %% Compute globalPb and hierarchical segmentation for an example image.

addpath(fullfile(pwd,'lib'));

%% 1. compute globalPb on a BSDS image (5Gb of RAM required)
clear all; close all; clc;

imgFile = 'data/101087.jpg';
outFile = 'data/101087_gPb.mat';

gPb_orient = globalPb(imgFile, outFile);

%% 2. compute Hierarchical Regions

% for boundaries
ucm = contours2ucm(gPb_orient, 'imageSize');
imwrite(ucm,'data/101087_ucm.bmp');

