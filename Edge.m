%####find Edge
function l = Edge (Im,pos,Wedge,R)
sed = strel('disk',3);
[m,n] = size(Im);

%#################
Im  = imcrop(Im,[10 0 n-20 m]);
Im = 255*edge(Im,'canny',[],'horizontal');
[m,n] = size(Im);
Im(:,1)=1;
Im(:,n)=1;
Im(1,:)=0;
Im(m,:)=0;
Im = Im-imclearborder(Im,8);
[m,n]=size(Im);
if Wedge == 1
    pos=-1 * pos;
else
end
if pos == -1
    for iii=1:n; %(x)
        for ii=1:m;
            if Im(ii,iii)> 0;
                    Im(ii,iii)= 1;
                    Im(ii+1:m,iii)=0;
            else
            end
        end
    end  
else
    for iii=1:n; %(x)
        for ii=1:m;
            if Im(m-ii+1,iii)> 0;
                Im(:,iii) = 0;
                Im(m-ii-10,iii)= 1;
                break
            else
            end
        end
    end  
end

l=Im;
end
    