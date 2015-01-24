
clear all;close all;clc;

imgDir = 'test pics/';
outDir = 'test pics/results/';
%rmdir(outDir);
if(exist('outDir','dir')==7)
    n=length(outDir);
    for i=1:n
      if (outDir(i).isdir && ~strcmp(outDir(i).name,'.') && ~strcmp(outDir(i).name,'..') )
        rmdir(outDir(i).name,'s')
      end
    end
end
mkdir(outDir)
cd ../BSR/BSDS500/data/images/test;
dirinfo=dir('*.jpg');
%cd ('E:\My DBank\ÏîÄ¿\³ÌÐò\Matlab\Canny edge detection');

tic;
for k =1:length(dirinfo)
%     outFile = fullfile(outDir,[D(k).name(1:end-4) '.bmp']);
%     if exist(outFile,'file'), continue; end
    imgFile=dirinfo(k).name;
    cvcanny(imgFile,k);
    close all;
end
toc;