function varargout = example6_1_11(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @example6_1_11_OpeningFcn, ...
                   'gui_OutputFcn',  @example6_1_11_OutputFcn, ...
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

function example6_1_11_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = example6_1_11_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function load_pic_Callback(hObject, eventdata, handles)
[fname, pname, index] = uigetfile({'*.jpg'; '*.bmp'}, 'Ñ¡ÔñÍ¼Æ¬');
if index
    str = [pname fname];
    c = imread(str);
    axes(handles.axes1)
    image(c);
    axis off
end



