function [RGBog,Rec,Sim] = imgtri(filename)

lmsan=[1.256 -0.077 -0.179; -0.078 0.931 0.148; 0.005 0.693 0.304];

var=0;

RGB=double(imread(filename));
sizeRGB=size(RGB);



% Recolouring

Rec=zeros(size(RGB));

for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=RGB(i,j,:);
        
           if (and(rgb(3)>rgb(1)+33,rgb(3)>rgb(2)+33))
            
            Rec(i,j,1)=0.7670*RGB(i,j,1)-0.4277*RGB(i,j,2)+0.6599*RGB(i,j,3);
            
            Rec(i,j,2)=1.6266*RGB(i,j,2)+0.0139*RGB(i,j,1)-0.7307*RGB(i,j,3);
            
            Rec(i,j,3)=4.9444*RGB(i,j,3)-3.7010*RGB(i,j,2)-0.2495*RGB(i,j,1);
            
        else
            Rec(i,j,1)=RGB(i,j,1);
        
            Rec(i,j,2)=RGB(i,j,2);
        
            Rec(i,j,3)=RGB(i,j,3);
        end 
    end     
end

Rec=uint8(Rec);

imwrite(Rec,'rec.png','png');
subplot(2,2,3);
imshow(Rec);
Sim=zeros(size(Rec));

for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=Rec(i,j,:);

        rgb=rgb(:);
        
           if or(and(rgb(1)>rgb(2)+var,rgb(1)>rgb(3)+var),and(rgb(2)>rgb(1)+var,rgb(2)>rgb(1)+var))
            
            Sim(i,j,1)=1.256*Rec(i,j,1)-0.077*Rec(i,j,2)-0.179*Rec(i,j,3);
      
            Sim(i,j,2)=0.931*Rec(i,j,2)-0.078*Rec(i,j,1)+0.148*Rec(i,j,3);
            
            Sim(i,j,3)=0.304*Rec(i,j,3)+0.693*Rec(i,j,2)-0.005*Rec(i,j,1);
            
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


Rec=uint8(Rec);
imwrite(Rec,'rec.png','png');
subplot(2,2,3);
imshow(Rec);

Sim=uint8(Sim);
imwrite(Sim,'rs.png','png');
subplot(2,2,4);
imshow(Sim);
