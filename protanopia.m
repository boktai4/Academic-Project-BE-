function [filename,RGBp,xn] = protanopia(filename)
      %display original image 
figure();
subplot(2,2,1);
imshow(filename);
title('Original image');
%waitbar( 0.25 , 'Loading');
%display image as seen by the colour blind 

lms2lmst = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;


rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;

lms2rgb = inv(rgb2lms) ;



%read picture into RGB value




RGB = double(imread(filename,'png'));

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


RGBp = uint8(RGBp);

%RGBd = uint8(RGBd);
%waitbar( 0.5 , h , 'Loading....');
subplot(2,2,2)
imshow(RGBp);
title('original image as seen by the Color Vision Deficient');


%write to file
imwrite(RGBp,[filename 'p.png'],'png');

% recolouring image 

lms2lmst = [1 0 0; 0.494207 0 1.24827; 0 0 1];
rgb2lms = [17.8824 43.5161 4.1193; 3.4557 27.1554 3.8671; 0.02996 0.18431 1.4670] ;

lms2rgb = inv(rgb2lms) ;


%read picture into RGB value

RGB = double(imread( filename,'png'));

sizeRGB = size(RGB) ;
RGBp=zeros(size(RGB));
xn=zeros(size(RGB));


% read actual picture

RGB1 = imread(filename,'png');

 
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
%waitbar(0.75 , h , 'Loading.....');
xn=uint8(xn);
subplot(2,2,3);
imshow (xn);
title('re-coloured image');
imwrite(xn,[filename 'n1.png'],'png');

%re-coloured image as visible to the CVD 


%read picture into RGB value




RGB = double(imread([filename 'n1.png']));

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


RGBp = uint8(RGBp);

%waitbar(1,h,'Loading......');
%close(h);
subplot(2,2,4)
imshow(RGBp);
title('Re-coloured image as seen by CVD');


%write to file
imwrite(RGBp,[filename 'p.png'],'png');
      
  str = ' You are now viewing the comparitive view'

    
  end
 
 