function varargout = demo1(varargin)
% DEMO1 MATLAB code for demo1.fig
%      DEMO1, by itself, creates a new DEMO1 or raises the existing
%      singleton*.
%
%      H = DEMO1 returns the handle to a new DEMO1 or the handle to
%      the existing singleton*.
%
%      DEMO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO1.M with the given input arguments.
%
%      DEMO1('Property','Value',...) creates a new DEMO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before demo1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to demo1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demo1

% Last Modified by GUIDE v2.5 16-Apr-2015 22:19:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demo1_OpeningFcn, ...
                   'gui_OutputFcn',  @demo1_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT


% --- Executes just before demo1 is made visible.
function demo1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to demo1 (see VARARGIN)

% Choose default command line output for demo1
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('bluetheme.png'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demo1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end
% --- Outputs from this function are returned to the command line.
function varargout = demo1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end
% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.png' , 'Pick any png file');
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      s = '.png';
      ch = strcmp(s,ext);
  if isequal(filename,0) || isequal(pathname,0)
      h = msgbox('User pressed cancel');
  else if isequal(ch,0)
          h= msgbox('Invalid INPUT');
  else
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      
      h=waitbar(0,'Please wait..');

      lms2lmsp = [0 2.02344 -2.53581; 0 1 0; 0 0 1] ;

%lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

%lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;

rgb2lms = [17.8824 43.5161 4.1193; 3.4557 27.1554 3.8671; 0.02996 0.18431 1.4670] ;

lms2rgb = inv(rgb2lms) ;


%read picture into RGB value

RGB = double(imread( file_name,'png'));

sizeRGB = size(RGB) ;
RGBp=zeros(size(RGB));
xn=zeros(size(RGB));


% read actual picture

RGB1 = imread(file_name,'png');

 
 %transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
             
LMSp(i,j,:) = lms2lmsp * lms;
        
end

end



%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);
     
     RGBp(i,j,:) = lms2rgb * lmsp;
  end

end
   

% Step 1 : Separating CBU and CBP

TV=[33; 33; 33]; %Random values can change ltr

for i= 1:sizeRGB(1);
   for j= 1:sizeRGB(2);
        
        xo = RGB (i,j,:);
        xo = xo(:); % xo denotes pixel of original image
        %TV=[0.1*xo(1); 0.1*xo(2); 0.1*xo(3)];
        
        xd = RGBp(i,j,:);
        xd = xd(:); % xd denotes pixel of simulated image
        
        if and (xo(1)>xo(2),xo(1)>xo(3))
             dx=1;
        else
            dx=0;
        end
        
        if and (and ( abs(xo(1)-xd(1))<TV(1), abs(xo(2)-xd(2))<TV(2)), abs(xo(3)-xd(3))<TV(3))
            px=1;
        else
            px=0;
        end
        
        if and(dx==1,px==0)
            O(i,j)=1; % CBU
        else
            O(i,j)=0; % CBP
        end
    end
end
%imshow (O);


% Step 2 : Global colour rotation

for i= 1:sizeRGB(1);
    for j= 1:sizeRGB(2);
        
       if (O(i,j)==1) % CBU
           
        xo = RGB(i,j,:);
        xo = xo(:); % xo denotes pixel of original image
      
        
        xd = RGBp(i,j,:);
        xd = xd(:); % xd denotes pixel of simulated image
        
        w = abs(xo(1)-xd(1))+abs(xo(2)-xd(2))+abs(xo(3)-xd(3)); % w is directly proportional to rotation angle
        
        %TRY
        w=degtorad(w);
        
        a = 0.017;
        b = 1.182; % a and b are constants (which are to be varied)
        
        %a=0.015;
        %b=0.017;
        
        v= atan(xo(3)/sqrt(xo(1)^2+xo(2)^2 ));
        
        
        r = ((pi/2)+v)/2; % variable value of r surrently set to average of pi/2 and v
        
        
        tg = (w+b)*r*a;
       
      
        q0 = 2*cos(tg/2);
        q1 = 2*sin(tg/2)*cos(degtorad(xo(1)));
        q2 = sin(tg/2)*cos(degtorad(xo(2)));
        q3 = sin(tg/2)*cos(degtorad(xo(3)));
        
        p = [(2*(q2^2+q3^2)) 2*(q1*q2-q0*q3) 2*(q0*q2+q1*q3) ; 
             0.5+2*(q1*q2+q0*q3) 1-(2*(q1^2+q3^2)) 2*(q2*q3-q0*q1) ; 
             0.5+2*(q1*q3-q0*q2) 2*(q0*q1+q2*q3) 1-(2*(q1^2+q2^2))];
            
        
        temp = p*(xo-xd) + xo
 
        
        xn(i,j,1)=temp(1);
        xn(i,j,2)=temp(2);
        xn(i,j,3)=temp(3);
        
       else 
        xn(i,j,1)=RGB1(i,j,1);
        xn(i,j,2)=RGB1(i,j,2);
        xn(i,j,3)=RGB1(i,j,3); 
       end  
        
    end
    
    waitbar(i/sizeRGB(1) , h , 'Loading...');
  
end
close(h);
xn=uint8(xn);
imshow (xn);
imwrite(xn,[file_name 'n1.png'],'png');
str = ' You are now viewing the Re-Coloured Image'
set(handles.text3,'String',str);

      
      %imshow(a);
      end
  end
end

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

end
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

end
% --- Executes on button press in browseforvideo.
function browseforvideo_Callback(hObject, eventdata, handles)
% hObject    handle to browseforvideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cd('D:\My Drive\Downloads\video_code-2016-03-27\video code\trial\triAL');
[file_name,pathname] = uigetfile('*.avi' , 'Pick a video');
if isequal(file_name,0) || isequal(pathname,0)
      h = msgbox('User pressed cancel');
else 
      mov = VideoReader(fullfile(pathname,file_name));
      get(mov);
     filename=mov.name;
      [pathstr,name,ext] = fileparts(filename);
      s1='.avi';
      
      ch=strcmpi(s1,ext);
    if isequal(ch,0)
          h = msgbox('INVALID INPUT');
    else
     
        mov = VideoReader(fullfile(pathname,file_name));
%extract audio from video and save 

 cd('D:\video code\trial\triAL');

file = mov.name;
 file1 = 'audiofiledemo.wav';
 hmfr=video.MultimediaFileReader(file,'AudioOutputPort',true,'VideoOutputPort',false);
 hmfw = video.MultimediaFileWriter(file1,'AudioInputPort',true,'VideoInputPort',false,'FileFormat','WAV');
 while ~isDone(hmfr)
      audioFrame = step(hmfr);
      %step(hmfw,audioFrame);
 end
 close(hmfw);
 close(hmfr);
 audio_samples = wavread(file1);
    


% Open an sample avi file

%filename = 'file_name';
%mov = VideoReader(filename);

% Output folder

outputFolder = fullfile(cd, 'frames');
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%getting no of frames
 h = waitbar(0 , 'Loading');
numberOfFrames = mov.NumberOfFrames;
numberOfFramesWritten = 0;
for frame = 1 : numberOfFrames    
    thisFrame = read(mov, frame);
    outputBaseFileName = sprintf('%3.3d.png', frame);
    outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    imwrite(thisFrame, outputFullFileName, 'png');
    progressIndication = sprintf('Wrote frame %4d of %d.', frame,numberOfFrames);
    disp(progressIndication);
    numberOfFramesWritten = numberOfFramesWritten + 1;
    waitbar( frame/numberOfFrames , h, 'Loading frames');
end
progressIndication = sprintf('Wrote %d frames to folder "%s"',numberOfFramesWritten, outputFolder);
disp(progressIndication);
close(h);

outputFolder = fullfile(cd, 'Rframes');
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%Make the Below path as the Current Folder
cd('D:\video code\trial\triAL\frames');

%Obtain all the PNG format files in the current folder
Files = dir('*.png');


%Number of png Files in the current folder
NumFiles= size(Files,1);
h=waitbar(0,'Please wait..');


        
for m = 1 : NumFiles
   
    cd('D:\video code\trial\triAL\frames');
   %Read the Image from the current Folder
   I = imread(Files(m).name);

%NumberOfimages=599;       %chose the number of images you want to give input
%prefix_image='001';    %change the desired input image name here only       %change the desired input image format here only

%for num=1:NumberOfimages
  %image = imread(prefix_image);
  
  %for a = 1:599
   %filename = ['001' num2str(a,'%02d') '.png'];
   %img = imread(filename);
   % do something with img
%end
  

%file_name = 'I' ;

%transorm matrices

%{
lms2lmsp = [0 2.02344 -2.53581; 0 1 0; 0 0 1] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;

rgb2lms = [17.8824 43.5161 4.1193; 3.4557 27.1554 3.8671; 0.02996 0.18431 1.4670] ;

lms2rgb = inv(rgb2lms) ;
%}

%lms2lmsp = [0.458 0.680 0.138; 0.093 0.846 0.061; 0.007 0.017 1.024] ;

lms2lmsp = [0.458 0.680 0.138; 0.093 0.846 0.061; 0.007 0.017 1.024] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;

rgb2lms = [17.8824 43.5161 4.1193; 3.4557 27.1554 3.8671; 0.02996 0.18431 1.4670] ;

lms2rgb = inv(rgb2lms) ;


%read picture into RGB value

RGB = double(imread((Files(m).name),'png'));

sizeRGB = size(RGB) ;
%xn=zeros(size(RGB));


% read actual picture

RGB1 = imread((Files(m).name),'png');
if (m>1)
    prev = double(imread(Files(m-1).name));
    prev1 = imread(Files(m).name);
end


%transform to LMS space

     for i = 1:sizeRGB(1)
        for j = 1:sizeRGB(2)
          rgb = RGB(i,j,:);
          rgb = rgb(:);
          LMS(i,j,:) = rgb2lms * rgb;
        end
     end

      %transform to colorblind LMS values
       
      for i = 1:sizeRGB(1)
         for j = 1:sizeRGB(2)
          lms = LMS(i,j,:);
          lms = lms(:);
          LMSp(i,j,:) = lms2lmsp * lms;
         end
      end
      
      %transform new LMS value to RGB values

         for i = 1:sizeRGB(1)
            for j = 1:sizeRGB(2)
             lmsp = LMSp(i,j,:);
             lmsp = lmsp(:);
             RGBp(i,j,:) = lms2rgb * lmsp;
            end
         end
    
       % Separating CBU and CBP

         TV=[33; 33; 33]; 

         for i= 1:sizeRGB(1);
            for j= 1:sizeRGB(2);
        
             xo = RGB (i,j,:);
             xo = xo(:); % xo denotes pixel of original image
        
             xd = RGBp(i,j,:);
             xd = xd(:); % xd denotes pixel of simulated image
        
             if and (xo(1)>xo(2),xo(1)>xo(3))
               dx=1;
             else
               dx=0;
             end
        
            if and (and ( abs(xo(1)-xd(1))<TV(1), abs(xo(2)-xd(2))<TV(2)), abs(xo(3)-xd(3))<TV(3))
              px=1;
            else
              px=0;
            end
        
            if and(dx==1,px==0)
              O(i,j)=1; % CBU
            else
              O(i,j)=0; % CBP
            end
            end
         end
         
         % Recolouring
         
   
         for i= 1:sizeRGB(1);
           for j= 1:sizeRGB(2);
               
             xo = RGB (i,j,:);
             xo = xo(:); % xo denotes pixel of original image
        
             xd = RGBp(i,j,:);
             xd = xd(:); % xd denotes pixel of simulated image
        
             
             if (m>1)
             xp = prev (i,j,:);
             xp = xp(:);
             end
             
        
            if (O(i,j)==1) % CBU
                
                if (m==1)
                    [R,G,B]=spat(xo,xd);
                    xn(i,j,1)= R;
                    xn(i,j,2)= G;
                    xn(i,j,3)= B;
                   
               
                elseif and (and(xo(1)==xp(1),xo(2)==xp(2)), xo(3)==xp(3))
                    xn(i,j,1)=xp1(i,j,1);
                    xn(i,j,2)=xp1(i,j,2);
                    xn(i,j,3)=xp1(i,j,3); 
                   
        
                  
                %{
elseif ((abs(xo(1)-xp(1))+abs(xo(2)-xp(2))+abs(xo(3)-xp(3)))<5)%and(and(abs(xo(1)-xp(1))<5,abs(xo(2)-xp(2))<5), abs(xo(3)-xp(3))<5)  
                    [R,G,B]=tem(RGB,prev,xp1,sizeRGB,i,j);
                    xn(i,j,1)=xp1(i,j,1);
                    xn(i,j,2)=xp1(i,j,2);
                    xn(i,j,3)=xp1(i,j,3);
                    %} 

                      %{
                elseif and(and(abs(xo(1)-xp(1))<20,abs(xo(2)-xp(2))<20), abs(xo(3)-xp(3))<20) % condition for temporal recolouring 
                    [R,G,B]=tem (RGB,prev,xp1,sizeRGB,i,j);
                    xn(i,j,1)= R;
                    xn(i,j,2)= G;
                    xn(i,j,3)= B;
   
                    %}
             
                else %if ((abs(xo(1)-xp(1))+abs(xo(2)-xp(2))+abs(xo(3)-xp(3)))>=5)%and(and(abs(xo(1)-xp(1))>=5,abs(xo(2)-xp(2))>=5), abs(xo(3)-xp(3))>=5) % condition for spatial recolouring
                   [R,G,B]=spat(xo,xd);
                    xn(i,j,1)= R;
                    xn(i,j,2)= G;
                    xn(i,j,3)= B; 
                end
             
            elseif (O(i,j)==0)
                xn(i,j,1)=RGB1(i,j,1);
                xn(i,j,2)=RGB1(i,j,2);
                xn(i,j,3)=RGB1(i,j,3);
          
            end   
            
           end
         end
         
         xp1=xn;
         xn =uint8(xn);
         m

 
 
cd('D:\video code\trial\triAL\Rframes');

imwrite(xn,[(Files(m).name) 'n1.png'],'png');

waitbar(m/NumFiles , h);




end
    
close (h);

m = msgbox('kindly wait till your video is loaded');

h=waitbar(0,'Please wait..');
    

%Make the Below path as the Current Folder
cd('D:\video code\trial\triAL\Rframes');

%Obtain all the JPEG format files in the current folder
Files = dir('*.png');

%Number of JPEG Files in the current folder
NumFiles= size(Files,1);


%To write Video File
VideoObj = VideoWriter('Create_VideoRC.avi');
%Number of Frames per Second
VideoObj.FrameRate = 29; 
%Define the Video Quality [ 0 to 100 ]
VideoObj.Quality   = 100;  

%Open the File 'Create_video01.avi'
open(VideoObj);

for i = 1 : NumFiles
   
   %Read the Image from the current Folder
   I = imread(Files(i).name);
   %figure();
 %imshow(I); 
   
   %Convert Image to movie Frame
   frame = im2frame(I);
    waitbar(i/NumFiles , h , 'Loading...');
  
   
     
          %Write a frame
          writeVideo(VideoObj, frame);
end
    %end
    close(VideoObj);
 


    
%Close the File 'Create_Video01.avi
 close(h);
 y = msgbox('PROCESS COMPLETED');
    end
    
end

    end


% --- Executes on button press in videoseenbyCVD.
function videoseenbyCVD_Callback(hObject, eventdata, handles)
% hObject    handle to videoseenbyCVD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Make the Below path as the Current Folder
cd('D:\video code\trial\triAL\frames');

%Obtain all the JPEG format files in the current folder
Files = dir('*.png');


outputFolder = fullfile(cd, 'dframes');
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end


NumFiles= size(Files,1);
 h = waitbar ( 0 , 'Please wait');
for m = 1 : NumFiles
   
    cd('D:\video code\trial\triAL\frames');
   %Read the Image from the current Folder
   I = imread(Files(m).name);

%file_name = 'grandparents' ;

%transorm matrices

lms2lmsp = [0 2.02344 -2.52581; 0 1 0; 0 0 1] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;


rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;

lms2rgb = inv(rgb2lms) ;



%read picture into RGB value




RGB = double(imread((Files(m).name),'png'));

sizeRGB = size(RGB) ;


%transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
        
        
LMSp(i,j,:) = lms2lmsp * lms;
       
LMSd(i,j,:) = lms2lmsd * lms;
   
end

end


%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);

    
     lmsd = LMSd(i,j,:);
      
     lmsd = lmsd(:);

       
     RGBp(i,j,:) = lms2rgb * lmsp;
       
     RGBd(i,j,:) = lms2rgb * lmsd;
      
   
     end

     end


RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);

cd('D:\video code\trial\triAL\dframes');

imwrite(RGBp,[(Files(m).name) 'n1.png'],'png');



waitbar(m/NumFiles,h,'Loading...');
end
close(h);
m = msgbox('Please wait while your video loads');
h = waitbar (0,'Loading');
%Make the Below path as the Current Folder
cd('D:\video code\trial\triAL\dframes');

%Obtain all the JPEG format files in the current folder
Files = dir('*.png');

%Number of JPEG Files in the current folder
NumFiles= size(Files,1);


%To write Video File
VideoObj = VideoWriter('VideoseenbyCVD.avi');
%Number of Frames per Second
VideoObj.FrameRate = 29; 
%Define the Video Quality [ 0 to 100 ]
VideoObj.Quality   = 100;  

%Open the File 'Create_video01.avi'
open(VideoObj);

for i = 1 : NumFiles
   
   %Read the Image from the current Folder
   I = imread(Files(i).name);
   %figure();
 %imshow(I); 
   
   %Convert Image to movie Frame
   frame = im2frame(I);
   
  
   waitbar(i/NumFiles,h,'Loading...');
     
          %Write a frame
          writeVideo(VideoObj, frame);
end
close(h);
 %Close the File 'Create_Video01.avi
close(VideoObj);
 
m = msgbox('process completed');




end
% --- Executes on button press in recoloredvideoseenbyCVD.
function recoloredvideoseenbyCVD_Callback(hObject, eventdata, handles)
% hObject    handle to recoloredvideoseenbyCVD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Make the Below path as the Current Folder
cd('D:\video code\trial\triAL\Rframes');

%Obtain all the JPEG format files in the current folder
Files = dir('*.png');


outputFolder = fullfile(cd, 'prcframes');
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%Number of JPEG Files in the current folder
NumFiles= size(Files,1);

h = waitbar(0,'Please wait...');
for m = 1 : NumFiles
   
    cd('D:\video code\trial\triAL\Rframes');
   %Read the Image from the current Folder
   I = imread(Files(m).name);

%file_name = 'grandparents' ;

%transorm matrices

lms2lmsp = [0 2.02344 -2.52581; 0 1 0; 0 0 1] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;

rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;

lms2rgb = inv(rgb2lms) ;



%read picture into RGB value




RGB = double(imread((Files(m).name),'png'));

sizeRGB = size(RGB) ;


%transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
        
        
LMSp(i,j,:) = lms2lmsp * lms;
       
LMSd(i,j,:) = lms2lmsd * lms;
   
end

end


%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);

    
     lmsd = LMSd(i,j,:);
      
     lmsd = lmsd(:);

       
     RGBp(i,j,:) = lms2rgb * lmsp;
       
     RGBd(i,j,:) = lms2rgb * lmsd;
      
   
     end

     end



RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);

cd('D:\video code\trial\triAL\prcframes');

imwrite(RGBp,[(Files(m).name) 'n1.png'],'png');
 waitbar(m/NumFiles , h , 'Loading...');
end

m = msgbox ('Please wait while your video loads');
h= waitbar(0,'please wait..');
%Make the Below path as the Current Folder
cd('D:\video code\trial\triAL\prcframes');

%Obtain all the JPEG format files in the current folder
Files = dir('*.png');

%Number of JPEG Files in the current folder
NumFiles= size(Files,1);


%To write Video File
VideoObj = VideoWriter('RecolouredVideoseenbyCVD.avi');
%Number of Frames per Second
VideoObj.FrameRate = 29; 
%Define the Video Quality [ 0 to 100 ]
VideoObj.Quality   = 100;  

%Open the File 'Create_video01.avi'
open(VideoObj);

for i = 1 : NumFiles
   
   %Read the Image from the current Folder
   I = imread(Files(i).name);
   %figure();
 %imshow(I); 
   
   %Convert Image to movie Frame
   frame = im2frame(I);
   
waitbar(i/NumFiles , h , 'Loading...');  
   
     
          %Write a frame
          writeVideo(VideoObj, frame);
end
 


close(h);
%Close the File 'Create_Video01.avi
close(VideoObj);
 m = msgbox('process completed');
end 

% --- Executes on button press in imgseenbyCVD.
function imgseenbyCVD_Callback(hObject, eventdata, handles)
% hObject    handle to imgseenbyCVD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.png' , 'Pick any png file');
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      s = '.png';
      ch = strcmp(s,ext);
  if isequal(filename,0) || isequal(pathname,0)
      h = msgbox('User pressed cancel');
  else if isequal(ch,0)
          h= msgbox('Invalid INPUT');
  else
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      
      %file_name = 'grandparents' ;
h = waitbar(0,'please wait...');
%transorm matrices

lms2lmsp = [0 2.02344 -2.52581; 0 1 0; 0 0 1] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;


rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;

lms2rgb = inv(rgb2lms) ;



%read picture into RGB value




RGB = double(imread(file_name,'png'));

sizeRGB = size(RGB) ;


%transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
        
        
LMSp(i,j,:) = lms2lmsp * lms;
       
LMSd(i,j,:) = lms2lmsd * lms;
   
end

end


%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);

    
     lmsd = LMSd(i,j,:);
      
     lmsd = lmsd(:);

       
     RGBp(i,j,:) = lms2rgb * lmsp;
       
     RGBd(i,j,:) = lms2rgb * lmsd;
      
   
     end
waitbar(i/sizeRGB(1),h,'Loading');
     end
close(h);

RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);

imwrite(RGBp,[filename 'n1.png'],'png');
imshow(RGBp);
str = ' You are now viewing the original Image as seen by the CVD'
set(handles.text3,'String',str);





  end
  end
end

      
      


% --- Executes on button press in recoloredimgseenbyCVD.
function recoloredimgseenbyCVD_Callback(hObject, eventdata, handles)
% hObject    handle to recoloredimgseenbyCVD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.png' , 'Pick any png file');
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      s = '.png';
      ch = strcmp(s,ext);
  if isequal(filename,0) || isequal(pathname,0)
      h = msgbox('User pressed cancel');
  else if isequal(ch,0)
          h= msgbox('Invalid INPUT. Select a PNG file');
  else
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      
      h = waitbar( 0 , 'Please wait....');
%transorm matrices

lms2lmsp = [0 2.02344 -2.52581; 0 1 0; 0 0 1] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;


rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;

lms2rgb = inv(rgb2lms) ;



%read picture into RGB value




RGB = double(imread(file_name,'png'));

sizeRGB = size(RGB) ;


%transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
        
        
LMSp(i,j,:) = lms2lmsp * lms;
       
LMSd(i,j,:) = lms2lmsd * lms;
   
end

end


%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);

    
     lmsd = LMSd(i,j,:);
      
     lmsd = lmsd(:);

       
     RGBp(i,j,:) = lms2rgb * lmsp;
       
     RGBd(i,j,:) = lms2rgb * lmsd;
      
   
 end
waitbar(i/sizeRGB(1),h,'Loading...');
 end


close(h);


%dtnp = ERR + RGB;
    

%convert to uint8
%dtnp = uint8(dtnp);

%ERR = uint8(ERR);
%errorp = uint8(errorp);

%errord = uint8(errord);
RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);

imshow(RGBp);
%write to file
imwrite(RGBp,[file_name 'p.png'],'png');
str = ' You are now viewing the Re-Coloured Image as viewed by the CVD'
set(handles.text3,'String',str);


%imwrite(RGBd,[file_name 'd.jpeg'],'jpeg');

%imwrite(ERR,[file_name 'err.jpeg'],'jpeg');

%imwrite(errorp,[file_name 'errp.jpeg'],'jpeg');

%imwrite(errord,[file_name 'errd.jpeg'],'jpeg');
%imwrite(dtnp,[file_name '_dtn.jpeg'],'jpeg');

  end
  end
end


% --- Executes on button press in comparitiveview.
function comparitiveview_Callback(hObject, eventdata, handles)
% hObject    handle to comparitiveview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.png' , 'Pick any png file');
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
      s = '.png';
      ch = strcmp(s,ext);
  if isequal(filename,0) || isequal(pathname,0)
      h = msgbox('User pressed cancel');
  else if isequal(ch,0)
          h= msgbox('Invalid INPUT');
  else
      file_name=strcat(pathname,filename);
      %a=imread(filename);
      [pathstr,name,ext] = fileparts(file_name);
h = waitbar( 0 , 'Please wait...');
      %display original image 
figure();
subplot(2,2,1);
imshow(file_name);
title('Original image');
waitbar( 0.25 , h , 'Loading');
%display image as seen by the colour blind 

lms2lmsp = [0 2.02344 -2.52581; 0 1 0; 0 0 1] ;

lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;


rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;

lms2rgb = inv(rgb2lms) ;



%read picture into RGB value




RGB = double(imread(file_name,'png'));

sizeRGB = size(RGB) ;


%transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
        
        
LMSp(i,j,:) = lms2lmsp * lms;
       
LMSd(i,j,:) = lms2lmsd * lms;
   
end

end


%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);

    
     lmsd = LMSd(i,j,:);
      
     lmsd = lmsd(:);

       
     RGBp(i,j,:) = lms2rgb * lmsp;
       
     RGBd(i,j,:) = lms2rgb * lmsd;
      
   
     end

     end


RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);
waitbar( 0.5 , h , 'Loading....');
subplot(2,2,2)
imshow(RGBp);
title('original image as seen by the Color Vision Deficient');


%write to file
imwrite(RGBp,[filename 'p.png'],'png');

% recolouring image 

lms2lmsp = [0 2.02344 -2.53581; 0 1 0; 0 0 1] ;

%lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;

%lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;

rgb2lms = [17.8824 43.5161 4.1193; 3.4557 27.1554 3.8671; 0.02996 0.18431 1.4670] ;

lms2rgb = inv(rgb2lms) ;


%read picture into RGB value

RGB = double(imread( file_name,'png'));

sizeRGB = size(RGB) ;
RGBp=zeros(size(RGB));
xn=zeros(size(RGB));


% read actual picture

RGB1 = imread(file_name,'png');

 
 %transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
             
LMSp(i,j,:) = lms2lmsp * lms;
        
end

end



%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);
     
     RGBp(i,j,:) = lms2rgb * lmsp;
  end

end
   

% Step 1 : Separating CBU and CBP

TV=[33; 33; 33]; %Random values can change ltr

for i= 1:sizeRGB(1);
   for j= 1:sizeRGB(2);
        
        xo = RGB (i,j,:);
        xo = xo(:); % xo denotes pixel of original image
        %TV=[0.1*xo(1); 0.1*xo(2); 0.1*xo(3)];
        
        xd = RGBp(i,j,:);
        xd = xd(:); % xd denotes pixel of simulated image
        
        if and (xo(1)>xo(2),xo(1)>xo(3))
             dx=1;
        else
            dx=0;
        end
        
        if and (and ( abs(xo(1)-xd(1))<TV(1), abs(xo(2)-xd(2))<TV(2)), abs(xo(3)-xd(3))<TV(3))
            px=1;
        else
            px=0;
        end
        
        if and(dx==1,px==0)
            O(i,j)=1; % CBU
        else
            O(i,j)=0; % CBP
        end
    end
end
%imshow (O);


% Step 2 : Global colour rotation

for i= 1:sizeRGB(1);
    for j= 1:sizeRGB(2);
        
       if (O(i,j)==1) % CBU
           
        xo = RGB(i,j,:);
        xo = xo(:); % xo denotes pixel of original image
      
        
        xd = RGBp(i,j,:);
        xd = xd(:); % xd denotes pixel of simulated image
        
        w = abs(xo(1)-xd(1))+abs(xo(2)-xd(2))+abs(xo(3)-xd(3)); % w is directly proportional to rotation angle
        
        %TRY
        w=degtorad(w);
        
        a = 0.017;
        b = 1.182; % a and b are constants (which are to be varied)
        
        %a=0.015;
        %b=0.017;
        
        v= atan(xo(3)/sqrt(xo(1)^2+xo(2)^2 ));
        
        
        r = ((pi/2)+v)/2; % variable value of r surrently set to average of pi/2 and v
        
        
        tg = (w+b)*r*a;
       
      
        q0 = 2*cos(tg/2);
        q1 = 2*sin(tg/2)*cos(degtorad(xo(1)));
        q2 = sin(tg/2)*cos(degtorad(xo(2)));
        q3 = sin(tg/2)*cos(degtorad(xo(3)));
        
        p = [(2*(q2^2+q3^2)) 2*(q1*q2-q0*q3) 2*(q0*q2+q1*q3) ; 
             0.5+2*(q1*q2+q0*q3) 1-(2*(q1^2+q3^2)) 2*(q2*q3-q0*q1) ; 
             0.5+2*(q1*q3-q0*q2) 2*(q0*q1+q2*q3) 1-(2*(q1^2+q2^2))];
            
        
        temp = p*(xo-xd) + xo
 
        
        xn(i,j,1)=temp(1);
        xn(i,j,2)=temp(2);
        xn(i,j,3)=temp(3);
        
       else 
        xn(i,j,1)=RGB1(i,j,1);
        xn(i,j,2)=RGB1(i,j,2);
        xn(i,j,3)=RGB1(i,j,3); 
       end  
        
    end
end
waitbar(0.75 , h , 'Loading.....');
xn=uint8(xn);
subplot(2,2,3);
imshow (xn);
title('re-coloured image');
imwrite(xn,[file_name 'n1.png'],'png');

%re-coloured image as visible to the CVD 


%read picture into RGB value




RGB = double(imread([file_name 'n1.png']));

sizeRGB = size(RGB) ;


%transform to LMS space

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
       
rgb = RGB(i,j,:);
        
rgb = rgb(:);
        
        
LMS(i,j,:) = rgb2lms * rgb;
    
end

end


%transform to colorblind LMS values

for i = 1:sizeRGB(1)
    
for j = 1:sizeRGB(2)
        
lms = LMS(i,j,:);
        
lms = lms(:);
        
        
LMSp(i,j,:) = lms2lmsp * lms;
       
LMSd(i,j,:) = lms2lmsd * lms;
   
end

end


%transform new LMS value to RGB values

for i = 1:sizeRGB(1)
  
  for j = 1:sizeRGB(2)
   
     lmsp = LMSp(i,j,:);
   
     lmsp = lmsp(:);

    
     lmsd = LMSd(i,j,:);
      
     lmsd = lmsd(:);

       
     RGBp(i,j,:) = lms2rgb * lmsp;
       
     RGBd(i,j,:) = lms2rgb * lmsd;
      
   
     end

     end


RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);
waitbar(1,h,'Loading......');
close(h);
subplot(2,2,4)
imshow(RGBp);
title('Re-coloured image as seen by CVD');


%write to file
imwrite(RGBp,[file_name 'p.png'],'png');
      %imshow(a);
  str = ' You are now viewing the comparitive view'
set(handles.text3,'String',str);
    
  end
  end
end


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%cla(handles.axes1);
cla(handles.axes1,'reset'); 
set(handles.axes1,'YTick',NaN); 
set(handles.axes1,'XTick',NaN); 
set(handles.axes1,'XColor','white'); 
set(handles.axes1,'YColor','white')
set(handles.text3, 'String', '');
end
