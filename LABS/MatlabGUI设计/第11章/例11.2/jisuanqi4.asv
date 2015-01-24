function varargout = jisuanqi4(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jisuanqi4_OpeningFcn, ...
                   'gui_OutputFcn',  @jisuanqi4_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before jisuanqi4 is made visible.
function jisuanqi4_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon1.jpg'));

global op
op=zeros(1,7);
handles.exp=' ';

guidata(hObject, handles);

function varargout = jisuanqi4_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in num7.
function num7_Callback(hObject, eventdata, handles)
global op
m='7';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num8_Callback(hObject, eventdata, handles)
global op
m='8';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20 %计算状态、其他进制、长度小于20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num9_Callback(hObject, eventdata, handles)
global op
m='9';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20 %计算状态、其他进制、长度小于20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num4_Callback(hObject, eventdata, handles)
global op
m='4';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num5_Callback(hObject, eventdata, handles)
global op
m='5';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num6_Callback(hObject, eventdata, handles)
global op
m='6';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num2_Callback(hObject, eventdata, handles)
global op
m='2';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num3_Callback(hObject, eventdata, handles)
global op
m='3';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num0_Callback(hObject, eventdata, handles)
global op
m='0';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num1_Callback(hObject, eventdata, handles)
global op
m='1';
n=[m '.'];
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    if (~a(1))&&(~a(2))
        set(handles.xianshi,'string',n)
    else
        set(handles.xianshi,'string',m)
    end
elseif (~a(1))&&(~a(2))   %计算状态%十进制
    if length(str)<20   %数的长度小于20
        if a(6)   %小数
            set(handles.xianshi,'string',[str m])
        else   %整数
            set(handles.xianshi,'string',[str(1:end-1) n])
        end
    end
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3 5])=[0 1];
op=a;

function num_fuhao_Callback(hObject, eventdata, handles)
global op
str=get(handles.xianshi,'string');
if strcmp(str(1),'-')
    set(handles.xianshi,'string',str(2:end))
elseif (~op(1))&&(~op(2))
        set(handles.xianshi,'string',['-' str])
end
op(3)=0;

function dot_Callback(hObject, eventdata, handles)
global op
if isequal(op([1 2 6]),[0 0 0]) %十进制整数
    op(6)=1;
end
op(5)=1;

function numb_Callback(hObject, eventdata, handles)
global op
m='B';
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    set(handles.xianshi,'string',m)
    a(5)=1;
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3,6])=[0 0];
op=a;

function add_Callback(hObject, eventdata, handles)
global op
a=op;
b=get(handles.xianshi,'string');
num=str2val(b,a);
exp=handles.exp;
if a(3)
    exp(end)='+';
else
    exp=[exp num2str(num) '+'];
end
a([3 5 7])=[1 0 0];
op=a;
handles.exp=exp;
guidata(hObject,handles);

function equal_Callback(hObject, eventdata, handles)
global op
a=op;
b=get(handles.xianshi,'string');
num=str2val(b,a);
exp=handles.exp;
if ~a(7)
    if a(3)
        exp(end)='';
    else
        exp=[exp sprintf('(%g)',num)];
    end
else
    exp=[exp sprintf('%g)',floor(num))];
    a(7)=0;
end
try
    res=eval(exp);
catch
    if isequal(a([1 2]),[0 0])
        set(handles.xianshi,'string','0.')
    else
        set(handles.xianshi,'string','0')
    end
    a(5)=0;
    handles.exp=' ';
    guidata(hObject,handles)
    return
end
c=val2str(res,a);
a(5)=0;
op=a;
handles.exp=' ';
set(handles.xianshi,'string',c)
guidata(hObject,handles)    

function num=str2val(b,a)
if isequal(a([1 2]),[0 1])
    num=bin2dec(b);
elseif isequal(a([1 2]),[1 1])
    num=hex2dec(b);
elseif isequal(a([1 2]),[1 0])
    num=oct2dec(eval(b));
else
    num=str2num(b);
end

function c=val2str(b,a)
if isequal(a([1 2]),[0 0])
    c=sprintf('%g',b);
    if isempty(find(c=='.'))
        c=[c '.'];
    end
elseif isequal(a([1 2]),[0 1])
    c=dec2bin(abs(b));
elseif isequal(a([1 2]),[1 1])
    c=dec2hex(abs(b));
else
    i=1;
    while res>7
        d(i)=rem(abs(b),8);
        i=i+1;
        res=floor(abs(b)/8);
    end
    d(i)=res;
    c=sprintf('%d',fliplr(d));
end



function xy_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
b=get(handles.xianshi,'string');
num=str2val(b,a);
exp=handles.exp;
if ~a(4)
    if a(3)
        exp(end)='^';
    else
        a(3)=1;
        exp=[exp num2str(num) '^'];
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    if a(3)
        exp(end)='^(-1)^';
    else
        a(3)=1;;
        exp=[exp num2str(num) '^(-1)^'];
    end
end
a(5)=0;
op=a;
handles.exp=exp;
guidata(hObject,handles) 

function minus_Callback(hObject, eventdata, handles)
global op
a=op;
b=get(handles.xianshi,'string');
num=str2val(b,a);
exp=handles.exp;
if a(3)
    exp(end)='-';
else
    a(3)=1;
    exp=[exp num2str(num) '-'];
end
a([3 5 7])=[1 0 0];
op=a;
handles.exp=exp;
guidata(hObject,handles);

function multiply_Callback(hObject, eventdata, handles)
global op
a=op;
b=get(handles.xianshi,'string');
num=str2val(b,a);
exp=handles.exp;
if a(3)
    exp(end)='*';
else
    exp=[exp num2str(num) '*'];
end
a([3 5 7])=[1 0 0];
op=a;
handles.exp=exp;
guidata(hObject,handles);

function divide_Callback(hObject, eventdata, handles)
global op
a=op;
b=get(handles.xianshi,'string');
num=str2val(b,a);
exp=handles.exp;
if a(3)
    exp(end)='/';
else
    exp=[exp num2str(num) '/'];
end
a([3 5 7])=[1 0 0];
op=a;
handles.exp=exp;
guidata(hObject,handles);


function numa_Callback(hObject, eventdata, handles)
global op
m='A';
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    set(handles.xianshi,'string',m)
    a(5)=1;
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3,6])=[0 0];
op=a;

function numc_Callback(hObject, eventdata, handles)
global op
m='C';
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    set(handles.xianshi,'string',m)
    a(5)=1;
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3,6])=[0 0];
op=a;

function numd_Callback(hObject, eventdata, handles)
global op
m='D';
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    set(handles.xianshi,'string',m)
    a(5)=1;
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3,6])=[0 0];
op=a;

function nume_Callback(hObject, eventdata, handles)
global op
m='E';
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    set(handles.xianshi,'string',m)
    a(5)=1;
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3,6])=[0 0];
op=a;

function numf_Callback(hObject, eventdata, handles)
global op
m='F';
a=op;
str=get(handles.xianshi,'string');
if ~a(5)%初始状态
    set(handles.xianshi,'string',m)
    a(5)=1;
elseif length(str)<20
    set(handles.xianshi,'string',[str m])
end
a([3,6])=[0 0];
op=a;

function pi_val_Callback(hObject, eventdata, handles)
set(handles.xianshi,'string','3.14159265')

% --- Executes on button press in lgx.
function lgx_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('log10(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('10^(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function lnx_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('log(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('exp(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function log2x_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('log2(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('2^(%s)(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function onc_Callback(hObject, eventdata, handles)
global op 
set(handles.secndf,'visible','off','string','2ndF')
set(handles.radiobutton1,'enable','on')
set(handles.radiobutton2,'enable','on')
set(handles.radiobutton3,'enable','on')
if isequal(op([1 2]),[0 0])
    set(handles.xianshi,'string','0.')
else
    set(handles.xianshi,'string','0')
end
op([3:7])=0;
set(handles.secndf,'visible','off','string','2ndF')
handles.exp=' ';
handles.datas=[];
guidata(hObject,handles);


% --- Executes on button press in secf.
function secf_Callback(hObject, eventdata, handles)
global op
op(4)=~op(4);
if op(4)
    set(handles.secndf,'visible','on','string','2ndF')
    set(handles.jinzhi,'selectedobject',handles.radiobutton4)
    h_all=[handles.num0 handles.num1 handles.num2 handles.num3 handles.num4 ...
            handles.num5 handles.num6 handles.num7 handles.num8 handles.num9 ...
            handles.e_val handles.pi_val handles.dot];
        set(h_all,'enable','on')
        a_f=[handles.numa handles.numb handles.numc handles.numd handles.nume handles.numf];
        set(a_f,'enable','off')
    b=get(handles.xianshi,'string');
    if isequal(op([1 2]),[0 1])
        b=sprintf('%g.',bin2dec(b));
    elseif isequal(op([1 2]),[1 1])
        b=sprintf('%g.',hex2dec(b));
    elseif isequal(op([1 2]),[1 0])
        b=sprintf('%g.',oct2dec(eval(b)));
    end
    set(handles.xianshi,'string',b)
    set(handles.radiobutton1,'enable','off')
    set(handles.radiobutton2,'enable','off')
    set(handles.radiobutton3,'enable','off')
else
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
end

function sqrtx_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('sqrt(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('(%s)^(1/3)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function tanx_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('tan(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('atan(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function sinx_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('sin(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('asin(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function cosx_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('cos(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('acos(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function x2_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
str=get(handles.xianshi,'string');
if ~a(4)
    try
        format short
        res=eval(sprintf('(%s)^2',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('1/(%s)',str));
        set(handles.xianshi,'string',num2str(res,'%7.3f'))
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function fac_Callback(hObject, eventdata, handles)
global op
a=op;
if ~isequal(a([1 2]),[0 0])
    return
end
a([5 6])=[0 1];
handles.exp=' ';
num=str2num(get(handles.xianshi,'string'));
if ~a(4)
    try
        format short
        res=eval(sprintf('factorial(%f)',floor(num)));
        set(handles.xianshi,'string',[num2str(res,'%d') '.'])
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
else
    a(4)=0;
    set(handles.secndf,'visible','off')
    set(handles.radiobutton1,'enable','on')
    set(handles.radiobutton2,'enable','on')
    set(handles.radiobutton3,'enable','on')
    try
        format short
        res=eval(sprintf('sum([1:%f])',floor(num)));
        set(handles.xianshi,'string',[num2str(res,'%d') '.'])
    catch
        a(5)=0;
        set(handles.xianshi,'string','运算错误！')
    end
end
op=a;
guidata(hObject,handles) 

function backspace_Callback(hObject, eventdata, handles)
global op
a=op;
str=get(handles.xianshi,'string');
if ~a(5)
    if isequal(a([1 2]),[0 0])
        set(handles.xianshi,'string','0.')
    else
        set(handles.xianshi,'string','0')
    end
else
    if isequal(a([1 2]),[0 0])
        if strcmp(str(end-1),'.')
            a(6)=1;%小数
            set(handles.xianshi,'string',str(1:end-1))
        elseif strcmp(str(end),'.')
            if a(6)
                a(6)=0;
            else
                if strcmp(str(1),'-')
                    n=3;
                else
                    n=2;
                end
                if length(str)>n
                    str(end-1)='';
                    set(handles.xianshi,'string',str)
                else
                    set(handles.xianshi,'string','0.')
                    a(5)=0;
                end
           end
        else
            set(handles.xianshi,'string',str(1:end-1))
        end
    else
        if length(str)>1
            set(handles.xianshi,'string',str(1:end-1))
        else
            set(handles.xianshi,'string','0')
            a(5)=0;
        end
    end
end
op=a;

function pushbutton38_Callback(hObject, eventdata, handles)

function mean1_Callback(hObject, eventdata, handles)
global op
if (~isfield(handles,'datas'))||(isempty(handles.datas))
    return
end
str=get(handles.xianshi,'string');
datas=handles.datas;
if op(5)
    datas=[datas str2num(str)];
    op(5)=0;
end
if ~op(4)
    val=mean(datas);
else
    val=sum(datas.^2);
    op(4)=0;
end
set(handles.xianshi,'string',num2str(val,'%8.2f'))
set(handles.secndf,'visible','off','string','2ndF')
set(handles.radiobutton1,'enable','on')
set(handles.radiobutton2,'enable','on')
set(handles.radiobutton3,'enable','on')
handles.datas=[];
guidata(hObject,handles);

function std1_Callback(hObject, eventdata, handles)
global op
if (~isfield(handles,'datas'))||(isempty(handles.datas))
    return
end
str=get(handles.xianshi,'string');
datas=handles.datas;
if op(5)
    datas=[datas str2num(str)];
    op(5)=0;
end
if ~op(4)
    val=std(datas)^2;
else
    val=std(datas);
    op(4)=0;
end
set(handles.xianshi,'string',num2str(val,'%8.2f'))
set(handles.secndf,'visible','off','string','2ndF')
set(handles.radiobutton1,'enable','on')
set(handles.radiobutton2,'enable','on')
set(handles.radiobutton3,'enable','on')
handles.datas=[];
guidata(hObject,handles);

function dc_Callback(hObject, eventdata, handles)
global op
set(handles.secndf,'visible','on','string','M-0')
set(handles.radiobutton1,'enable','off')
set(handles.radiobutton2,'enable','off')
set(handles.radiobutton3,'enable','off')
set(handles.jinzhi,'selectedobject',handles.radiobutton4)
h_all=[handles.num0 handles.num1 handles.num2 handles.num3 handles.num4 ...
    handles.num5 handles.num6 handles.num7 handles.num8 handles.num9 ...
    handles.e_val handles.pi_val handles.dot];
set(h_all,'enable','on')
a_f=[handles.numa handles.numb handles.numc handles.numd handles.nume handles.numf];
set(a_f,'enable','off')
set(handles.xianshi,'string','请输入一组数值：');
op=zeros(1,7);
handles.exp=' ';
handles.datas=[];
guidata(hObject,handles);

function m_add_Callback(hObject, eventdata, handles)
global op
str=get(handles.xianshi,'string');
if op(5)
    handles.datas=[handles.datas str2num(str)];
    set(handles.secndf,'string',['M-' num2str(length(handles.datas))])
    guidata(hObject,handles);
    op(5)=0;
end

function and1_Callback(hObject, eventdata, handles)
global op
op([5 7])=[0 1];
b=get(handles.xianshi,'string');
num=str2val(b,op);
handles.exp=sprintf('bitand(%g,',floor(num));
guidata(hObject,handles);

function or1_Callback(hObject, eventdata, handles)
global op
op([5 7])=[0 1];
b=get(handles.xianshi,'string');
num=str2val(b,op);
handles.exp=sprintf('bitor(%g,',floor(num));
guidata(hObject,handles);


function xor1_Callback(hObject, eventdata, handles)
global op
op([5 7])=[0 1];
b=get(handles.xianshi,'string');
num=str2val(b,op);
handles.exp=sprintf('bitxor(%g,',floor(num));
guidata(hObject,handles);

function not1_Callback(hObject, eventdata, handles)
global op
op([5 7])=[0 1];
b=get(handles.xianshi,'string');
num=str2val(b,op);
handles.exp=sprintf('bitcmp(%g,',floor(num));
guidata(hObject,handles);

function mod1_Callback(hObject, eventdata, handles)
global op
op([5 7])=[0 1];
b=get(handles.xianshi,'string');
num=str2val(b,op);
handles.exp=sprintf('mod(%g,',floor(num));
guidata(hObject,handles);

function e_val_Callback(hObject, eventdata, handles)
set(handles.xianshi,'string','2.71828182')


% function zijie_SelectionChangeFcn(hObject, eventdata, handles)
% global op2
% sel=get(handles.zijie,'selectedobject');
% switch get(sel,'tag')
%     case 'byte'
%         op2=bitset(op2,14,0);
%         op2=bitset(op2,13,0);
%     case 'single'
%         op2=bitset(op2,14,0);
%         op2=bitset(op2,13,1);
%     case 'doub'
%         op2=bitset(op2,14,1);
%         op2=bitset(op2,13,0);
% end

function jinzhi_SelectionChangeFcn(hObject, eventdata, handles)
global op
a=op;
b=get(handles.xianshi,'string');
switch get(hObject,'tag')
    case 'radiobutton4'
        h_all=[handles.num0 handles.num1 handles.num2 handles.num3 handles.num4 ...
            handles.num5 handles.num6 handles.num7 handles.num8 handles.num9 ...
            handles.e_val handles.pi_val handles.dot handles.num_fuhao];
        set(h_all,'enable','on')
        a_f=[handles.numa handles.numb handles.numc handles.numd handles.nume handles.numf];
        set(a_f,'enable','off')
        if ~a(5)
            set(handles.xianshi,'string','0.')
            a(3)=0;
        else
            if isequal(a([1 2]),[0 1])%二进制->十进制
                num=bin2dec(b);
                c=[num2str(num) '.'];
            elseif isequal(a([1 2]),[1 0])%八进制->十进制
                num=oct2dec(eval(b));
                c=[num2str(num) '.'];
            elseif isequal(a([1 2]),[1 1])%十六进制->十进制
                num=hex2dec(b);
                c=[num2str(num) '.'];
            end
            set(handles.xianshi,'string',c)
        end
        a([1 2 6])=[0 0 0];
    case 'radiobutton3'%转化为十六进制
        h_all=[handles.num0 handles.num1 handles.num2 handles.num3 ...
            handles.num4 handles.num5 handles.num6 handles.num7 ...
            handles.num8 handles.num9];
        a_f=[handles.numa handles.numb handles.numc handles.numd ...
            handles.nume handles.numf];
        set([h_all a_f],'enable','on')
        a_off=[handles.e_val handles.pi_val handles.dot handles.num_fuhao];
        set(a_off,'enable','off')
        if ~a(5)
            set(handles.xianshi,'string','0')
            a(3)=0;
        else
            if isequal(a([1 2]),[0 0])%十进制转化为十六进制
                if strcmp(b(1),'-')
                    c=dec2hex(floor(str2num(b(2:end))));
                else
                    c=dec2hex(floor(str2num(b)));
                end
            elseif isequal(a([1 2]),[1 0])%八进制->十六进制
                num=oct2dec(eval(b));
                c=dec2hex(num);
            elseif isequal(a([1 2]),[0 1])%二进制->十六进制
                num=bin2dec(b);
                c=dec2hex(num);
            end
            set(handles.xianshi,'string',c)
        end
        a([1 2 6])=[1 1 0];
    case 'radiobutton2'%转化为八进制
        h_all=[handles.num0 handles.num1 handles.num2 handles.num3 ...
            handles.num4 handles.num5 handles.num6 handles.num7];
        set(h_all,'enable','on')
        a_f=[handles.num8 handles.num9 handles.numa handles.numb ...
            handles.numc handles.numd handles.nume handles.numf ...
            handles.e_val handles.pi_val handles.dot handles.num_fuhao];
        set(a_f,'enable','off')
        if ~a(5)
            set(handles.xianshi,'string','0')
            a(3)=0;
        else
            if isequal(a([1 2]),[0 0])%十进制转化为八进制
                if strcmp(b(1),'-')
                    num=floor(eval(b(2:end)));
                else
                    num=floor(eval(b));
                end
                i=1;
                while num>7
                    d(i)=rem(num,8);
                    i=i+1;
                    num=floor(num/8);
                end
                d(i)=num;
                c=sprintf('%d',fliplr(d));
            elseif isequal(a([1 2]),[0 1])%二进制转化为八进制
                n=length(b);
                if rem(n,3)==1
                    b=['00' b];
                elseif rem(n,3)==2
                    b=['0' b];
                end
                str=reshape(b,3,[])';
                num=bin2dec(str);
                c=sprintf('%d',num);
            elseif isequal(a([1 2]),[1 1])%十六进制转化为八进制
                num=hex2dec(b);
                i=1;
                while num>7
                    d(i)=rem(num,8);
                    i=i+1;
                    num=floor(num/8);
                end
                d(i)=num;
                c=sprintf('%d',fliplr(d));%c=char(48+fliplr(d));
            end
            set(handles.xianshi,'string',c)
        end
        a([1 2 6])=[1 0 0];
    case 'radiobutton1'%转化为二进制
        h_all=[handles.num0 handles.num1];
        set(h_all,'enable','on')
        a_f=[handles.num2 handles.num3 handles.num4 handles.num5 handles.num6 handles.num7 ...
            handles.num8 handles.num9 handles.numa handles.numb handles.numc handles.numd ...
            handles.nume handles.numf handles.e_val handles.pi_val handles.dot handles.num_fuhao];
        set(a_f,'enable','off')
        if ~a(5)
            set(handles.xianshi,'string','0')
            a(3)=0;
        else
            if isequal(a([1 2]),[0 0])%十进制转化为二进制
                if strcmp(b(1),'-')
                    c=dec2bin(eval(b(2:end)));
                else
                    c=dec2bin(eval(b));
                end
            elseif isequal(a([1 2]),[1 0])%八进制转化为二进制
                c=dec2bin(oct2dec(eval(b)));
            elseif isequal(a([1 2]),[1 1])%十六进制转化为二进制
                c=dec2bin(hex2dec(b));
            end
            set(handles.xianshi,'string',c)
        end
        a([1 2 6])=[0 1 0];
end
op=a;
