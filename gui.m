function varargout = gui(varargin)
  clc;
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 24-Jun-2014 05:42:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_file.
function open_file_Callback(hObject, eventdata, handles)
% hObject    handle to open_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [filename,pathname] = uigetfile({'*.xls';'*.xlsx';'*.csv'},'Select Data');
  [data_mentah,l_data] = readFile(filename);
  handles.filename = filename;
  handles.data_mentah = data_mentah;
  handles.l_data = l_data;
  guidata(hObject,handles);  
  set(handles.nama_file,'String',filename);
  set(handles.number_of_record,'String',num2str(l_data(1,1)));


%---------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function nama_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nama_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%---------------------------------------------------------------------------


function k_Callback(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k as text
%        str2double(get(hObject,'String')) returns contents of k as a double

k = str2double(get(hObject,'String'));
handles.k = k;
guidata(hObject,handles);

%---------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------------------------------


function presentase_mv_Callback(hObject, eventdata, handles)
% hObject    handle to presentase_mv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of presentase_mv as text
%        str2double(get(hObject,'String')) returns contents of presentase_mv as a double

cek_pointmv = 0;

while (cek_pointmv~=1)
  presentase_mv = str2double(get(hObject,'String'));
  if or((presentase_mv>=1),(presentase_mv<=99))
    cek_pointmv=1;
  else
    errordlg('Nilai presentase mv harus diantara 1 - 99','warning');
  end
end

handles.presentase_mv = presentase_mv;
guidata(hObject,handles);

%---------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function presentase_mv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to presentase_mv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------------------------------


% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data_mentah = handles.data_mentah;
presentase_mv = handles.presentase_mv;
k = handles.k;

[data_mv,data,random_number_record,data_mv_asli] = mvMaker(data_mentah,k,presentase_mv);

[kluster] = kmeans(k,data);

[nomor_mv,l_datamv] = searchNan(data_mv);

handles.l_datamv = l_datamv;
set(handles.number_of_mv,'String',num2str(l_datamv(1,1)));

[data_full,data_mv_baru,covmat,myu,jumlah_iterasi]= k_estimate(data_mentah,data,random_number_record,data_mv,kluster,k,nomor_mv);

[y_guess,y_ans] = data_filter(data_mv,data_mv_baru,data_mv_asli);

[rmse] = rmse_estimate(y_guess,y_ans);

handles.jumlah_iterasi = jumlah_iterasi;
set(handles.number_of_iteration,'String',num2str(jumlah_iterasi));
handles.data_mv = data_mv;
handles.data_mv_baru = data_mv_baru;
guidata(hObject,handles);

set(handles.RMSE, 'String', num2str(rmse));

%---------------------------------------------------------------------------


% --- Executes on button press in view_data_mv.
function view_data_mv_Callback(hObject, eventdata, handles)
% hObject    handle to view_data_mv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uidatamv = figure(700);
data_mv = handles.data_mv;
table_data_mv = uitable(uidatamv);
set(table_data_mv,'Data',data_mv);
set(table_data_mv,'Position',[1 1 1000 600]);

%---------------------------------------------------------------------------


% --- Executes on button press in view_data_all.
function view_data_all_Callback(hObject, eventdata, handles)
% hObject    handle to view_data_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uidatamvbaru = figure(800);
data_mv_baru = handles.data_mv_baru;
table_data_full = uitable(uidatamvbaru);
set(table_data_full,'Data',data_mv_baru);
set(table_data_full,'Position',[1 1 1000 600]);

%---------------------------------------------------------------------------


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f = figure(900);
data_mentah = handles.data_mentah;
t = uitable(f);
set(t,'Data',data_mentah);
set(t,'Position',[1 1 1000 600]);

%---------------------------------------------------------------------------
