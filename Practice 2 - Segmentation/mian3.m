I = double(imread('eight.tif'));
I = double(I);
imagesc(I);
colormap gray;

u = roipoly(I/255.); 
%% ------------------------- parameters setting ---------------------------
%%
lambda = 0.01;
sigma = 0.5;
c1=110;
c2=227;
tao=0.25;
mu=0.5;
%% precompute
I1=lambda*(I-c1).^2;
I2=lambda*(I-c2).^2;
%% algorithm (4.10)
u_old = u;

zx=zeros(size(u));
zy=zeros(size(u));

n=0;
tic
while(1)
    
   zx=zx+sigma*gradx(u);
   zy=zy+sigma*grady(u);
   
   [zx,zy]=ProjB(zx,zy);
  
   u=min(max(0,u+tao*(div(zx,zy)-I1+I2)),1);
   
   threshold=norm(u(:)-u_old(:),2)
   n=n+1
   
   if threshold < 0.001
       break;
   end
   
   u_old=u;
   
end
toc
u_mu=u>mu;

imagesc(I);
colormap gray
hold on
contour(u_mu,'r','Linewidth',0.5);
