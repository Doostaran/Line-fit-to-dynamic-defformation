%###Sharpping
function I = Sharp (I,pos,R)

se0 = strel('line',3,0);
se90 = strel('line',4,90);
se100 = strel('line',8,90);
Im = imsharpen(I,'Radius',2,'Amount',1)/2 + I/2;
J = imnoise(Im, 'gaussian',0, 0.005);
[m,n] = size(I);
%########################
I = imgaussfilt(I,[1,1]);
I = imsharpen(I,'Radius',3,'Amount',3)/2 + I/2;
I = imgaussfilt(I,[1,3]);
I = J/5 + 4*(I/5);
I = imgaussfilt(I,[2,2]);
I = imsharpen(I,'Radius',6,'Amount',5)/2 + I/2;
I = imgaussfilt(I,[2,6]); 
I = imsharpen(I,'Radius',10,'Amount',7)/2 + I/2;
I = imopen(I,se0);
I = medfilt2(I);
I = imsharpen(I,'Radius',20,'Amount',5)/2 + I/2;
I = imsharpen(I,'Radius',3,'Amount',5)/2 + I/2;
I = imgaussfilt(I,[3,2]);
avg   = mean(mean(I));
I =I<avg/1.9;
I(:,1)=1;
I(:,n)=1;
I(1,:)=0;
I(m,:)=0;
I = I-imclearborder(I,8);
I = imfill(I ,'holes');
I = I-imclearborder(I,8);
I = imgaussfilt(I,2);
I = imgaussfilt(I,[3,2]);


%Im = Im-imclearborder(Im,8);

    
    