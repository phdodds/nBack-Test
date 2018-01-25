function varargout = NBackTest(varargin)
% NBACKTEST MATLAB code for NBackTest.fig
%      NBACKTEST, by itself, creates a new NBACKTEST or raises the existing
%      singleton*.
%
%      H = NBACKTEST returns the handle to a new NBACKTEST or the handle to
%      the existing singleton*.
%
%      NBACKTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NBACKTEST.M with the given input arguments.
%
%      NBACKTEST('Property','Value',...) creates a new NBACKTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NBackTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NBackTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NBackTest

% Last Modified by GUIDE v2.5 24-Jan-2015 18:06:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NBackTest_OpeningFcn, ...
                   'gui_OutputFcn',  @NBackTest_OutputFcn, ...
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

% --- Executes during object creation, after setting all properties.
function UserNBackLevelTest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UserNBackLevelTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% USER LAST NAME EDIT TEXT CREATION FUNCTION
% --- Executes during object creation, after setting all properties.
function UserLastNameEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UserLastNameEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes just before NBackTest is made visible.
function NBackTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NBackTest (see VARARGIN)

% Choose default command line output for NBackTest
clc;
handles.output = hObject;

handles.optionshandles.LureLevel = 3; %default Lure Level
handles.optionshandles.NbrTargets = 16; %default number of targets
handles.optionshandles.NbrLures = 8;
handles.optionshandles.TestLength = 64; %default Test Length
handles.optionshandles.n_Number = 3; %default n-Number
handles.optionshandles.DisplayTime = 1000; %stimulus display time in milliseconds
handles.optionshandles.GapTime = 2000;%interstimulus interval in milliseconds
handles.optionshandles.TrialTypeAmount = 8;
handles.ErrorMessage = 0;
handles.KeyboardSwitch = false; %switch activating keyboard controls

handles.SubjectLastName = 'Unknown'; %Default user name
handles.TestVect = zeros(1,handles.optionshandles.TestLength+3); %list of stimuli
handles.LureVect = zeros(1,handles.optionshandles.NbrLures); %vect of Lure positions
handles.timing = zeros(1,length(handles.TestVect)-3); %vector to be filled with response times
handles.timingIdx = 1; %begin at first timing position
handles.response = zeros(1,length(handles.TestVect)-3) ; %vector to be filled with match/no match responses
guidata(hObject, handles) %update handles 


set(handles.StartButton, 'Enable', 'off') %make start button transparent
set(handles.MatchButton,'Enable','off') %make match button transparent
set(handles.NoMatchButton,'Enable','off') %make no match button transparent
set(handles.RecordResults, 'Enable','off')%make record results button transparent
set(handles.FileMenuRecordResults, 'Enable','off')

% StartImage = imread ('Images/RPILogo.png'); %Show blank image in axes
% imshow(StartImage);
axis off;
guidata(hObject, handles) %update handles 



% --- Outputs from this function are returned to the command line.
function varargout = NBackTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function menuAdjustParameters_Callback(hObject, eventdata, handles)
[ handles.optionshandles ] = NBackTestOptions( handles.optionshandles );
guidata(hObject, handles)

% --- Executes on button press in GenerateTestButton.
function GenerateTestButton_Callback(hObject, eventdata, handles)
clc;
set(handles.StartButton, 'Enable', 'on');

guidata(hObject, handles);
[ handles.TestVect, handles.LureVect] = NbackGeneratorFunction( handles.optionshandles.TestLength,... 
    handles.optionshandles.LureLevel,handles.optionshandles.NbrTargets, handles.optionshandles.n_Number,...
    handles.optionshandles.NbrLures, handles.optionshandles.TrialTypeAmount);
handles.timing = zeros(1,length(handles.TestVect)-3); %vector to be filled with response times
handles.response = zeros(1,length(handles.TestVect)-3) ; %vector to be filled with match/no match responses
handles.NoUserResponse = [];
guidata(hObject, handles)
% handles    structure with handles and user data (see GUIDATA)



function UserLastNameEditText_Callback(hObject, eventdata, handles)
handles.SubjectLastName = strcat(get(hObject, 'String')); %Gets user input last name
guidata(hObject, handles)

% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
%% TEST BEGINS
clc;
set(handles.UserLastNameEditText,'Enable','off') %make UserLastNameEditText transparent
set(handles.StartButton,'Enable','off') %make start button transparent
set(handles.GenerateTestButton,'Enable','off') %make Generate Test button transparent
imshow('Images/00.jpg'); %show initial blank picture for 500 ms
pause(1);
%% SHOW FIRST THREE IMAGES, 500 MS EACH, 2000 MS BLANK SPACE
for run = 1:3
imshow(strcat('Images/0',num2str(handles.TestVect(run)),'.jpg')); %show first images
pause(handles.optionshandles.DisplayTime/1000);
imshow('Images/00.jpg');
pause(handles.optionshandles.GapTime/1000);
end

%% MATCH AND NO MATCH BUTTONS BECOME CLICKABLE
handles.KeyboardSwitch = true;
guidata(hObject, handles);
set(handles.MatchButton,'Enable','on') %make match button opaque
set(handles.NoMatchButton,'Enable','on') %make no match button opaque

%% TEST CYCLES THROUGH TEST VECTOR
NoResponseCounter = 1;
fig = get(hObject, 'Parent'); %Get data from figure
for testrun = 4:length(handles.TestVect) %run through stimuli
    handles = guidata(fig); %update handles structure
    
    %if user has not responded, document the position they missed and
    %advance the timingIdx.
    if testrun-3 ~= handles.timingIdx
        handles.NoUserResponse(NoResponseCounter) = handles.timingIdx;
        NoResponseCounter = NoResponseCounter+1;
        handles.timingIdx = handles.timingIdx+1;
        guidata(hObject, handles)
    end
    
    
    set(handles.MatchButton,'Enable','on') %make match button opaque
    set(handles.NoMatchButton,'Enable','on') %make no match button opaque
    tic; %begin timing 
    imshow(strcat('Images/0',num2str(handles.TestVect(testrun)),'.jpg')) %show test stimulus
    pause(handles.optionshandles.DisplayTime/1000); %display for user selected DisplayTime
    imshow('Images/00.jpg'); %shows blank image
    pause(handles.optionshandles.GapTime/1000); %display for user selected GapTi

end

imshow('Images/RPILogo.png')
helpdlg('Test Complete! Please select "Record Results" from the menu bar');
set(handles.MatchButton,'Enable','off') %make match button transparent
set(handles.NoMatchButton,'Enable','off') %make no match button transparent
set(handles.RecordResults, 'Enable','on')%make record results button opaque
set(handles.FileMenuRecordResults, 'Enable', 'on')
handles = guidata(fig); %update handles structure
guidata(hObject, handles)







% --- Executes on button press in NoMatchButton.
function NoMatchButton_Callback(hObject, eventdata, handles)
handles.timing(handles.timingIdx) = toc; %compute elapsed time
set(handles.NoMatchButton,'Enable','off') %make no match button transparent
set(handles.MatchButton,'Enable','off') %make no match button transparent
handles.response(handles.timingIdx) = 0; %output false answer
handles.timingIdx = handles.timingIdx+1; %advance timing idx
guidata(hObject, handles)


% --- Executes on button press in MatchButton.
function MatchButton_Callback(hObject, eventdata, handles)
handles.timing(handles.timingIdx) = toc; %compute elapsed time
set(handles.MatchButton,'Enable','off') %make no match button transparent
set(handles.NoMatchButton,'Enable','off') %make no match button transparent
handles.response(handles.timingIdx) = 1; %output true answer
handles.timingIdx = handles.timingIdx+1; %advance timing idx
guidata(hObject, handles)



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuAdjust_Callback(hObject, eventdata, handles)
% hObject    handle to menuAdjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function FileMenuRecordResults_Callback(hObject, eventdata, handles)
recordResults( handles.TestVect, handles.optionshandles.n_Number, handles.timing,...
    handles.SubjectLastName, handles.response, handles.LureVect,handles.optionshandles.TestLength,...
    handles.optionshandles.NbrTargets, handles.optionshandles.NbrLures,handles.NoUserResponse);
 
   
   function FileMenuResetTest_Callback(hObject, eventdata, handles)
set(handles.StartButton, 'Enable', 'off') %make start button transparent
set(handles.MatchButton,'Enable','off') %make match button transparent
set(handles.NoMatchButton,'Enable','off') %make no match button transparent
set(handles.GenerateTestButton, 'Enable', 'on'); %make GenerateTest button opaque
set(handles.UserLastNameEditText,'Enable','on') %make UserLastNameEditText opaque
Test = {'TestVect'};
handles = rmfield( handles,Test);
UserData = {'timing','response'};
handles = rmfield(handles, UserData);
Indices = {'timingIdx'};
handles = rmfield(handles, Indices);
LureVector = {'LureVect'};
handles = rmfield( handles,LureVector);
NoRes = {'NoUserResponse'};
handles = rmfield(handles, NoRes);
handles.timingIdx = 1;
guidata(hObject, handles);



   
   function FileMenuExit_Callback(hObject, eventdata, handles)
close all; clear all;

% --------------------------------------------------------------------
function RecordResults_Callback(hObject, eventdata, handles)
recordResults( handles.TestVect, handles.optionshandles.n_Number, handles.timing,...
    handles.SubjectLastName, handles.response, handles.LureVect, handles.optionshandles.TestLength,...
    handles.optionshandles.NbrTargets, handles.optionshandles.NbrLures, handles.NoUserResponse)
set(handles.RecordResults, 'Enable','off')


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
if handles.KeyboardSwitch == true; %ALLOWS USER TO SELECT ANSWER WITH THE KEYBOARD
switch eventdata.Character
    case 'z'
        NoMatchButton_Callback(hObject, eventdata, handles)
    case 'Z' 
        NoMatchButton_Callback(hObject, eventdata, handles)
    case '/'
        MatchButton_Callback(hObject, eventdata, handles)
end
end

%%
% Peter Dodds
% Rensselear Polytechnic Institute
% M.S. Architectural Acoustics - 2015


