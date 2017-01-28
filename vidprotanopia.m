function vidprotanopia(file_name)
 
        mov = VideoReader(file_name);
%extract audio from video and save 

 cd('D:\video code\trial\triAL');

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

lms2lmst = [0 2.02344 -2.53581; 0 1 0; 0 0 1] ;


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
          LMSp(i,j,:) = lms2lmst * lms;
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
        
             if and (xo(3)>xo(1),xo(3)>xo(2))
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
    
