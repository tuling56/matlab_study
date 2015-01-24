function varargout = a2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @a2_OpeningFcn, ...
                   'gui_OutputFcn',  @a2_OutputFcn, ...
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

function a2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
javaFrame = get(hObject, 'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon1.jpg'));
[num txt raw] = xlsread('user_information.xls');
if ~iscellstr(raw)
    for i = 1 : numel(raw)
        n(i) = isnumeric(raw{i});
    end
    raw{n} = num2str(raw{n});
end
handles.user = raw(2 : end, 1)';
handles.code = raw(2 : end, 2)';

guidata(hObject, handles);

function varargout = a2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function login_user_Callback(hObject, eventdata, handles)

function login_user_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject, 'BackgroundColor', 'white');
else
    set(hObject, 'BackgroundColor', get(0, 'defaultUicontrolBackgroundColor'));
end

function log_Callback(hObject, eventdata, handles)
user = get(handles.login_user, 'string');
code =get(gcf,'userdata');
users = handles.user;
codes = handles.code;
n = find(strcmp(users, {user}));
if length(n) && isequal(codes{n}, code)
    h = msgbox('登陆成功！');
    uiwait(h);
    delete(gcf);
    figure(1)
    set(1, 'name', '系统界面');
else
    errordlg('用户名或密码错误！', '错误提示');
    set(handles.login_code, 'string', '')
    set(hObject, 'userdata', '')
end

function log_KeyPressFcn(hObject, eventdata, handles)
if double(get(gcf, 'Currentcharacter')) == 13
    user = get(handles.login_user,'string');
    code = get(gcf, 'userdata');
    users = handles.user;
    codes = handles.code;
    n = find(strcmp(users,{user}));
    if length(n) && isequal(codes{n}, code)
        h = msgbox('登陆成功！');
        uiwait(h);
        delete(gcf);
        figure(1)
        set(1, 'name', '系统界面');
    else
        errordlg('用户名或密码错误！', '错误提示');
        set(handles.login_code, 'string', '')
        set(hObject, 'userdata', '')
    end
end

function figure1_KeyPressFcn(hObject, eventdata, handles)
c = get(hObject,'Currentcharacter');
if isstrprop(c,'graphic')
    set(hObject, 'userdata', [get(hObject,'userdata') c])
    set(handles.login_code, 'string', [get(handles.login_code,'string') '*'])
else
    log_KeyPressFcn(hObject, eventdata, handles);
    val = double(c);
    if ~isempty(val) && val == 8
        str = get(hObject, 'userdata');
        if ~isempty(str)
            str(end) = [];
        end
        set(hObject,'userdata',str)
        str2 = get(handles.login_code,'string');
        if ~isempty(str2)
            str2(end) = [];
        end
        set(handles.login_code,'string',str2)
    end
end

function login_user_KeyPressFcn(hObject, eventdata, handles)
log_KeyPressFcn(hObject, eventdata, handles);


