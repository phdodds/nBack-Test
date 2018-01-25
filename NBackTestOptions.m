function varargout = NBackTestOptions(varargin)
% NBACKTESTOPTIONS MATLAB code for NBackTestOptions.fig
%      NBACKTESTOPTIONS, by itself, creates a new NBACKTESTOPTIONS or raises the existing
%      singleton*.
%
%      H = NBACKTESTOPTIONS returns the handle to a new NBACKTESTOPTIONS or the handle to
%      the existing singleton*.
%
%      NBACKTESTOPTIONS('CALLBACK',hObject,eventData,optionshandles,...) calls the local
%      function named CALLBACK in NBACKTESTOPTIONS.M with the given input arguments.
%
%      NBACKTESTOPTIONS('Property','Value',...) creates a new NBACKTESTOPTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NBackTestOptions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NBackTestOptions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIoptionshandles

% Edit the above text to modify the response to help NBackTestOptions

% Last Modified by GUIDE v2.5 26-Jan-2015 13:27:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NBackTestOptions_OpeningFcn, ...
                   'gui_OutputFcn',  @NBackTestOptions_OutputFcn, ...
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


% --- Executes just before NBackTestOptions is made visible.
function NBackTestOptions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% optionshandles    structure with optionshandles and user data (see GUIDATA)
% varargin   command line arguments to NBackTestOptions (see VARARGIN)

% Choose default command line output for NBackTestOptions
handles.optionshandles = varargin{1};
set(handles.TestLengthEditText, 'String', num2str(handles.optionshandles.TestLength));
set(handles.LureLevelEditText,'String', num2str(handles.optionshandles.LureLevel));
set(handles.NumberTargetsEditText, 'String', num2str(handles.optionshandles.NbrTargets));
set(handles.n_NumberEditText, 'String', num2str(handles.optionshandles.n_Number));
set(handles.DisplayTimeEditText, 'String', num2str(handles.optionshandles.DisplayTime));
set(handles.GapTimeEditText, 'String', num2str(handles.optionshandles.GapTime));
set(handles.NbrLuresEditText, 'String', num2str(handles.optionshandles.NbrLures));
set(handles.TrialTypeAmountEditText, 'String', num2str(handles.optionshandles.TrialTypeAmount));

% Update optionshandles structure
guidata(hObject, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
uiresume(hObject)

% --- Outputs from this function are returned to the command line.
function varargout = NBackTestOptions_OutputFcn(hObject, eventdata, handles) 
uiwait(hObject); %makes GUI wait for user response

handles.optionshandles.TestLength = str2double(get(handles.TestLengthEditText, 'String'));
handles.optionshandles.NbrTargets = str2double(get(handles.NumberTargetsEditText, 'String'));
handles.optionshandles.LureLevel = str2double(get(handles.LureLevelEditText, 'String'));
handles.optionshandles.n_Number = str2double(get(handles.n_NumberEditText, 'String'));
handles.optionshandles.DisplayTime = str2double(get(handles.DisplayTimeEditText, 'String'));
handles.optionshandles.GapTime = str2double(get(handles.GapTimeEditText,'String'));
handles.optionshandles.NbrLures = str2double(get(handles.NbrLuresEditText,'String'));
handles.optionshandles.TrialTypeAmount = str2double(get(handles.TrialTypeAmountEditText,'String'));
varargout{1} = handles.optionshandles;
handles = guidata(hObject);
delete(hObject);
% Get default command line output from optionshandles structure


%% TEXT EDIT BOX CREATION
% --- Executes during object creation, after setting all properties.
function TestLengthEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TestLengthEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% optionshandles    empty - optionshandles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function n_NumberEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_NumberEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function LureLevelEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LureLevelEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% optionshandles    empty - optionshandles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function NumberTargetsEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberTargetsEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% optionshandles    empty - optionshandles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function DisplayTimeEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DisplayTimeEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function GapTimeEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GapTimeEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function TrialTypeAmountEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrialTypeAmountEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function NbrLuresEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbrLuresEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% TEST EDIT BOX CALLBACKS
function TestLengthEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.TestLength = str2double(get(hObject, 'String')); %Gets user input n-Back Level
handles = guidata(hObject);

% Hints: get(hObject,'String') returns contents of TestLengthEditText as text
%        str2double(get(hObject,'String')) returns contents of TestLengthEditText as a double

function LureLevelEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.LureLevel = str2double(get(hObject, 'String')); %Gets user input Lure Level
if handles.optionshandles.LureLevel > 3 || handles.optionshandles.LureLevel < 0
    errordlg('Lure Level must be between 0 and 3.')
end
handles = guidata(hObject);


function NbrLuresEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.NbrLures = str2double(get(hObject, 'String'));
handles = guidata(hObject);


function TrialTypeAmountEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.TrialTypeAmount = str2double(get(hObject, 'String'));
handles = guidata(hObject);

function NumberTargetsEditText_Callback(hObject, eventdata, handles)
% hObject    handle to NumberTargetsEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% optionshandles    structure with optionshandles and user data (see GUIDATA)
handles.optionshandles.NbrTargets = str2double(get(hObject, 'String')); %Gets user input number of targets
handles = guidata(hObject);

function n_NumberEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.n_Number = str2double(get(hObject, 'String'));
handles = guidata(hObject);

function DisplayTimeEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.DisplayTime = str2double(get(hObject,'String'));
handles = guidata(hObject);


function GapTimeEditText_Callback(hObject, eventdata, handles)
handles.optionshandles.GapTime = str2double(get(hObject,'String'));
handles = guidata(hObject);


%% OK BUTTON 
% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
close;

%%
%Peter Dodds
%Rensselaer Polytechnic Institute
%M.S. - Architectural Acoustics 2015
%
