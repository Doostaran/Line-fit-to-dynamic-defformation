clc;close all;clear all;
%################################################%###############
%#####  find dynamic edge curve equation: Mohammad Doostaran ####
%#####  All rights reserved          m.doostaran@gmail.com   ####
%################################################%###############
%#####  JUST EDIT here  #########################%###############
Adss    = 'Vid\';                  %# Address of video folder
Vinme   = 'test.mp4';              %# name of video
VarName = 'sup';                   %# Name of Group Data
start   = 20;                      %# first sepprating fram
Start   = 1;                       %# start frame Analyzing
en      = start+100;               %# end  sepprating fram
Endt    = 100 ;                    %# end frame Analyzing
p       = 2;                       %# Input in Which Vare group In Data
R       = floor(2.37 * 17);        %# microsphere radius in pixel
deg     = -0;                      %# Rotation befor aalizing
d       = 30;                      %# Sift green edge
Wedge   = 0;                       %# far=1    &    near =0 
pos     = 1;                       %# where is tube  (Up; +1, Down: -1)
rx      = 420;                     %# where the trap is on x axis
ry      = 200;                     %# where the trap iz on y axis
xcrop   = 200                      %# wide of window 
%################################# Video to pics ################
Vidobj    = VideoReader(strcat(Adss,Vinme));     %# make an video object
Framenum  = Vidobj.NumberOfFrames                %# find number of frames
FrameRate = floor(Vidobj.FrameRate);             %# find frame rate
s1=strcat('Pic\',Vinme,sprintf('\\%04d',p),'\'); %# Save picturs in folder
delete(strcat(s1,'*.png'))                       %# Clear picturs in folder
mkdir(s1);

for i=start:en
    I = read(Vidobj,i);                        %# choose dynamic fram
    %I = imrotate(I,deg);                      %# rotate if you want
    I2= imcrop(I,[1 1 700 400]);               %# crop it
    path=sprintf('\\%01d  s.png',i);           %# dynamic new name
    imwrite(I2,strcat(s1,path),'png');         %# writing format
    i
end

%############################# Frame anlaizig  ####################
PicPath = strcat('Fig\',num2str(p));
mkdir(PicPath);
load('Data.mat');
s2 ='*.png'; 
D  =(Endt - Start)-1;
imagelist = dir(strcat(s1,s2));
A1=zeros(1,D);
A2=zeros(1,D);
t=zeros(1,D);
delete(strcat(PicPath,s2)) 
Data.Properties.VariableNames(p) = cellstr(VarName);
for i=1:numel(imagelist)
    %##################_find edge__########
    if i> Start & i<Endt+1
        fstI = imread(fullfile(strcat(s1),imagelist(i).name));
        I    = 0.9*fstI(:,:,1);  
        I    = imrotate(I,deg);
        [m,n] = size(I);
        I(ry-2:ry+2,rx-2:rx+2)     =0; 
        I     = imcrop(I,floor([abs(20*deg) abs(20*deg) n-abs(40*deg) m-abs(40*deg)]));
        avg   = mean(mean(I));
        I     = ((avg+20)/avg)*I;
        j = i-Start
        MasIm                 = Mas(I,avg,avg,avg);
        [CrIm,WinIm,sh]       = Crop(MasIm,R,ry,rx,xcrop,pos,m,n,avg,I);
        ShIm                  = Sharp(CrIm,pos,R);
        EdIm                  = Edge(ShIm,pos,Wedge,R);  
        [f0,f1,f2,f3]         = Plt(fstI,I,MasIm,ShIm,EdIm,CrIm,WinIm,j,Data,VarName,t,A1,A2,pos,d,Wedge,PicPath,R,xcrop,sh,rx,ry);
        Data.(char(cellstr(VarName)))(j,:) = f3; A2   = f2; A1   = f1; t    = f0;   
    else
    end
end
save('Data.mat','Data')
clear Adss en Framenum FrameRate I2 path start Vidobj Vinme avg MasIm n PicFol PicPath VarName VidPath degpos rx xcrop ry End Start D j s2 pos deg sh Endt s1 P R t A1 A2 i f0 f1 f2 EdIm Wedge Fram f3 i imagelist ShIm I CovIm CrIm edge fstI m p  WinIm Wx Wy xo d;
