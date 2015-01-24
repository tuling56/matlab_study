function varargout = example6_3_2(varargin)
% EXAMPLE6_3_2 M-file for example6_3_2.fig
%      EXAMPLE6_3_2, by itself, creates a new EXAMPLE6_3_2 or raises the existing
%      singleton*.
%
%      H = EXAMPLE6_3_2 returns the handle to a new EXAMPLE6_3_2 or the handle to
%      the existing singleton*.
%
%      EXAMPLE6_3_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXAMPLE6_3_2.M with the given input arguments.
%
%      EXAMPLE6_3_2('Property','Value',...) creates a new EXAMPLE6_3_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before example6_3_2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to example6_3_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help example6_3_2

% Last Modified by GUIDE v2.5 20-Sep-2009 22:42:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @example6_3_2_OpeningFcn, ...
                   'gui_OutputFcn',  @example6_3_2_OutputFcn, ...
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

function example6_3_2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = example6_3_2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function listbox1_Callback(hObject, eventdata, handles)
if isequal(get(gcf, 'SelectionType'), 'open')
    str = get(hObject, 'string');
    n = get(hObject, 'value');
    strs = get(handles.listbox2, 'string');
    n2 = get(handles.listbox2, 'value');
    if isempty(strs) || (~any(strcmp(str(n), strs)))
        set(handles.listbox2, 'string', [get(handles.listbox2, 'string'); str(n)], 'value', max(n2, 1))
    end
end

function listbox2_Callback(hObject, eventdata, handles)
if isequal(get(gcf, 'SelectionType'), 'open')
    str = get(hObject, 'string');
    n = get(hObject, 'value');
    str(n) = '';
    set(hObject, 'string', str, 'value', max(1, n - 1))
end
