function varargout = example8_3_3(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @example8_3_3_OpeningFcn, ...
                   'gui_OutputFcn',  @example8_3_3_OutputFcn, ...
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

function example8_3_3_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

t = timer('tag', 'timer1', 'BusyMode', 'queue', 'ExecutionMode', ...
    'fixedrate', 'Period', 1, 'timerfcn', {@t_update, handles});
start(t);

guidata(hObject, handles);

function t_update(obj,eventdata,handles)
if ~isfield(handles, 'figure1')
    return
end
str1 = datestr(now, 'yyyy-mm-dd');
str2 = datestr(now, 'HH:MM:SS');
set(handles.activex1, 'AlphaNumeric', str2)
set(handles.activex2, 'AlphaNumeric', str1)

function varargout = example8_3_3_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function figure1_CloseRequestFcn(hObject, eventdata, handles)
t = timerfind;
stop(t);
delete(t)
clear t
delete(hObject);


