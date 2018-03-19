function varargout = gui_test2(varargin)
% GUI_TEST2 MATLAB code for gui_test2.fig
%      GUI_TEST2, by itself, creates a new GUI_TEST2 or raises the existing
%      singleton*.
%
%      H = GUI_TEST2 returns the handle to a new GUI_TEST2 or the handle to
%      the existing singleton*.
%
%      GUI_TEST2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TEST2.M with the given input arguments.
%
%      GUI_TEST2('Property','Value',...) creates a new GUI_TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_test2

% Last Modified by GUIDE v2.5 17-Mar-2018 02:25:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_test2_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_test2_OutputFcn, ...
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


% --- Executes just before gui_test2 is made visible.
% --- Executes during object creation, after setting all properties.
function display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate display
function gui_test2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_test2 (see VARARGIN)

% Choose default command line output for gui_test2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_test2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_test2_OutputFcn(hObject, eventdata, handles) 
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

[filename,pathname]=uigetfile();


%I=imread((answer));
global I
I=imread(strcat(pathname,filename));
axes(handles.display)
imshow(I)
%imshow(I);






% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
[filename, foldername] = uiputfile('Where do you want the file saved?');
complete_name = fullfile(foldername, filename);
imwrite(I, complete_name,'Bitdepth', 16);
 

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
 L= bwlabel(I);
 L = unique(L);
 disp(L);
 axes(handles.display)
   
 
 




% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'threshold value'};
dlg_title = 'threshold';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);



global I


if size(I,3)==3
I=rgb2gray(I);
%I=(0.299*I(:,:,1) +0.587* I(:,:,2) +  0.114 *I(:,:,3));
end

I(I>=(str2double(answer{1})))=255;

I(I<(str2double(answer{1})))=0;




axes(handles.display)
imshow((I))



% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'input percentile value'};
dlg_title = 'p-tilethreshold';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
global I
if size(I,3)==3
I=rgb2gray(I);
%I=(0.299*I(:,:,1) +0.587* I(:,:,2) +  0.114 *I(:,:,3));

end
Y = prctile(I,str2double(answer{1}));
I(I>=Y)=255;
I(I<Y)=0;
axes(handles.display)
imshow((I))


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I



Id = im2double(I);
Imax = max(Id(:));
Imin = min(Id(:));
T = 0.5*(min(Id(:)) + max(Id(:)));
deltaT = 0.01;
done = false;
counter = 1;
while ~done
	savedThresholds(counter) = T;
	
	g = Id >= T;
	Tnext = 0.5*(mean(Id(g)) + mean(Id(~g)));
	done = abs(T - Tnext) < deltaT;
	T = Tnext;
	
	
	
	I=g;
    axes(handles.display)
    imshow((I))

	
	
	
	
	promptMessage = sprintf('Threshold for iteration %d is %f.\nDo you want to Continue processing,\nor Quit processing?', ...
		counter, savedThresholds(counter));
	titleBarCaption = 'Continue?';
	buttonText = questdlg(promptMessage, titleBarCaption, 'Continue', 'Quit', 'Continue');
	if strcmpi(buttonText, 'Quit')
		return;
	end
	
	% Increment loop interation counter.
	counter = counter + 1;
end



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter n(rows)','Enter m(cols)'};
dlg_title = 'Enter n and m which will give the area to take median off';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);



global I
if size(I,3)==3
I=rgb2gray(I);
%I=(0.299*I(:,:,1) +0.587* I(:,:,2) +  0.114 *I(:,:,3));
end

I = medfilt2(I,[str2double(answer{1}) str2double(answer{2})]);
%[i,j]=size(I);

%value=zeros(i,j);

%for ii=1+(str2double(answer{1}-2):i-(str2double(answer{1}-2)

%    for jj=1+(str2double(answer{2}-2):j-(str2double(answer{2}-2)
  %  calc_med=[];
  %       for kk=-str2double(answer{1}):str2double(answer{1})
  %           for ll=-str2double(answer{2}):str2double(answer{2})
  %               calc_med=[calc_med,I(ii+kk,jj+ll)];
   %          end
   %      end
         
   %      value(ii,jj)=median(calc_med);
%end
%end
%I=value;
%axes(handles.display)
%    imshow((I))


%median filter
%B = imresize(image1,[600 600]);
%gray=(0.299*B(:,:,1) +0.587* B(:,:,2) +  0.114 *B(:,:,3));
%gray = uint8(newV);
%imshow(gray);
%[i,j]=size(gray);
%value=zeros(i,j);
%x = 3;
%for ii=1+(x-2):i-(x-2)
  % for jj=1+(x-2):j-(x-2)
  %     calc_med=[];
  %     for kk=-1:1
  %         for ll=-1:1
               %disp(ii+kk);
%               calc_med=[calc_med, gray(ii+kk,jj+ll)];
%          end
%       end      
%     value(ii,jj)=median(calc_med);
%   end
%end
%I=value;
%imshow(uint8(I));



axes(handles.display)
imshow(I)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter filter size eg 3 for 3x3 or 5 for 5x5'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);

h=ones(str2double(answer{1}),str2double(answer{1}))/(str2double(answer{1})*str2double(answer{1}));
global I
I=imfilter(I,h);
axes(handles.display)
imshow(I)



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I
I=(I);
if(string(class(I))=="logical")
    I=double(I);
end
%I = imnoise(I,'gaussian');
      px= 0;
      py = 0.05;
      J = im2double(I);
      b = J + sqrt(py)*randn(size(J)) + px;
      I=b;
axes(handles.display)
imshow(I)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=(I);
if(string(class(I))=="logical")
    I=double(I);
end
I = imnoise(I,'poisson');

axes(handles.display)
imshow(I)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=(I);
if(string(class(I))=="logical")
    I=double(I);
end
I = imnoise(I,'salt & pepper');
%p=0.01; 
%b = I;
%x = rand(size(b));
%d = find(x < p/2);
%b(d) = 0; 
%d = find(x >= p/2 & x < p);
%b(d) = 1; 
%imshow(b);
%I=b;
axes(handles.display)
imshow(I)



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=(I);
if(string(class(I))=="logical")
    I=double(I);
end
I = imnoise(I,'speckle');
%px= 0.05;
%J = im2double(I);
%b = J + sqrt(12*px)*J.*(rand(size(J))-.5);
%I=b;
axes(handles.display)
disp(size(I));
imshow(I)


% --- Executes during object deletion, before destroying properties.
function pushbutton15_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
axes(handles.display)
%imshow(I)
grayImage = I;
reform = im2double(grayImage);
Imax = max(reform(:));
Imin = min(reform(:));
T = 0.5*(min(reform(:)) + max(reform(:)));
stop_criterion = 0.01;
done = false;
counter = 1;
while ~done
	savedThresholds(counter) = T;
	
	intermediate_image = reform >= T;
    imshow(intermediate_image(:, :, 1))
	Tnext = 0.5*(mean(reform(intermediate_image)) + mean(reform(~intermediate_image)));
	done = abs(T - Tnext) < stop_criterion;
	T = Tnext;
	
	
	
	
	promptMessage = sprintf('Threshold for iteration %d is %f.\nDo you want to Continue processing,\nor Quit processing?', ...
		counter, savedThresholds(counter));
	titleBarCaption = 'Continue?';
	buttonText = questdlg(promptMessage, titleBarCaption, 'Continue', 'Quit', 'Continue');
	if strcmpi(buttonText, 'Quit')
		return;
	end
	
	% Increment loop interation counter.
	counter = counter + 1;
end
    I=intermediate_image;
    
    disp(size(I));
    axes(handles.display)
    I=I(:,:,1);
    imshow(I(:, :, 1))
    


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=I(:,:,1);
I=im2double(I);
%get size
[x,y]=size(I);
%make new array
new_I_1=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_1(ii,jj)=-1*I(ii,jj)+0+0+1*I(ii+1,jj+1);
    
    end
end
new_I_2=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_2(ii,jj)=0-1*I(ii+1,jj)+1*I(ii,jj+1)+0;
    
    end
end
new_I_3=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_3(ii,jj)=0-1*I(ii,jj+1)+1*I(ii+1,jj)+0;
    
    end
end

disp(size(I));
I=new_I_1+new_I_2+new_I_3;
disp(size(I));
axes(handles.display)
imshow(I)



%h=[0 -1;1 0];
%I_new_1=imfilter(I,h);
%h=[-1 0;0 1];
%I_new_2=imfilter(I,h);
%disp(size(I));
%I=I_new_1+I_new_2;
%disp(size(I));
%axes(handles.display)
%imshow(I)




% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=I(:,:,1);
I=im2double(I);

%[x,y]=size(I);
%new_I_1=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_1(ii,jj)=-1*I(ii,jj)-2*I(ii,jj+1)-1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)+2*I(ii+2,jj+1)+1*I(ii+2,jj+2);
    
%    end
%end
%new_I_2=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_2(ii,jj)=-1*I(ii,jj)+0+1*I(ii,jj+2)-2*I(ii+1,jj)+0+2*I(ii+1,jj+2)-1*I(ii+2,jj)+0+1*I(ii+2,jj+2);
    
%    end
%end
%new_I_3=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_3(ii,jj)=1*I(ii,jj)+2*I(ii,jj+1)+1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)-2*I(ii+2,jj+1)-1*I(ii+2,jj+2);
    
%    end
%end
%disp(size(I));
%I=new_I_1+new_I_2;%+new_I_3;
%disp(size(I));
%axes(handles.display)
%imshow(I)



h=[1 2 1;0 0 0;-1 -2 -1];

I_new_1=imfilter(I,h);
h=[1 0 -1;2 0 -2;1 0 -1];
I_new_2=imfilter(I,h);
disp(size(I));
I=I_new_1+I_new_2;
disp(size(I));
axes(handles.display)
imshow(I)

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=I(:,:,1);
I=im2double(I);

%[x,y]=size(I);
%new_I_1=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_1(ii,jj)=-1*I(ii,jj)-1*I(ii,jj+1)-1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)+1*I(ii+2,jj+1)+1*I(ii+2,jj+2);
%   
%    end
%end
%new_I_2=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_2(ii,jj)=-1*I(ii,jj)+0+1*I(ii,jj+2)-1*I(ii+2,jj)+0+1*I(ii+1,jj+2)-1*I(ii+2,jj)+0+1*I(ii+2,jj+2);
%   
%    end
%end
%new_I_3=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_3(ii,jj)=1*I(ii,jj)+2*I(ii,jj+1)+1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)-2*I(ii+2,jj+1)-1*I(ii+2,jj+2);
%   
%    end
%end
%disp(size(I));
%I=new_I_1+new_I_2;%+new_I_3;
%disp(size(I));
%axes(handles.display)
%imshow(I)






h=[-1 0 1;-1 0 1;1 0 -1];
I_new_1=imfilter(I,h);
h=[-1 -1 -1;0 0 0;1 1 1];
I_new_2=imfilter(I,h);
disp(size(I));
I=I_new_1+I_new_2;
disp(size(I));
axes(handles.display)
imshow(I)

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=I(:,:,1);
I=im2double(I);


%[x,y]=size(I);
%new_I_1=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_1(ii,jj)=-1*I(ii,jj)+0*I(ii,jj+1)+1*I(ii,jj+2)-1*I(ii+1,jj)+0*I(ii+1,jj+1)+1*I(ii+1,jj+2)-1*I(ii+2,jj)+0*I(ii+2,jj+1)+1*I(ii+2,jj+2);
%   
%    end
%end
%new_I_2=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_2(ii,jj)=1*I(ii,jj)+1*I(ii,jj+1)+1*I(ii,jj+2)+0*I(ii+1,jj)+0*I(ii+1,jj+1)+0*I(ii+1,jj+2)-1*I(ii+2,jj)-1*I(ii+2,jj+1)-1*I(ii+2,jj+2);
   
%    end
%end
%new_I_3=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_3(ii,jj)=0*I(ii,jj)+1*I(ii,jj+1)+1*I(ii,jj+2)+-1*I(ii+1,jj)+0*I(ii+1,jj+1)-1*I(ii+1,jj+2)-1*I(ii+2,jj)-1*I(ii+2,jj+1)+0*I(ii+2,jj+2);
%   
%    end
%end
%new_I_4=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_4(ii,jj)=1*I(ii,jj)+1*I(ii,jj+1)+0*I(ii,jj+2)+1*I(ii+1,jj)+0*I(ii+1,jj+1)-1*I(ii+1,jj+2)+0*I(ii+2,jj)-1*I(ii+2,jj+1)-1*I(ii+2,jj+2);
%   
%    end
%end
%disp(size(I));
%for i=1:x
%    for j=1:y
%        I(i,j)=max([new_I_1(i,j);new_I_2(i,j);new_I_3(i,j);new_I_4(i,j)]);
%    end
%end
%I=new_I_1+new_I_2+new_I_3+new_I_4;
%disp(size(I));
%axes(handles.display)
%imshow(I)


h=[-1 0 1;-1 0 1;1 0 -1];
I_new_1=imfilter(I,h);
h=[1 1 1;0 0 0;-1 -1 -1];
I_new_2=imfilter(I,h);
h=[0 1 1;-1 0 1;-1 -1 0];
I_new_3=imfilter(I,h);
h=[1 1 0;1 0 -1;0 -1 -1];
I_new_4=imfilter(I,h);
disp(size(I));
[x,y]=size(I);
for i=1:x
    for j=1:y
        I(i,j)=max([I_new_1(i,j);I_new_2(i,j);I_new_3(i,j);I_new_4(i,j)]);
    end
end
%I=I_new_1+I_new_2+I_new_3+I_new_4;
disp(size(I));
axes(handles.display)
imshow(I)

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=I(:,:,1);
I=im2double(I);


[x,y]=size(I);
new_I_1=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_1(ii,jj)=-1*I(ii,jj)-1*I(ii,jj+1)-1*I(ii,jj+2)-1*I(ii+1,jj)+8*I(ii+1,jj+1)-1*I(ii+1,jj+2)-1*I(ii+2,jj)-1*I(ii+2,jj+1)-1*I(ii+2,jj+2);
   
    end
end

%h=[-1 -1 -1;-1 8 -1;-1 -1 -1];
%I_new_1=imfilter(I,h);
%disp(size(I));
I=I-new_I_1;
%I=I-I_new_1;
disp(size(I));
axes(handles.display)
imshow(I)

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%roberts
global I
I=I(:,:,1);
I=im2double(I);
%get size
[x,y]=size(I);
%make new array
new_I_1=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_1(ii,jj)=-1*I(ii,jj)+0+0+1*I(ii+1,jj+1);
    
    end
end
new_I_2=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_2(ii,jj)=0-1*I(ii+1,jj)+1*I(ii,jj+1)+0;
    
    end
end
new_I_3=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_3(ii,jj)=0-1*I(ii,jj+1)+1*I(ii+1,jj)+0;
    
    end
end

disp(size(I));
I=new_I_1+new_I_2+new_I_3;
disp(size(I));
axes(handles.display)
imshow(I)



%h=[0 -1;1 0];
%I_new_1=imfilter(I,h);
%h=[-1 0;0 1];
%I_new_2=imfilter(I,h);
%disp(size(I));
%I=I_new_1+I_new_2;
%disp(size(I));
%axes(handles.display)
%imshow(I)




% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%sobel
global I
I=I(:,:,1);
I=im2double(I);

%[x,y]=size(I);
%new_I_1=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_1(ii,jj)=-1*I(ii,jj)-2*I(ii,jj+1)-1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)+2*I(ii+2,jj+1)+1*I(ii+2,jj+2);
    
%    end
%end
%new_I_2=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_2(ii,jj)=-1*I(ii,jj)+0+1*I(ii,jj+2)-2*I(ii+1,jj)+0+2*I(ii+1,jj+2)-1*I(ii+2,jj)+0+1*I(ii+2,jj+2);
    
%    end
%end
%new_I_3=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_3(ii,jj)=1*I(ii,jj)+2*I(ii,jj+1)+1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)-2*I(ii+2,jj+1)-1*I(ii+2,jj+2);
    
%    end
%end
%disp(size(I));
%I=new_I_1+new_I_2;%+new_I_3;
%disp(size(I));
%axes(handles.display)
%imshow(I)



h=[1 2 1;0 0 0;-1 -2 -1];

I_new_1=imfilter(I,h);
h=[1 0 -1;2 0 -2;1 0 -1];
I_new_2=imfilter(I,h);
disp(size(I));
I=I_new_1+I_new_2;
disp(size(I));
axes(handles.display)
imshow(I)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
I=I(:,:,1);
I=im2double(I);

%[x,y]=size(I);
%new_I_1=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_1(ii,jj)=-1*I(ii,jj)-1*I(ii,jj+1)-1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)+1*I(ii+2,jj+1)+1*I(ii+2,jj+2);
%   
%    end
%end
%new_I_2=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_2(ii,jj)=-1*I(ii,jj)+0+1*I(ii,jj+2)-1*I(ii+2,jj)+0+1*I(ii+1,jj+2)-1*I(ii+2,jj)+0+1*I(ii+2,jj+2);
%   
%    end
%end
%new_I_3=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_3(ii,jj)=1*I(ii,jj)+2*I(ii,jj+1)+1*I(ii,jj+2)+0+0+0+1*I(ii+2,jj)-2*I(ii+2,jj+1)-1*I(ii+2,jj+2);
%   
%    end
%end
%disp(size(I));
%I=new_I_1+new_I_2;%+new_I_3;
%disp(size(I));
%axes(handles.display)
%imshow(I)






h=[-1 0 1;-1 0 1;1 0 -1];
I_new_1=imfilter(I,h);
h=[-1 -1 -1;0 0 0;1 1 1];
I_new_2=imfilter(I,h);
disp(size(I));
I=I_new_1+I_new_2;
disp(size(I));
axes(handles.display)
imshow(I)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I
I=I(:,:,1);
I=im2double(I);


%[x,y]=size(I);
%new_I_1=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_1(ii,jj)=-1*I(ii,jj)+0*I(ii,jj+1)+1*I(ii,jj+2)-1*I(ii+1,jj)+0*I(ii+1,jj+1)+1*I(ii+1,jj+2)-1*I(ii+2,jj)+0*I(ii+2,jj+1)+1*I(ii+2,jj+2);
%   
%    end
%end
%new_I_2=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_2(ii,jj)=1*I(ii,jj)+1*I(ii,jj+1)+1*I(ii,jj+2)+0*I(ii+1,jj)+0*I(ii+1,jj+1)+0*I(ii+1,jj+2)-1*I(ii+2,jj)-1*I(ii+2,jj+1)-1*I(ii+2,jj+2);
   
%    end
%end
%new_I_3=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_3(ii,jj)=0*I(ii,jj)+1*I(ii,jj+1)+1*I(ii,jj+2)+-1*I(ii+1,jj)+0*I(ii+1,jj+1)-1*I(ii+1,jj+2)-1*I(ii+2,jj)-1*I(ii+2,jj+1)+0*I(ii+2,jj+2);
%   
%    end
%end
%new_I_4=zeros(x,y);
%for ii=1:x-2
%    for jj=1:y-2
%        new_I_4(ii,jj)=1*I(ii,jj)+1*I(ii,jj+1)+0*I(ii,jj+2)+1*I(ii+1,jj)+0*I(ii+1,jj+1)-1*I(ii+1,jj+2)+0*I(ii+2,jj)-1*I(ii+2,jj+1)-1*I(ii+2,jj+2);
%   
%    end
%end
%disp(size(I));
%for i=1:x
%    for j=1:y
%        I(i,j)=max([new_I_1(i,j);new_I_2(i,j);new_I_3(i,j);new_I_4(i,j)]);
%    end
%end
%I=new_I_1+new_I_2+new_I_3+new_I_4;
%disp(size(I));
%axes(handles.display)
%imshow(I)


h=[-1 0 1;-1 0 1;1 0 -1];
I_new_1=imfilter(I,h);
h=[1 1 1;0 0 0;-1 -1 -1];
I_new_2=imfilter(I,h);
h=[0 1 1;-1 0 1;-1 -1 0];
I_new_3=imfilter(I,h);
h=[1 1 0;1 0 -1;0 -1 -1];
I_new_4=imfilter(I,h);
disp(size(I));
[x,y]=size(I);
for i=1:x
    for j=1:y
        I(i,j)=max([I_new_1(i,j);I_new_2(i,j);I_new_3(i,j);I_new_4(i,j)]);
    end
end
%I=I_new_1+I_new_2+I_new_3+I_new_4;
disp(size(I));
axes(handles.display)
imshow(I)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%laplacian
global I
I=I(:,:,1);
I=im2double(I);


[x,y]=size(I);
new_I_1=zeros(x,y);
for ii=1:x-2
    for jj=1:y-2
        new_I_1(ii,jj)=-1*I(ii,jj)-1*I(ii,jj+1)-1*I(ii,jj+2)-1*I(ii+1,jj)+8*I(ii+1,jj+1)-1*I(ii+1,jj+2)-1*I(ii+2,jj)-1*I(ii+2,jj+1)-1*I(ii+2,jj+2);
   
    end
end

%h=[-1 -1 -1;-1 8 -1;-1 -1 -1];
%I_new_1=imfilter(I,h);
%disp(size(I));
I=I-new_I_1;
%I=I-I_new_1;
disp(size(I));
axes(handles.display)
imshow(I)

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%pyramid - 6 levels
global I
I=I(:,:,1);
I=im2double(I);
global I_0
global I_1
global I_2
global I_3
global I_4
global I_5

%h=[1 4 6 4 1;4 16 24 16 4;6 24 36 24 6;4 16 24 16 4;1 4 6 4 1];
%h=[1 2 1;2 4 2;1 2 1];
%h=[-2.7778 -1.3889 -2.7778;-1.3889 0 -1.3889;-2.7778 -1.3889 -2.7778];
%I_0=imfilter(I,h);
%I_0=I_0/16.0;
%[x,y]=size(I_0);

I_0 = I(1:2:end,1:2:end);
I_1 = I_0(1:2:end,1:2:end);
I_2 = I_1(1:2:end,1:2:end);
I_3 = I_2(1:2:end,1:2:end);
I_4 = I_3(1:2:end,1:2:end);
I_5 = I_4(1:2:end,1:2:end);
axes(handles.display)
imshow(I);



% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%zero order hold
global I_0
global I_1
global I_2
global I_3
global I_4
global I_5
I_0=repelem(I_0,2,2);
I_1=repelem(repelem(I_1,2,2),2,2);
I_2=repelem(repelem(repelem(I_2,2,2),2,2),2,2);
I_3=repelem(repelem(repelem(repelem(I_3,2,2),2,2),2,2),2,2);
I_4=repelem(repelem(repelem(repelem(repelem(I_4,2,2),2,2),2,2),2,2),2,2);
I_5=repelem(repelem(repelem(repelem(repelem(repelem(I_4,2,2),2,2),2,2),2,2),2,2),2,2);

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_0
axes(handles.display)
imshow(I_0);

% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_1
axes(handles.display)
imshow(I_1);

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I_2
axes(handles.display)
imshow(I_2);
% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_3
axes(handles.display)
imshow(I_3);

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_4
axes(handles.display)
imshow(I_4);

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_5
axes(handles.display)
imshow(I_5);


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%pyramid - 6 levels
global I
I=I(:,:,1);
I=im2double(I);
global I_0
global I_1
global I_2
global I_3
global I_4
global I_5

%h=[1 4 6 4 1;4 16 24 16 4;6 24 36 24 6;4 16 24 16 4;1 4 6 4 1];
%h=[1 2 1;2 4 2;1 2 1];
%h=[-2.7778 -1.3889 -2.7778;-1.3889 0 -1.3889;-2.7778 -1.3889 -2.7778];
%I_0=imfilter(I,h);
%I_0=I_0/16.0;
%[x,y]=size(I_0);

I_0 = I(1:2:end,1:2:end);
I_1 = I_0(1:2:end,1:2:end);
I_2 = I_1(1:2:end,1:2:end);
I_3 = I_2(1:2:end,1:2:end);
I_4 = I_3(1:2:end,1:2:end);
I_5 = I_4(1:2:end,1:2:end);
axes(handles.display)
%composite image
Ib = size(I); 
Is = size(I_0); 
new_I=I;
new_I(1,end+Is(2),1) = 0;  
new_I(1:Is(1), Ib(2):Ib(2)+Is(2)-1, :) = I_0;

Ib = size(new_I); 
Is = size(I_1); 
%new_I=new_I;
new_I(1,end+Is(2),1) = 0;  
new_I(1:Is(1), Ib(2):Ib(2)+Is(2)-1, :) = I_1;

Ib = size(new_I); 
Is = size(I_2); 
%new_I=new_I;
new_I(1,end+Is(2),1) = 0;  
new_I(1:Is(1), Ib(2):Ib(2)+Is(2)-1, :) = I_2;

Ib = size(new_I); 
Is = size(I_3); 
%new_I=new_I;
new_I(1,end+Is(2),1) = 0;  
new_I(1:Is(1), Ib(2):Ib(2)+Is(2)-1, :) = I_3;

Ib = size(new_I); 
Is = size(I_4); 
%new_I=new_I;
new_I(1,end+Is(2),1) = 0;  
new_I(1:Is(1), Ib(2):Ib(2)+Is(2)-1, :) = I_4;

Ib = size(new_I); 
Is = size(I_5); 
%new_I=new_I;
new_I(1,end+Is(2),1) = 0;  
new_I(1:Is(1), Ib(2):Ib(2)+Is(2)-1, :) = I_5;
imshow(new_I);

% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%zero order hold
global I_0
global I_1
global I_2
global I_3
global I_4
global I_5
I_0=repelem(I_0,2,2);
I_1=repelem(repelem(I_1,2,2),2,2);
I_2=repelem(repelem(repelem(I_2,2,2),2,2),2,2);
I_3=repelem(repelem(repelem(repelem(I_3,2,2),2,2),2,2),2,2);
I_4=repelem(repelem(repelem(repelem(repelem(I_4,2,2),2,2),2,2),2,2),2,2);
I_5=repelem(repelem(repelem(repelem(repelem(I_5,2,2),2,2),2,2),2,2),2,2);
I_5=repelem(I_5,2,2);
%I_5=repelem(I_4,2,2);

axes(handles.display)
%imshow(I_4);
disp("done");
% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_0
axes(handles.display)
imshow(I_0);

% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I_1
axes(handles.display)
imshow(I_1);
% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_2
axes(handles.display)
imshow(I_2);

% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_3
axes(handles.display)
imshow(I_3);

% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I_4
axes(handles.display)
imshow(I_4);
% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_5
axes(handles.display)
imshow(I_5);
