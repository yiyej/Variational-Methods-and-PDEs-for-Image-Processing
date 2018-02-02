%TP1 - denoising and restauration

%read data
im_data = imread('cameraman.tif');
im_data = double(im_data);

imagesc(im_data); %original picture

%add gaussian noise
[m,n] = size(im_data);
sd = 30; % SD of noise
im_data_noise = im_data + sd*randn(m,n);

imagesc(im_data_noise)
colormap gray;


%------------ test heat equation -------------

%apply heat_equation to the noisy picture
k = 20;
dt = 1/8;

im_data_denoised_heateq = heat_equation(im_data_noise , dt , k);
figure;
imagesc(im_data_denoised_heateq);
colormap gray;


%------------ check the solution of heat equation -------------

%create gaussian kernel
P = floor(k*dt + 1);
sigma = sqrt( 2*k*dt );

%create by function 'fspecial'
filter = fspecial( 'gaussian' , 2*P-1 , sigma );
im_data_denoised_convolution_fspecial =  ...+ Enter
        imfilter(im_data_noise , filter , 'conv' , 'replicate');
imagesc(im_data_denoised_convolution_fspecial)

%create by euqation(2.3)
G_eq23 = eye(2*P-1);

for i = 1:2*P-1
    for j = 1:2*P-1
        G_eq23(i , j) =exp( -((i-P)^2+(j-P)^2)/(2*sigma^2) )/( 2*pi*sigma^2 );
    end
end

im_data_denoised_convolution_eq23 =  ...+ Enter
         imfilter(im_data_noise , G_eq23 , 'conv' , 'replicate');
imagesc(im_data_denoised_convolution_eq23)



%------------ contour detection -------------
im_data_contour = marr_hildreth(im_data , 1);
im_data_denoised_contour = marr_hildreth(im_data_denoised_heateq , 1);
imagesc(im_data_contour);
imshow(im_data_denoised_contour);

im_data_contour = marr_hildreth(im_data , 10);
im_data_denoised_contour = marr_hildreth(im_data_denoised_heateq , 10);
imagesc(im_data_contour);
imshow(im_data_denoised_contour);



%------------ test perona-malik equation -------------
im_data_denoised_pm = perona_malik(im_data_noise , 1/8 , 100 , 15);
imagesc(im_data_denoised_pm);

%Apply the Marr Hildreth contour detector on the obtained results
im_data_denoised_pm_contour = marr_hildreth(im_data_denoised_pm , 10);
imagesc(im_data_denoised_pm_contour);



%------------ test Tikhonov regularization -------------
im_data_denoised_tikhonov = denoise_tikhonov(im_data_noise_gaussian , 20 , 1);
imagesc(im_data_denoised_tikhonov);



%------------ test Tikhonov regularization -------------
im_data_denoised_TV = denoise_TV(im_data_noise , 0.1 , 500 , 0.01,5);
imagesc(im_data_denoised_TV);




















