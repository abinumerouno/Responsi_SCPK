function varargout = Responsi_scpkWP(varargin)
% RESPONSI_SCPKWP MATLAB code for Responsi_scpkWP.fig
%      RESPONSI_SCPKWP, by itself, creates a new RESPONSI_SCPKWP or raises the existing
%      singleton*.
%
%      H = RESPONSI_SCPKWP returns the handle to a new RESPONSI_SCPKWP or the handle to
%      the existing singleton*.
%
%      RESPONSI_SCPKWP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SCPKWP.M with the given input arguments.
%
%      RESPONSI_SCPKWP('Property','Value',...) creates a new RESPONSI_SCPKWP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi_scpkWP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi_scpkWP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi_scpkWP

% Last Modified by GUIDE v2.5 25-Jun-2021 18:41:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi_scpkWP_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi_scpkWP_OutputFcn, ...
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


% --- Executes just before Responsi_scpkWP is made visible.
function Responsi_scpkWP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi_scpkWP (see VARARGIN)

% Choose default command line output for Responsi_scpkWP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi_scpkWP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi_scpkWP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tampil.
function tampil_Callback(hObject, eventdata, handles)
% hObject    handle to tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real_estate.xlsx');
opts.SelectedVariableNames = (1:5);
data = readmatrix('Real_estate.xlsx', opts);
set(handles.tabel1,'data',data,'visible','on'); %membaca file dan menampilkan pada tabel


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real_estate.xlsx');
opts.SelectedVariableNames = (2:5);
data = readmatrix('Real_estate.xlsx', opts); %membaca file
k=[0,0,1,0]; %cost atau benefit
w=[3,5,4,1]; %bobot kriteria

%tahapan pertama, perbaikan bobot
[m n]=size (data); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(data(i,:).^w);
end;

opts = detectImportOptions('Real_estate.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('Real_estate.xlsx', opts);
xlswrite('hasil_wp.xlsx', baru, 'Sheet1', 'A1'); %menulis data pada file colom A1
S=S'; %merubah data hasil perhitungan dari horizontal ke vertikal matrix
xlswrite('hasil_wp.xlsx', S, 'Sheet1', 'B1'); %menulis data pada file colom B1

opts = detectImportOptions('hasil_wp.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('hasil_wp.xlsx', opts); %membaca file

X=sortrows(data,2,'descend'); %mengurutkan data dari file berdasar kolom ke-2 dari terbesar
set(handles.tabel2,'data',X,'visible','on'); %menampilkan data yang telah diurutkan ke tabel
