function varargout = serial_communication(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @serial_communication_OpeningFcn, ...
                   'gui_OutputFcn',  @serial_communication_OutputFcn, ...
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

function serial_communication_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon.jpg'));
guidata(hObject, handles);

function varargout = serial_communication_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function com_Callback(hObject, eventdata, handles)

function com_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rate_Callback(hObject, eventdata, handles)

function rate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function jiaoyan_Callback(hObject, eventdata, handles)

function jiaoyan_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function data_bits_Callback(hObject, eventdata, handles)

function data_bits_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stop_bits_Callback(hObject, eventdata, handles)

function stop_bits_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function start_serial_Callback(hObject, eventdata, handles)
global scom
if get(hObject,'value')
    com_n=sprintf('com%d',get(handles.com,'value'));
    rates=[300 600 1200 2400 4800 9600 19200 38400 43000 56000 57600 115200];
    baud_rate=rates(get(handles.rate,'value'));
    switch get(handles.jiaoyan,'value')
        case 1
            jiaoyan='none';
        case 2
            jiaoyan='odd';
        case 3
            jiaoyan='even';
    end
    data_bits=5+get(handles.data_bits,'value');
    stop_bits=get(handles.stop_bits,'value');
    scom=serial(com_n);
    set(scom,'BaudRate',baud_rate,'Parity',jiaoyan,'DataBits',...
        data_bits,'StopBits',stop_bits,'BytesAvailableFcnCount',100,...
        'BytesAvailableFcnMode','byte','BytesAvailableFcn',{@bytes,handles},...
        'TimerPeriod',0.01,'timerfcn',{@bytes,handles})
    try
        fopen(scom);
    catch
        msgbox('串口不可获得！');
        set(hObject,'value',0)
        return
    end
    set(handles.xianshi,'string','')
    set(handles.activex1,'value',1)
else
    t=timerfind;
    try
        stop(t);
        delete(t);
        clear t
    end
    scoms=instrfind;
    stopasync(scom);
    fclose(scoms);
    delete(scoms);
    set(handles.period_send,'value',0)
    set(handles.activex1,'value',0)
end

function bytes(obj,eventdata,handles)
n=get(obj,'BytesAvailable');
if n
    a=fread(obj,n,'uchar');
    if ~get(handles.stop_disp,'value')
        if ~get(handles.hex_disp,'value')
            c=char(a');
            set(handles.xianshi,'string',[get(handles.xianshi,'string') c])
            set(handles.rec,'string',num2str(str2num(get(handles.rec,'string'))+length(str2num(c))))
        else
            c=str2num(dec2hex(a'))';
            set(handles.xianshi,'string',[get(handles.xianshi,'string') num2str(c) '  '])
            set(handles.rec,'string',num2str(str2num(get(handles.rec,'string'))+length(c)))
        end
    end
end

function qingkong_Callback(hObject, eventdata, handles)
set(handles.xianshi,'string','')

function stop_disp_Callback(hObject, eventdata, handles)

function radiobutton1_Callback(hObject, eventdata, handles)

function radiobutton2_Callback(hObject, eventdata, handles)

function togglebutton4_Callback(hObject, eventdata, handles)

function hex_disp_Callback(hObject, eventdata, handles)

function manual_send_Callback(hObject, eventdata, handles)
global scom
if ~get(handles.hex_send,'value')
    str=get(handles.sends,'string');
    val=double(str);
    set(handles.trans,'string',num2str(str2num(get(handles.trans,'string'))+length(str2num(str))))
else
    val=hex2dec(get(handles.sends,'string'));
    set(handles.trans,'string',num2str(str2num(get(handles.trans,'string'))+length(val)))
end
if ~isempty(val)
    try
        str=get(scom,'TransferStatus');
    catch
        return
    end
    while 1
        if ~(strcmp(str, 'write')||strcmp(str,'read&write'))
            fwrite(scom,val,'uint8','async');
            
            break
        end
    end
end


function clear_send_Callback(hObject, eventdata, handles)
set(handles.sends,'string','')

function checkbox2_Callback(hObject, eventdata, handles)


function period_send_Callback(hObject, eventdata, handles)
if get(hObject,'value')
    t1=0.001*str2num(get(handles.period1,'string'));
    t=timer('BusyMode','queue','ExecutionMode','fixedrate',...
        'Period',t1,'TimerFcn',{@manual_send_Callback,handles});
    start(t);
else
    t=timerfind;
    stop(t);
    delete(t);
    clear t
end

function period1_Callback(hObject, eventdata, handles)

function period1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_count_Callback(hObject, eventdata, handles)
set([handles.rec,handles.trans],'string','0')

function copy_data_Callback(hObject, eventdata, handles)
if get(hObject,'value')
    set(handles.xianshi,'enable','on')
else
    set(handles.xianshi,'enable','inactive')
end




