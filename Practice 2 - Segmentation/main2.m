I = double(imread('eight.tif'));
I = double(I);
imag esc(I);
colormap gray;

u = roipoly(I/255.); 
%% ------------------------- parameters setting ---------------------------
%%
epsilon = 1;
lambda = 0.001;
c1=110;
c2=227;
tao=0.1;
mu=0.5;
%% precompute
I1=lambda*(I-c1).^2;
I2=lambda*(I-c2).^2;
%% algorithm
u_old = u;
n=0;
while(1)
    
   norm_epsilon=gradx(u).^2+grady(u).^2.+epsilon^2; %没开根号 epsilon也要平方
   norm_epsilon=sqrt(norm_epsilon); %不是数 而是矩阵
   
   div_u=div(gradx(u)./norm_epsilon , grady(u)./norm_epsilon);
   increment=div_u-I1+I2;%第二个是加号
   
   u=u+tao*increment;
   
   u=min(max(0,u),1);
   
   threshold=norm(u(:)-u_old(:),2)
   n=n+1
   if threshold < 0.01
       break;
   end
   
   u_old=u;
   
end
u_mu=u>mu;

imagesc(I);
colormap gray
hold on
contour(u_mu,'r','Linewidth',0.5);
