
%% -----------------Horn and Schunck model for color images-----------------------
%% load picture
clear all;
im1=load_sample_png;
im2=load_sample_png;
%% set parameters
tao=0.02;
lambda=1/400;
epsilon=0.01;
%% compute optical flow
[u,v]=getop(im1,im2,tao,lambda,epsilon);
%% visulize optical flow
im_op=flowToColor(u,v);
imshow(uint8(im_op));

drawMotion(u,v,im1);
%% compute registration image and visulize
im2_reg=Registration(u,v,im2);

imagesc(im2_reg/255);
imagesc(im1/255);
axis off;
set(gca,'Position',[0 0 1 1]);

figure('NumberTitle', 'off', 'Name','Error between registration image of I2 and I1');
imshow(1-abs(im2_reg-im1)/255.);
title('Error between registration image of I2 and I1');
axis off;
set(gca,'Position',[0 0 1 1]);

%% ------------------------Muti-resolution pyramid-------------------------
%% load picture
clear all;
im1=load_sample_png;
im2=load_sample_png;
%% set parameters
levels = 5;
tao = 0.005;
lambda=1/400;
epsilon=0.01;
%% compute optical flow
tic;
[u,v]=Multi_resolution_algorithm(im1,im2,levels,tao,lambda,epsilon,'hs');
toc;
%% ---------------Muti-resolution pyramid with Forward-Backword algorithm---------------
%% load picture
clear all;
im1=load_sample_png;
im2=load_sample_png;

im1=255*rgb2gray(im1/255);
im2=255*rgb2gray(im2/255);
%% set parameters
levels = 5;
tao = 1/8;
lambda=1/300;
epsilon=0.01;
%% compute optical flow
tic;
[u,v]=Multi_resolution_algorithm(im1,im2,levels,tao,lambda,epsilon,'fb');
toc;
%% ---------------Muti-resolution pyramid with Total variation regularization---------------
%% load picture
clear all;
im1=load_sample_png;
im2=load_sample_png;

im1=255*rgb2gray(im1/255);
im2=255*rgb2gray(im2/255);
%% set parameters
levels = 5;
tao = 1/3;
lambda=1/2;
epsilon=0.01;
%% compute optical flow
tic;
[u,v]=Multi_resolution_algorithm(im1,im2,levels,tao,lambda,epsilon,'tv');
toc;