function varargout = example6_3_1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @example6_3_1_OpeningFcn, ...
                   'gui_OutputFcn',  @example6_3_1_OutputFcn, ...
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

function example6_3_1_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = example6_3_1_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function listbox1_Callback(hObject, eventdata, handles)
n = get(hObject, 'value');
if n<4
    set(hObject, 'uicontextmenu', '')
    if isequal(get(gcf, 'SelectionType'), 'open')
        set(hObject, 'uicontextmenu', '')
        str = get(hObject, 'string');
        set(handles.text1, 'string', str{n})
    end
else
    set(hObject, 'uicontextmenu', handles.caidan1)
end

function caidan1_Callback(hObject, eventdata, handles)

function d_1_Callback(hObject, eventdata, handles)
set(handles.text1, 'string', 'd1')

function d_2_Callback(hObject, eventdata, handles)
set(handles.text1, 'string', 'd2')

function d_3_Callback(hObject, eventdata, handles)
set(handles.text1, 'string', 'd3')