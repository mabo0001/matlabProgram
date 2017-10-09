function varargout = DC1DInversion(varargin)
% DC1DINVERSION MATLAB code for DC1DInversion.fig
%      DC1DINVERSION, by itself, creates a new DC1DINVERSION or raises the existing
%      singleton*.
%
%      H = DC1DINVERSION returns the handle to a new DC1DINVERSION or the handle to
%      the existing singleton*.
%
%      DC1DINVERSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DC1DINVERSION.M with the given input arguments.
%
%      DC1DINVERSION('Property','Value',...) creates a new DC1DINVERSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DC1DInversion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DC1DInversion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DC1DInversion

% Last Modified by GUIDE v2.5 15-Dec-2016 20:44:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DC1DInversion_OpeningFcn, ...
                   'gui_OutputFcn',  @DC1DInversion_OutputFcn, ...
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


% --- Executes just before DC1DInversion is made visible.
function DC1DInversion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DC1DInversion (see VARARGIN)

% Choose default command line output for DC1DInversion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAT makes DC1DInversion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DC1DInversion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%开始拟线性反演
lambda_zy=str2num(get(handles.edit_zy,'String'));
lambda_start=str2num(get(handles.edit_start,'String'));
M=str2num(get(handles.edit_xz,'String'));
kmax=str2num(get(handles.edit_k,'String'));
zaosheng=str2num(get(handles.edit_zs,'String'));

if(isempty(get(handles.edit_bc,'String')))
    set(handles.edit_bc,'Enable','off');
    t=-1;
else
    t=str2num(get(handles.edit_bc,'String'));
    set(handles.edit_xz,'Enable','off');
end


%正演得到观测值
LayerNumber=(size(lambda_zy,2)+1)/2;
rhos=DC1D_Forward(lambda_zy(1:LayerNumber),lambda_zy(LayerNumber+1:end));
rhos_noise=rhos+zaosheng.*(-1+2.*rand(size(rhos))).*rhos;

%判断选中按钮
switch get(handles.uipanel6,'SelectedObject')
    case handles.rb_zsxj
     %   'picking radiobutton1'
        axes(handles.axes1);
        cla reset;
        axes(handles.axes2);
        cla reset;
        axes(handles.axes3);
        cla reset;
        
        [lambda,k] = zsxjf_DC1DInverse(handles,rhos_noise,rhos,lambda_start,M,kmax ,t,LayerNumber );
        axes(handles.axes3);
        % 绘制模型对比阶梯图
        hhh=cumsum(lambda_zy(LayerNumber+1:end));
        h=[1,hhh,2*(hhh(end))];
        rho=[lambda_zy(1:LayerNumber),lambda_zy(LayerNumber)];
        stairs(h,rho,'b-*','LineWidth',1.5);
        hold on
        lambda2=cumsum(lambda(LayerNumber+1:end));
        h1=[1,lambda2,2*(lambda2(end))];
        rho1=[lambda(1:LayerNumber),lambda(LayerNumber)];
        stairs(h1,rho1,'r--o','LineWidth',1.5);
        set(gca, 'XLim',[0 2*(lambda2(end))]);set(gca, 'YLim',[0 max([rho1,rho])+5]);
        xlabel('深度Depth/m')
        ylabel('视电阻率\rho_a/(\Omega·m)')
        title('最速下降法反演模型与实际模型对比');
        legend('理论模型','反演模型',0);

    case handles.rb_getd
      %  'picking radiobutton2'
        axes(handles.axes1);
        cla reset;
        axes(handles.axes2);
        cla reset;      
        axes(handles.axes3);
        cla reset;

      [ lambda,k ] = getdf_DC1DInverse( handles,rhos_noise,rhos,lambda_start,M,kmax ,t,LayerNumber );
        axes(handles.axes3);
        % 绘制模型对比阶梯图
        hhh=cumsum(lambda_zy(LayerNumber+1:end));
        h=[1,hhh,2*(hhh(end))];
        rho=[lambda_zy(1:LayerNumber),lambda_zy(LayerNumber)];
        stairs(h,rho,'b-*','LineWidth',1.5);
        hold on
        lambda2=cumsum(lambda(LayerNumber+1:end));
        h1=[1,lambda2,2*(lambda2(end))];
        rho1=[lambda(1:LayerNumber),lambda(LayerNumber)];
        stairs(h1,rho1,'r--o','LineWidth',1.5);
        set(gca, 'XLim',[0 2*(lambda2(end))]);set(gca, 'YLim',[0 max([rho1,rho])+5]);
        xlabel('深度Depth/m')
        ylabel('视电阻率\rho_a/(\Omega·m)')
        title('共轭梯度法反演模型与实际模型对比');
        legend('理论模型','反演模型',0);
      
      
       case handles.rb_gjnd
          %  'picking radiobutton4'
          if(isempty(get(handles.edit_xz,'String')))
             h=errordlg('为保证Hessian矩阵正定,请输入修正系数','警告'); 
             ht=findall(get(h,'children'),'type','text');

          else          
            axes(handles.axes1);
            cla reset;
            axes(handles.axes2);
            cla reset;
            axes(handles.axes3);
            cla reset;

            [  lambda,k ] = gjndf_DC1DInverse(handles,rhos_noise,rhos,lambda_start,M,kmax ,t,LayerNumber );
            axes(handles.axes3);
            % 绘制模型对比阶梯图
            hhh=cumsum(lambda_zy(LayerNumber+1:end));
            h=[1,hhh,2*(hhh(end))];
            rho=[lambda_zy(1:LayerNumber),lambda_zy(LayerNumber)];
            stairs(h,rho,'b-*','LineWidth',1.5);
            hold on
            lambda2=cumsum(lambda(LayerNumber+1:end));
            h1=[1,lambda2,2*(lambda2(end))];
            rho1=[lambda(1:LayerNumber),lambda(LayerNumber)];
            stairs(h1,rho1,'r--o','LineWidth',1.5);
            set(gca, 'XLim',[0 2*(lambda2(end))]);set(gca, 'YLim',[0 max([rho1,rho])+5]);
            xlabel('深度Depth/m')
            ylabel('视电阻率\rho_a/(\Omega·m)')
            title('改进牛顿法反演模型与实际模型对比');
            legend('理论模型','反演模型',0);
          end
      
end
set(handles.edit_bc,'Enable','on');
set(handles.edit_xz,'Enable','on');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
            axes(handles.axes1);
            cla reset;
            axes(handles.axes2);
            cla reset;
            axes(handles.axes3);
            cla reset;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%遗传算法反演
axes(handles.axes1);
cla reset;
axes(handles.axes2);
cla reset;
axes(handles.axes3);
cla reset;

lambda_GAzy=str2num(get(handles.edit_GAzy,'String'));
noise=str2num(get(handles.edit_noise,'String'));
length=str2num(get(handles.edit_length,'String'));
min=str2num(get(handles.edit_min,'String'));
max=str2num(get(handles.edit_max,'String'));
factor=str2num(get(handles.edit_factor,'String'));
jiaocha=str2num(get(handles.edit_jiaocha,'String'));
bianyi=str2num(get(handles.edit_bianyi,'String'));
qtSize=str2num(get(handles.edit_qtSize,'String'));
kmax=str2num(get(handles.edit_kmax,'String'));

LayerNumber=(size(lambda_GAzy,2)+1)/2;

GA_Inversion( handles,lambda_GAzy,noise,length,min,max,factor,jiaocha,bianyi,qtSize,kmax,LayerNumber )


function edit_GAzy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_GAzy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_GAzy as text
%        str2double(get(hObject,'String')) returns contents of edit_GAzy as a double


% --- Executes during object creation, after setting all properties.
function edit_GAzy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_GAzy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_noise_Callback(hObject, eventdata, handles)
% hObject    handle to edit_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_noise as text
%        str2double(get(hObject,'String')) returns contents of edit_noise as a double


% --- Executes during object creation, after setting all properties.
function edit_noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_min as text
%        str2double(get(hObject,'String')) returns contents of edit_min as a double


% --- Executes during object creation, after setting all properties.
function edit_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max as text
%        str2double(get(hObject,'String')) returns contents of edit_max as a double


% --- Executes during object creation, after setting all properties.
function edit_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_jiaocha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jiaocha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jiaocha as text
%        str2double(get(hObject,'String')) returns contents of edit_jiaocha as a double


% --- Executes during object creation, after setting all properties.
function edit_jiaocha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jiaocha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bianyi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bianyi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bianyi as text
%        str2double(get(hObject,'String')) returns contents of edit_bianyi as a double


% --- Executes during object creation, after setting all properties.
function edit_bianyi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bianyi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_qtSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_qtSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_qtSize as text
%        str2double(get(hObject,'String')) returns contents of edit_qtSize as a double


% --- Executes during object creation, after setting all properties.
function edit_qtSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_qtSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_zy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_zy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_zy as text
%        str2double(get(hObject,'String')) returns contents of edit_zy as a double


% --- Executes during object creation, after setting all properties.
function edit_zy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_zy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start as text
%        str2double(get(hObject,'String')) returns contents of edit_start as a double


% --- Executes during object creation, after setting all properties.
function edit_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_k_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k as text
%        str2double(get(hObject,'String')) returns contents of edit_k as a double


% --- Executes during object creation, after setting all properties.
function edit_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xz as text
%        str2double(get(hObject,'String')) returns contents of edit_xz as a double


% --- Executes during object creation, after setting all properties.
function edit_xz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bc as text
%        str2double(get(hObject,'String')) returns contents of edit_bc as a double


% --- Executes during object creation, after setting all properties.
function edit_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kmax as text
%        str2double(get(hObject,'String')) returns contents of edit_kmax as a double


% --- Executes during object creation, after setting all properties.
function edit_kmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_zs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_zs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_zs as text
%        str2double(get(hObject,'String')) returns contents of edit_zs as a double


% --- Executes during object creation, after setting all properties.
function edit_zs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_zs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
