%function [RGBog,RGBp,Rec,Sim] = imgprotanopia(filename)
lmsan=[0.152 1.053 -0.205;0.115 0.786 0.099;-0.004 -0.048 1.052];

var=170;

RGB=double(imread('New folder/8.png'));
sizeRGB=size(RGB);

RGBp=zeros(size(RGB));
 
for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=RGB(i,j,:);
        
        rgb(:);

          if (and(rgb(1)>rgb(2)+var,rgb(1)>rgb(3)+var))
                
            RGBp(i,j,1)=0.152*RGB(i,j,1)+1.053*RGB(i,j,2)-0.205*RGB(i,j,3);
            
            RGBp(i,j,2)=0.115*RGB(i,j,1)+0.786*RGB(i,j,2)+0.099*RGB(i,j,3);
            
            RGBp(i,j,3)=-0.004*RGB(i,j,1)-0.048*RGB(i,j,2)+1.052*RGB(i,j,3);
            
        else
            RGBp(i,j,1)=RGB(i,j,1);
        
            RGBp(i,j,2)=RGB(i,j,2);
        
            RGBp(i,j,3)=RGB(i,j,3);
        end 
    end     
end


% Recolouring

Rec=zeros(size(RGB));

for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=RGB(i,j,:);
        
           if or(and(rgb(1)>rgb(2),rgb(1)>rgb(3)),and(rgb(2)>rgb(1),rgb(2)>rgb(3)))
            
            Rec(i,j,1)=-0.0989*RGB(i,j,1)+1.1999*RGB(i,j,2)-0.2900*RGB(i,j,3);
            
            Rec(i,j,2)=0.1327*RGB(i,j,1)-0.1739*RGB(i,j,2)+0.0422*RGB(i,j,3);
            
            Rec(i,j,3)=0.0026*RGB(i,j,1)-0.0034*RGB(i,j,2)+0.0018*RGB(i,j,3);
            
        else
            Rec(i,j,1)=RGB(i,j,1);
        
            Rec(i,j,2)=RGB(i,j,2);
        
            Rec(i,j,3)=RGB(i,j,3);
        end 
    end     
end


Sim=zeros(size(Rec));

for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=Rec(i,j,:);

        rgb=rgb(:);
        
           if or(and(rgb(1)>rgb(2),rgb(1)>rgb(3)),and(rgb(2)>rgb(1),rgb(2)>rgb(3)))
            
            Sim(i,j,1)=0.152*Rec(i,j,1)+1.053*Rec(i,j,2)-0.205*Rec(i,j,3);
      
            Sim(i,j,2)=0.115*Rec(i,j,1)+0.786*Rec(i,j,2)+0.099*Rec(i,j,3);
            
            Sim(i,j,3)=-0.004*Rec(i,j,1)-0.048*Rec(i,j,2)+1.052*Rec(i,j,3);
            
        else
            Sim(i,j,1)=Rec(i,j,1);
        
            Sim(i,j,2)=Rec(i,j,2);
        
            Sim(i,j,3)=Rec(i,j,3);
        end 
    end     
end


RGBog=uint8(RGB);
subplot(2,2,1);
imshow(RGBog);

RGBp=uint8(RGBp);
imwrite(RGBp,'rgbp.png','png');
subplot(2,2,2);
imshow(RGBp);

Rec=uint8(Rec);
imwrite(Rec,'rec.png','png');
subplot(2,2,3);
imshow(Rec);

Sim=uint8(Sim);
imwrite(Sim,'rs.png','png');
subplot(2,2,4);
imshow(Sim);
