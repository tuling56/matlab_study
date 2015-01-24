% Matlab读取视频文件和摄像头的方法
%% （1）采用mmreader()读取视频文件并显示
%来自：http://blog.csdn.net/yanzi1225627/article/details/8273060
%对avi文件能正常的读取和显示，但对wmv文件则不能，获取帧数时候错误

clc;
clear;

% this to read avi by using mmread to get every frame
video = mmreader('street.avi');
nFrames = video.NumberOfFrames;   %得到帧数
H = video.Height;     %得到高度
W = video.Width;      %得到宽度
Rate = video.FrameRate;
% Preallocate movie structure.
mov(1:nFrames) = struct('cdata',zeros(H,W,3,'uint8'),'colormap',[]);

%read one frame every time
for i = 1:nFrames
    mov(i).cdata = read(video,i);
    P = mov(i).cdata;
     %disp('当前播帧数：'),disp(i);
     imshow(P),title('原始图片');
     
%     P2=rgb2gray(P);
end

%% （2）用VideoReader类进行视频读取和显示
%来自：http://blog.163.com/yuyang_tech/blog/static/2160500832013989110899/

fileName='square_track.AVI';
obj = VideoReader(fileName);
numFrames = obj.NumberOfFrames;% 帧的总数
 for k = 1 : numFrames  % 读取数据
     frame = read(obj,k);
     imshow(frame);%显示帧
     imwrite(frame,strcat('_input/track/',num2str(k),'.jpg'),'jpg');% 保存帧
end


%% （3） videoinput()函数读取摄像头
%来自：http://blog.csdn.net/sxjk1987/article/details/8819186
close all  
  
vidobj = videoinput('winvideo',1,'YUY2_320x240');  
triggerconfig(vidobj,'manual');  
start(vidobj);  
tic   
for i = 1:1000  
     snapshot = getsnapshot(vidobj);  %getsnapshot则是抓取一帧图像。
     frame = ycbcr2rgb(snapshot);  %YUV格式RGB格式
     
     %在这里添加图像处理程序
     
     imshow(frame);  
%    pause(0.033);  
end  
elapsedTime = toc  
timePerFrame = elapsedTime/1000  %真实帧率
effectiveFrameRate = 1/timePerFrame    %显示帧率
  
stop(vidobj);  
delete(vidobj);  
disp('end');