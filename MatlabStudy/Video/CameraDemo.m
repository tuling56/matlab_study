function CameraDemo()
%% 摄像头格式，根据实际情况自行设定
Format =  'MJPG_640x480';
%==========================================================================
%% 创建窗口.
figure_handle = figure('Name', 'Camera Demo',...
    'MenuBar', 'none',...
    'NumberTitle', 'off',...
    'ToolBar', 'none',...
    'Tag', 'camera_demo',...
    'Units', 'pixels');
myhandles = guihandles(figure_handle);
%% 设置全局变量
global count1 count2 save_flag
count1 = 0;
count2 = 0;
save_flag = false;
%==========================================================================
%% 设置参数
myhandles.vid_right = videoinput('winvideo', 1, Format);
myhandles.vid_left = videoinput('winvideo', 2, Format);
vidRes = get(myhandles.vid_right, 'VideoResolution');
set(myhandles.vid_right, 'ReturnedColorSpace', 'rgb',...
    'TimerPeriod', 0.01);
set(myhandles.vid_left, 'ReturnedColorSpace', 'rgb',...
    'TimerPeriod', 0.01);
triggerconfig(myhandles.vid_right, 'manual');
triggerconfig(myhandles.vid_left, 'manual');
set(figure_handle, 'Position', [500 300 2*vidRes(1)+10 vidRes(2)+100]);
%==========================================================================
%% 界面设计
myhandles.axes_left = axes('Parent', figure_handle,...
    'Tag', 'image',...
    'Units', 'pixels',...
    'Position',[0 100 vidRes(1) vidRes(2)],...
    'Color', [0 0 0],...
    'XTick',[],...
    'YTick',[]);
myhandles.axes_right = axes('Parent', figure_handle,...
    'Tag', 'image',...
    'Units', 'pixels',...
    'Position',[vidRes(1)+10 100 vidRes(1) vidRes(2)],...
    'Color', [0 0 0],...
    'XTick',[],...
    'YTick',[]);
myhandles.button_startStop = uicontrol('Parent', figure_handle,...
    'Style', 'pushbutton',...
    'Units', 'pixels',...
    'String', 'Start',...
    'Position', [20 30 60 30],...
    'CallBack',@startStop_callback);
myhandles.button_close = uicontrol('Parent', figure_handle,...
    'Style', 'pushbutton',...
    'Units', 'pixels',...
    'String', 'Close',...
    'Position', [230 30 60 30],...
    'CallBack', @close_callback);
myhandles.button_save = uicontrol('Parent', figure_handle,...
    'Style', 'pushbutton',...
    'Units', 'pixels',...
    'String', 'Save',...
    'Position', [390 30 60 30],...
    'CallBack', @save_callback);
%==========================================================================
%% 设置videoinput对象的定时器回调函数
set(myhandles.vid_right, 'TimerFcn', {@right_TimerFcn, myhandles});
set(myhandles.vid_left, 'TimerFcn', {@left_TimerFcn, myhandles});
guidata(figure_handle, myhandles) 
%% 将界面移到屏幕中心
movegui(figure_handle, 'center');
end

%==========================================================================
%% callback函数
%--------------------------------------------------------------------------
% 摄像头的定时器callback函数
function right_TimerFcn(hObject, eventdata, varargin)
global start_flag save_flag count1
myhandles = varargin{1};
if start_flag
    right = getsnapshot(hObject);
    set(gcf, 'CurrentAxes', myhandles.axes_right);
    imshow(right);
    if save_flag
        imwrite(right,['stereoimage\right',num2str(count1),'.bmp']);
        count1 = count1 + 1;
    end
end
end

function left_TimerFcn(hObject, eventdata, varargin)
global start_flag save_flag count2
myhandles = varargin{1};
if start_flag
    left = getsnapshot(hObject);
    set(gcf, 'CurrentAxes', myhandles.axes_left);
    imshow(left);
    if save_flag
        imwrite(left,['stereoimage\left',num2str(count2),'.bmp']);
        count2 = count2 + 1;
    end
end
end
%--------------------------------------------------------------------------
% 开始停止按钮的callback函数
function startStop_callback(hObject,eventdata)
global start_flag
myhandles = guidata(gcbo);
vid_right = myhandles.vid_right;
vid_left = myhandles.vid_left;
if strcmp('Stop', get(hObject, 'String'))
    stop(vid_right);
    stop(vid_left);
    set(hObject, 'String', 'Start');
    start_flag = false;
elseif strcmp('Start', get(hObject, 'String'))
    start(vid_right);
    start(vid_left);
    start_flag = true;
    set(hObject, 'String', 'Stop');
end
end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% 关闭按钮的callback函数
function close_callback(hObject,eventdata)
global start_flag
start_flag = false;
myhandles = guidata(gcbo);
vid_right = myhandles.vid_right;
vid_left = myhandles.vid_left;
choice = questdlg('Would you want to exit?', 'warning','Yes','No','No');
switch choice
    case 'Yes'
       stop(vid_right);
       delete(vid_right)
       stop(vid_left);
       delete(vid_left)
       close;
    case 'No'
        start_flag = true;
        return;
end
end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% 保存图片的callback函数
function save_callback(hObject,eventdata)
global save_flag
if exist('stereoimage', 'file') ~= 7
    mkdir('stereoimage')
else
    delete('stereoimage\*.bmp');
end
save_flag = true;
end