function varargout = MT1D(varargin)
% MT1D M-file for MT1D.fig
%      MT1D, by itself, creates a new MT1D or raises the existing
%      singleton*.
%
%      XXX = MT1D returns the handle to a new MT1D or the handle to
%      the existing singleton*.
%
%      MT1D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MT1D.M with the given input arguments.
%
%      MT1D('Property','Value',...) creates a new MT1D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MT1D_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MT1D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MT1D

% Last Modified by GUIDE v2.5 26-May-2013 15:38:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MT1D_OpeningFcn, ...
                   'gui_OutputFcn',  @MT1D_OutputFcn, ...
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


% --- Executes just before MT1D is made visible.
function MT1D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MT1D (see VARARGIN)

% Choose default command line output for MT1D
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MT1D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MT1D_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.rn,'value',0)
set(handles.r3,'value',0)
set(handles.h1,'enable','on','string','')
set(handles.h2,'enable','off','string','')
set(handles.p1,'enable','on','string','')
set(handles.p2,'enable','on','string','')
set(handles.p3,'enable','off','string','')
set(handles.h,'enable','off','string','')
set(handles.p,'enable','off','string','')







% --- Executes on button press in r3.
function r3_Callback(hObject, eventdata, handles)
% hObject    handle to r3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r3

set(handles.h,'enable','off')
set(handles.p,'enable','off')
set(handles.rn,'value',0)
set(handles.r22,'value',0)
set(handles.h1,'enable','on','string','')
set(handles.h2,'enable','on','string','')
set(handles.p1,'enable','on','string','')
set(handles.p2,'enable','on','string','')
set(handles.p3,'enable','on','string','')
set(handles.h,'enable','off','string','')
set(handles.p,'enable','off','string','')


% --- Executes on button press in rn.
function rn_Callback(hObject, eventdata, handles)
% hObject    handle to rn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rn
set(handles.r3,'value',0)
set(handles.r22,'value',0)
set(handles.h,'enable','on','string','请以数组形式输入[H1,H2...]','foregroundcolor',[1 0 0])
set(handles.p,'enable','on','string','请以数组形式输入[p1,p2...]','foregroundcolor',[ 1 0 0])
set(handles.h1,'enable','off','string','')
set(handles.h2,'enable','off','string','')
set(handles.p1,'enable','off','string','')
set(handles.p2,'enable','off','string','')
set(handles.p3,'enable','off','string','')





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2_Callback(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2 as text
%        str2double(get(hObject,'String')) returns contents of p2 as a double


% --- Executes during object creation, after setting all properties.
function p2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p3_Callback(hObject, eventdata, handles)
% hObject    handle to p3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p3 as text
%        str2double(get(hObject,'String')) returns contents of p3 as a double


% --- Executes during object creation, after setting all properties.
function p3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h1_Callback(hObject, eventdata, handles)
% hObject    handle to h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h1 as text
%        str2double(get(hObject,'String')) returns contents of h1 as a double


% --- Executes during object creation, after setting all properties.
function h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h2_Callback(hObject, eventdata, handles)
% hObject    handle to h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h2 as text
%        str2double(get(hObject,'String')) returns contents of h2 as a double


% --- Executes during object creation, after setting all properties.
function h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_Callback(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p as text
%        str2double(get(hObject,'String')) returns contents of p as a double


% --- Executes during object creation, after setting all properties.
function p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_Callback(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h as text
%        str2double(get(hObject,'String')) returns contents of h as a double


% --- Executes during object creation, after setting all properties.
function h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p1 as text
%        str2double(get(hObject,'String')) returns contents of p1 as a double


% --- Executes during object creation, after setting all properties.
function p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.r22,'value')
     A = get(handles.p1,'string');
     A = str2num(A);
     B =  get(handles.p2,'string');
     B = str2num(B);
     C =  get(handles.h1,'string');
     C = str2num(C);
     [X pa,phase] = mt_1d([A,B],[C]);
     axes(handles.axes1);
     semilogx(X,pa,'-r*')
     xlabel('\lambda/h_1')
     ylabel('{\rho_T}/{\rho_1}')
     legend('视电阻率')
     grid on
     axes(handles.axes2);
     semilogx(X,phase,'-bo')
     grid on
     xlabel('\lambda/h_1')
     ylabel('\phi')
     legend('相位')
elseif get(handles.r3,'value')
     A = get(handles.p1,'string');
     A = str2num(A);
     B =  get(handles.p2,'string');
     B = str2num(B);
     C = get(handles.p3,'string');
     C = str2num(C);
     D = get(handles.h1,'string');
     E = get(handles.h2,'string');
     D = str2num(D);
     E = str2num(E);
     [X,pa,phase] = mt_1d([A,B,C],[D,E]);
     axes(handles.axes1);
     semilogx(X,pa,'-r*')
     xlabel('\lambda/h_1')
     ylabel('{\rho_T}/{\rho_1}')
     legend('视电阻率')
     grid on
     axes(handles.axes2);
     semilogx(X,phase,'-bo')
     xlabel('\lambda/h_1')
     ylabel('\phi')
     legend('相位')
     grid on
else get(handles.rn,'value')
    A = get(handles.p,'string');
    B = get(handles.h,'string');
    A = str2num(A);
    B = str2num(B);
    [X,pa,phase] = mt_1d([A],[B]);
    axes(handles.axes1);
    semilogx(X,pa,'-r*')
    xlabel('\lambda/h_1')
    ylabel('{\rho_T}/{\rho_1}')
    legend('视电阻率')
    grid on
    axes(handles.axes2);
    semilogx(X,phase,'-bo')
    xlabel('\lambda/h_1')
    ylabel('\phi')
    legend('相位')
    grid on
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close



