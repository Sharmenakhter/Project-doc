function varargout = ProjectGUI40(varargin)
% PROJECTGUI40 M-file for ProjectGUI40.fig
%      PROJECTGUI40, by itself, creates a new PROJECTGUI40 or raises the existing
%      singleton*.
%
%      H = PROJECTGUI40 returns the handle to a new PROJECTGUI40 or the handle to
%      the existing singleton*.
%
%      PROJECTGUI40('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTGUI40.M with the given input arguments.
%
%      PROJECTGUI40('Property','Value',...) creates a new PROJECTGUI40 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectGUI40_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectGUI40_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectGUI40

% Last Modified by GUIDE v2.5 07-Jan-2017 19:58:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectGUI40_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectGUI40_OutputFcn, ...
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


% --- Executes just before ProjectGUI40 is made visible.
function ProjectGUI40_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectGUI40 (see VARARGIN)

% Choose default command line output for ProjectGUI40
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectGUI40 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectGUI40_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in trainsvm.
function trainsvm_Callback(hObject, eventdata, handles)
% hObject    handle to trainsvm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xdata,group] = TrainSVM(handles);
svmModel = svmtrain(xdata, group);
handles.svmModel = svmModel;
h = msgbox('Training Completed','Success');
guidata(hObject, handles);

% --- Executes on button press in imgload.
function imgload_Callback(hObject, eventdata, handles)
% hObject    handle to imgload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath]=uigetfile({'*.jpg';'*.bmp'},'File Selector');
image = strcat(FilePath,FileName);
set(handles.axes1);
imshow(image);
handles.image = image;
guidata(hObject, handles);

% --- Executes on button press in imageproc.
function imageproc_Callback(hObject, eventdata, handles)
% hObject    handle to imageproc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imageArray = imread(handles.image);
[bwfim,fim,otsulevel] = imageProcessing(imageArray,handles);
handles.fim = fim;
handles.bwfim = bwfim;
handles.otsulevel = otsulevel;
guidata(hObject, handles);

% --- Executes on button press in fcmseg.
function fcmseg_Callback(hObject, eventdata, handles)
% hObject    handle to fcmseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[bwfim1] = fcmseg(handles.fim,handles.bwfim,handles.otsulevel,handles);
handles.bwfim1 = bwfim1;
%set(handles.axes1);
%imshow(bwfim1);
h = msgbox('Fuzzy C-Means clustring performed !','FCM Information');
guidata(hObject, handles);
% --- Executes on button press in feexglcm.
function feexglcm_Callback(hObject, eventdata, handles)
% hObject    handle to feexglcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ dataVector  ]= glcmsFeatureExtract(handles);
handles.dataVector = dataVector;
h = msgbox('Feature extracted successfully !');
guidata(hObject, handles);

% --- Executes on button press in prediction.
function prediction_Callback(hObject, eventdata, handles)
% hObject    handle to prediction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pred = svmclassify(handles.svmModel, handles.dataVector);
handles.pred = pred;
if pred ==1
    prediction = 'Benign';
else
    prediction = 'Malignant';
end
h = msgbox(prediction);
%set(handles.PredictedOutput,'String',prediction);
guidata(hObject, handles);
