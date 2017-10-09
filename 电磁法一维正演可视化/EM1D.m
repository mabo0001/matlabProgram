function varargout = EM1D(varargin)
% EM1D MATLAB code for EM1D.fig
%      EM1D, by itself, creates a new EM1D or raises the existing
%      singleton*.
%
%      H = EM1D returns the handle to a new EM1D or the handle to
%      the existing singleton*.
%
%      EM1D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EM1D.M with the given input arguments.
%
%      EM1D('Property','Value',...) creates a new EM1D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EM1D_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EM1D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EM1D

% Last Modified by GUIDE v2.5 30-Nov-2016 16:38:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EM1D_OpeningFcn, ...
                   'gui_OutputFcn',  @EM1D_OutputFcn, ...
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


% --- Executes just before EM1D is made visible.
function EM1D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EM1D (see VARARGIN)

% Choose default command line output for EM1D
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EM1D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EM1D_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function rho_input_Callback(hObject, eventdata, handles)
% hObject    handle to rho_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rho_input as text
%        str2double(get(hObject,'String')) returns contents of rho_input as a double


% --- Executes during object creation, after setting all properties.
function rho_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rho_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(gcbo,'string','[100,10,100]');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_input_Callback(hObject, eventdata, handles)
% hObject    handle to h_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_input as text
%        str2double(get(hObject,'String')) returns contents of h_input as a double


% --- Executes during object creation, after setting all properties.
function h_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(gcbo,'string','[500,300]');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_input_Callback(hObject, eventdata, handles)
% hObject    handle to x_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_input as text
%        str2double(get(hObject,'String')) returns contents of x_input as a double


% --- Executes during object creation, after setting all properties.
function x_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(gcbo,'string','0');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_input_Callback(hObject, eventdata, handles)
% hObject    handle to y_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_input as text
%        str2double(get(hObject,'String')) returns contents of y_input as a double


% --- Executes during object creation, after setting all properties.
function y_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(gcbo,'string','10000');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plot_pushbutton.
function plot_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x
global y
global f
global ex
global hy
global PE
rho_i=str2num(get(handles.rho_input,'string'));
h_i=str2num(get(handles.h_input,'string'));
x=str2num(get(handles.x_input,'string'));
y=str2num(get(handles.y_input,'string'));
I = 10;                             %�������
DL = 1e3;                           %AB������(��)
PE = I * DL / 2 / pi;
fmin=-8;
fmax=13;
fo=fmin:0.5:fmax;
f=2.^fo;                             %Ƶ��ϵ��
[ex,hy,rho,rho_r,phase,ex0,ex2]=CSAMT_forward(rho_i,h_i,x,y,f,PE);        %����CSAMT����
%%
a0=20;                  %����ģ�͵ĳ�ʼֵ���ֱ��Ǻ�Ⱥ͵�����.
al=1;                   %�����½�
au=1e6;                 %�����Ͻ�
%%%%%%%%%%%%%%CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC��С�������
for i=1:length(ex)
options=optimset('lsqnonlin');      %�����Ż�ѡ�������ѡ���������С���˷�
options.LevenbergMarquardt='on';    %�����Ż�ѡ�������ѡ��LevenbergMarquardt����Ϊȱʡѡ�Ҳ����ѡ��Guass-Newton
options.Display='off';              %������ʾ������iterΪ��ʾÿһ����offΪ����ʾ��finalΪ��ʾ���һ��
options.MaxFunEvals=100;          %�����Ż�ѡ��������������������������ȱʡΪ�Ա�����100����
options.MaxIter=100;                %�����Ż�ѡ�������������������ȱʡΪ400��
options.TolFun=1e-20;               %�����Ż�ѡ�����������ֵ�������ֹ��ȱʡΪ1e-6
options.TolX=1e-20;                 %�����Ż�ѡ��������Ա����������ֹ�ݲȱʡΪ1e-6
[a(i),resnorm,residual,exitflag,output]=lsqnonlin(@CSAMT_halfspace,a0,al,au,options,i);   %������С���˷���ϣ�exitflag����ֹ���������������������˳���С��0
end
%%%%%%%%%%%%%%CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC��С�������
[pa,phase_mt]=mt1d_m(rho_i,h_i);

axes(handles.rho_axes);
loglog(f,rho,'-k',f,a,'-r',f,pa,'-b','LineWidth',1.5);
xlabel('f/Hz','Fontsize',10,'Fontweight','bold');
ylabel('\rho_a/(\Omegam)','Fontsize',10,'Fontweight','bold');
%ylim([0,10000]);
set(gca,'XDir','reverse')
% legend('CSAMT','�����ŷ�','MT','Fontsize',12,'Fontweight','bold',0)
legend('CSAMT','�����ŷ�','MT',0)
% grid on

axes(handles.phase_axes);
loglog(f,a,'-r',f,pa,'-b','LineWidth',1.5);
xlabel('f/Hz','Fontsize',10,'Fontweight','bold');
ylabel('\rho_a/(\Omegam)','Fontsize',10,'Fontweight','bold');
%ylim([0,10000]);
set(gca,'XDir','reverse')
% legend('�����ŷ�','MT','Fontsize',12,'Fontweight','bold',0)
legend('�����ŷ�','MT',0)
% grid on

% axes(handles.phase_axes);
% semilogx(f,phase,'-k',f,phase_mt,'-b','LineWidth',1.5);
% xlabel('f/Hz','Fontsize',10,'Fontweight','bold');
% ylabel('phase/degree','Fontsize',10,'Fontweight','bold');
% %ylim([30,60]);
% set(gca,'XDir','reverse')
% legend('CSAMT','MT')
% grid on




% --- Executes on button press in close_pushbutton.
function close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function else_menu_Callback(hObject, eventdata, handles)
% hObject    handle to else_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MT1D_menu_Callback(hObject, eventdata, handles)
% hObject    handle to MT1D_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MT1D


% --------------------------------------------------------------------
function plot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_pushbutton_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function close_menu_Callback(hObject, eventdata, handles)
% hObject    handle to close_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes on key press with focus on x_input and none of its controls.
function x_input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to x_input (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on y_input and none of its controls.
function y_input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to y_input (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on h_input and none of its controls.
function h_input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to h_input (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function box_menu_Callback(hObject, eventdata, handles)
% hObject    handle to box_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(gcbo,'checked'),'on')
    set(gcbo,'checked','off');
else
    set(gcbo,'checked','on');
end
box;


% --------------------------------------------------------------------
function grid_menu_Callback(hObject, eventdata, handles)
% hObject    handle to grid_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(gcbo,'checked'),'on')
    set(gcbo,'checked','off');
else
    set(gcbo,'checked','on');
end
grid;


% --------------------------------------------------------------------
function Context_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Context_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function rho_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rho_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate rho_axes
