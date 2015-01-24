function varargout = example6_3_3(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @example6_3_3_OpeningFcn, ...
                   'gui_OutputFcn',  @example6_3_3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function example6_3_3_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

global flag
flag = 0;
set(handles.axes1, 'colororder', [0 0 1], 'units', 'normalized', 'position', [0 0 1 1])

guidata(hObject, handles);

function varargout = example6_3_3_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
global flag pos1
if strcmp(get(gcf,'selectiontype'),'alt')
    cla;
elseif strcmp(get(gcf,'selectiontype'),'open')
    col=uisetcolor(get(handles.axes1,'colororder'),'Ñ¡Ôñ»­±ÊÑÕÉ«');
    set(handles.axes1,'colororder',col)
else
    pos=get(handles.axes1,'currentpoint');
    if (pos(1,1)>0&pos(1,1)<100)&&(pos(1,2)>0&pos(1,2)<100)
        flag=1;
        pos1=pos(1,[1,2]);
    end
end

function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
global flag pos1
pos = get(handles.axes1, 'currentpoint');
if flag && (pos(1, 1) > 0 & pos(1, 1) < 1) && (pos(1, 2) > 0 & pos(1, 2) < 1)
    line([pos1(1); pos(1, 1)],[pos1(2); pos(1, 2)], 'linewidth', 4)
    pos1 = pos(1, [1, 2]);
else
    flag = 0;
end

function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
global flag
flag = 0;



