function [RGBog,RGBp,Rec,Sim] = dt(filename)
lmsan=[0.593 0.579 -0.118; 0.083 0.866 0.051; -0.007 -0.012 1.019];

var=0;

RGB=double(imread(filename));
sizeRGB=size(RGB);

RGBp=zeros(size(RGB));
 
for i=1:sizeRGB(1)
    for j=1:sizeRGB(2)
        
        rgb=RGB(i,j,:);
        
        rgb(:);

          if or(and(rgb(1)>rgb(2)+var,rgb(1)>rgb(3)+var),and(rgb(2)>rgb(1)+var,rgb(2)>rgb(3)+var))
                
            RGBp(i,j,1)=0.593*RGB(i,j,1)+0.579*RGB(i,j,2)-0.118*RGB(i,j,3);
            
            RGBp(i,j,2)=0.083*RGB(i,j,1)+0.866*RGB(i,j,2)+0.051*RGB(i,j,3);
            
            RGBp(i,j,3)=-0.012*RGB(i,j,2)+1.019*RGB(i,j,3)-0.007*RGB(i,j,1);
            
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
            
            Rec(i,j,1)=1.8635*RGB(i,j,1)-1.2420*RGB(i,j,2)+0.2780*RGB(i,j,3);
            
            Rec(i,j,2)=1.2734*RGB(i,j,2)-0.1792*RGB(i,j,1)-0.0845*RGB(i,j,3);
            
            Rec(i,j,3)=0.9823*RGB(i,j,3)+0.0065*RGB(i,j,2)+0.0107*RGB(i,j,1);
            
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
            
            Sim(i,j,1)=0.593*Rec(i,j,1)+0.579*Rec(i,j,2)-0.118*Rec(i,j,3);
      
            Sim(i,j,2)=0.866*Rec(i,j,2)+0.083*Rec(i,j,1)+0.051*Rec(i,j,3);
            
            Sim(i,j,3)=1.019*Rec(i,j,3)-0.012*Rec(i,j,2)-0.007*Rec(i,j,1);
            
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
