im=imread('cameraman.tif');
im=double(im);

degraded_im=add_gaussian_noise(im,30);

delta=1/8;
k=50;

denoised_im1=heat_equation(degraded_im,delta,k);
imshow(denoised_im1/255);

p=round(k*delta+1);
filter=fspecial('gaussian',2*p-1,sqrt(2*k*delta));
denoised_im2=imfilter(degraded_im,filter,'replicate');

imshow(denoised_im2/255);

im_con=marr_hildreth(im,20);
imshow(~im_con);

im_con2=marr_hildreth(denoised_im2,5);
imshow(~im_con2);

denoised_im3=perona_malik(degraded_im,delta,k,20);
imshow(denoised_im3/255.);
im_con2=marr_hildreth(denoised_im3,20);
imshow(~im_con2);

% Variational approaches
lambda=1;
tao=1/(lambda+4);
denoised_tk=Denoise_Tikhonov(degraded_im,k,tao,lambda);
imshow(denoised_tk/255.);

lambda=0.1;
tao=0.1;
epsilon=1;
denoised_tv=Denoise_TV(degraded_im,tao,lambda,epsilon);
imshow(denoised_tv/255.);

lambda=0.1;
tao=0.1;
deconvolution_tv=Deconvolution_TV(denoised_im2,filter,tao,lambda);
imshow(deconvolution_tv/255.);

Im1=load_sample_png;
mask1=load_sample_png;

lambda=0.1;
tao=0.1;
inpaint_im1=Inpainting_TV(Im1,mask1/255.,tao,lambda);
inpaint_im2=Inpainting_Tichonov(Im1,mask1/255.,tao,lambda);
imshow(inpaint_im1/255.);
imshow(inpaint_im2/255.);
