function [f0,f1,f2,f3] = Plt(fstI,I,MasIm,ShIm,EdIm,CrIm,WinIm,j,Data,VarName,t,A1,A2,pos,d,Wedge,PicPath,R,xcrop,sh,rx,ry);
edgex = 	80;

if Wedge == 0
    shif  =  sh(1,1);
else
    shif  =  sh(1,1) + pos*d;
end
[mw,nw] =size(CrIm);
t(j) =  j/50;

%##############-----Fitting----#######
%#####################################
[y, x] = find(EdIm);
y = y -((shif)*(pos-1)/2 -(5*(pos+1)))*ones(size(y,2),1);
x = x + (sh(1,2)+10)*ones(size(y,2),1);
y1=y(rx-edgex:rx+edgex);
x1=x(rx-edgex:rx+edgex);

T=[x1,y1];
h = (sortrows(T,2));
H = h(size(y1),2);
H2 = h(size(y1),1);
if (H2(1,1)-H2(2,1))^2 <100
    First =  rx-edgex+5;
    End   =  rx+edgex-5;
else
    if H2(1,1) < H2(2,1)
        First = H2(1,1)-10;
        End   = H2(2,1)-10;      
    else
        First = H2(2,1)-10;
        End   = H2(1,1)-10;
    end
end


x2=x(First:End);
y2=y(First:End);

 
ft = fittype(strcat('a1*(x2-',num2str(rx),')+ a2'),...
        'dependent',{'y2'},'independent',{'x2'},...
        'coefficients',{'a1','a2'});
f = fit(x2,y2,ft,'StartPoint',[0,60]);
    A1(j)= -f.a1;
    A2(j)= 0.060*((-f.a2)+(pos+1)*(ry/2)-(pos-1)*(R+10)/2 );
    %A3(i)= f.a3;
    %A4(i)= f.a4;
subplot(3,2,1);
plot(t,A1,'DisplayName','Alpha','color','black','marker','o');hold off;
xlabel('time (s)')
ylabel('\alpha(Rad)')
subplot(3,2,2);
plot(t,A2,'DisplayName','Intercept','color','black','marker','o');hold off;
xlabel('time (s)')
ylabel('Intercept (\mu m')
axis on;

axis on;
if j >1
    if (A1(j)-A1(j-1))^2 > (0.06)
    A1(j)= A1(j-1)- 0.001;
    else
    end
else
end
if (A1(j))^2 > (0.25)^2
    A1(j) =A1(j-1)- 0.001;
else
end
Data.(char(cellstr(VarName)))(j,:)=[t(j),A1(j),A2(j),3,4];
subplot(2,1,2);
title(sprintf('edge in frame' , num2str(t)), 'FontSize', 9, 'Interpreter', 'None');
imshow(1.1*WinIm);
%axis('on', 'image')
hold on
scatter(x,y,2,'g','.')
%scatter(x1,y1,2,'r','+')
%scatter(x2,y2,3,'b','o');
plot(f,'r.',x(First-80:End+80),y(First-80:End+80),'g','.');
legend('hide')
%title(sprintf('Found edge (green) and fit line (red) on picture'), 'FontSize', 9, 'Interpreter', 'None');

%sgtitle('To find the border from the raw video')

f0=t;
f1=A1;
f2=A2;
f3=Data.(char(cellstr(VarName)))(j,:);
FileName = sprintf('Figure %06d', j);
fullFileName = fullfile(PicPath, FileName);
saveas(gcf,fullFileName,'png')
%############################


%##########################################
%subplot(4,4,15);
%pl  =  plot(p7,A3,'DisplayName','A1');hold off;
%title('A1', 'FontSize', 9, 'Interpreter', 'None');
%axis on;
%subplot(4,4,15);
%pl  =  plot(p7,A4,'DisplayName','A1');hold off;
%title('A1', 'FontSize', 9, 'Interpreter', 'None');
%axis on;


