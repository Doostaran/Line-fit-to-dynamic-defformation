%###Cropping
function [CrIm,WinIm,sh]= Crop(CovIm,R,ry,rx,xcrop,pos,m,n,avg,I)

if pos == 1;
    
    CrIm  = imcrop(CovIm,floor([0 0 n ry-R]));
    WinIm = imcrop(I,[0 0 n (ry+R+10)]);
else
   
    CrIm  = imcrop(CovIm,floor([0 ry+R n m]));
    WinIm = imcrop(I,[0 (ry-R-10) n m]);
end  
sh = (size(WinIm)-size(CrIm));
end
