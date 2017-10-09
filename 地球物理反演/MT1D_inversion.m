function varargout = MT1D_inversion(varargin)
% MT1D_INVERSION MATLAB code for MT1D_inversion.fig
%      MT1D_INVERSION, by itself, creates a new MT1D_INVERSION or raises the existing
%      singleton*.
%
%      H = MT1D_INVERSION returns the handle to a new MT1D_INVERSION or the handle to
%      the existing singleton*.
%
%      MT1D_INVERSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MT1D_INVERSION.M with the given input arguments.
%
%      MT1D_INVERSION('Property','Value',...) creates a new MT1D_INVERSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MT1D_inversion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MT1D_inversion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MT1D_inversion

% Last Modified by GUIDE v2.5 08-Oct-2016 15:17:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MT1D_inversion_OpeningFcn, ...
                   'gui_OutputFcn',  @MT1D_inversion_OutputFcn, ...
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


% --- Executes just before MT1D_inversion is made visible.
function MT1D_inversion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MT1D_inversion (see VARARGIN)

% Choose default command line output for MT1D_inversion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MT1D_inversion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MT1D_inversion_OutputFcn(hObject, eventdata, handles) 
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

%最速下降法测试数据
% [100,200,10,500,2000]
% [50,401,20,1000,4000]
% 25

%共轭梯度法测试数据
% [10,200,10,500,2000]
% [5,20,5,251,1000]
% 10



%获取GUI面板输入的参数
lambda_zy=str2num(get(handles.edit_zy,'String'));
lambda_start=str2num(get(handles.edit_start,'String'));
M=str2num(get(handles.edit_xz,'String'));
kmax=str2num(get(handles.edit_k,'String'));

if(isempty(get(handles.edit_bc,'String')))
    set(handles.edit_bc,'Enable','off');
    t=-1;
else
    t=str2num(get(handles.edit_bc,'String'));
    set(handles.edit_xz,'Enable','off');
end

%判断选中按钮
switch get(handles.uipanel3,'SelectedObject')
    case handles.rb_zsxj
     %   'picking radiobutton1'
        axes(handles.axes1);
        cla reset;
        axes(handles.axes2);
        cla reset;
        [ lambda,k ] = zsxhf_mt1dfy_GUI( handles,lambda_zy,lambda_start,M ,kmax,t);     
        lambdastr=strcat('反演所得模型为：',num2str(lambda));
        kstr=strcat('迭代次数为：',num2str(k),'次');      
        set(handles.text5,'String',lambdastr);
        set(handles.text4,'String',kstr);
      
    case handles.rb_getd
      %  'picking radiobutton2'
        axes(handles.axes1);
        cla reset;
        axes(handles.axes2);
        cla reset;      
      [ lambda,k ] = getdf_mt1dfy_GUI( handles,lambda_zy,lambda_start,M,kmax,t );  
      lambdastr=strcat('反演所得模型为：',num2str(lambda));
      kstr=strcat('迭代次数为：',num2str(k),'次');      
      set(handles.text5,'String',lambdastr);
      set(handles.text4,'String',kstr);
      
      case handles.rb_bostick
          %  'picking radiobutton3'
        axes(handles.axes1);
        cla reset;
        axes(handles.axes2);
        cla reset;
        bostick_GUI( handles,lambda_zy );
        set(handles.text5,'String','反演所得模型如左图所示');
        set(handles.text4,'String','未发生迭代')
      
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
        [lambda,k ] = gjndf_mt1dfy_GUI(  handles,lambda_zy,lambda_start,M ,kmax ,t);
          lambdastr=strcat('反演所得模型为：',num2str(lambda));
          kstr=strcat('迭代次数为：',num2str(k),'次');      
          set(handles.text5,'String',lambdastr);
          set(handles.text4,'String',kstr);
      end
      
end
set(handles.edit_bc,'Enable','on');
set(handles.edit_xz,'Enable','on');

 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(MT1D_inversion);

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


% --- Executes when selected object is changed in uipanel3.
function uipanel3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)



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
