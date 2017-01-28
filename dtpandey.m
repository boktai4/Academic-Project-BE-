

lmsan=[0.675 0.434 -0.109; 0.125 0.848 0.027; -0.008 0.019 0.989];

RGB=double(imread('New folder/7.png'));

sizeRGB=size(RGB);

RGBp=zeros(size(RGB));
 
for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=RGB(i,j,:);
            
        rgb(:);
        
        if or(and(rgb(1)>rgb(2),rgb(1)>rgb(3)),and(rgb(2)>rgb(1),rgb(2)>rgb(1)))
            
            RGBp(i,j,1)=0.675*RGB(i,j,1)+0.434*RGB(i,j,2)-0.109*RGB(i,j,3);
            
            RGBp(i,j,2)=0.125*RGB(i,j,1)+0.848*RGB(i,j,2)+0.027*RGB(i,j,3);
            
            RGBp(i,j,3)=0.019*RGB(i,j,2)+0.989*RGB(i,j,3)-0.008*RGB(i,j,1);
            
        else
            RGBp(i,j,1)=RGB(i,j,1);
        
            RGBp(i,j,2)=RGB(i,j,2);
        
            RGBp(i,j,3)=RGB(i,j,3);
        end 
    end     
end

RGBp=uint8(RGBp);

imwrite(RGBp,'pandey4.png','png');

%RECOLOURING - to be debugged

Rec=zeros(size(RGB));

for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=RGB(i,j,:);
        
        rgb(:);
        
        if or(and(rgb(1)>rgb(2),rgb(1)>rgb(3)),and(rgb(2)>rgb(1),rgb(2)>rgb(3)))
            
            Rec(i,j,1)=1.6402*RGB(i,j,1)-0.8440*RGB(i,j,2)+0.2038*RGB(i,j,3);
            
            Rec(i,j,2)=1.3047*RGB(i,j,2)-0.2423*RGB(i,j,1)-0.0623*RGB(i,j,3);
            
            Rec(i,j,3)=1.014*RGB(i,j,3)-0.0319*RGB(i,j,2)+0.0179*RGB(i,j,1);
            
        else
            Rec(i,j,1)=RGB(i,j,1);
        
            Rec(i,j,2)=RGB(i,j,2);
        
            Rec(i,j,3)=RGB(i,j,3);
        end 
    end     
end

Rec=uint8(Rec);

imwrite(Rec,'pandey5.png','png');

Sim=zeros(size(Rec));

for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=Rec(i,j,:);
        
        rgb(:);
        
        if or(and(rgb(1)>rgb(2),rgb(1)>rgb(3)),and(rgb(2)>rgb(1),rgb(2)>rgb(1)))
            
            Sim(i,j,1)=0.675*Rec(i,j,1)+0.434*Rec(i,j,2)-0.109*Rec(i,j,3);
            
            Sim(i,j,2)=0.848*Rec(i,j,2)+0.125*Rec(i,j,1)+0.027*Rec(i,j,3);
            
            Sim(i,j,3)=0.989*Rec(i,j,3)+0.019*Rec(i,j,2)-0.008*Rec(i,j,1);
            
        else
            Sim(i,j,1)=Rec(i,j,1);
        
            Sim(i,j,2)=Rec(i,j,2);
        
            Sim(i,j,3)=Rec(i,j,3);
        end 
    end     
end

Sim=uint8(Sim);

imwrite(Sim,'pandey6.png','png');

imshow(Sim);