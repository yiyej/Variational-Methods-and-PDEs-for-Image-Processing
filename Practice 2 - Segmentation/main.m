I = double(imread('eight.tif'));
I = double(I);
imag esc(I);
colormap gray;

mask = roipoly(I/255.); 
phi = signed_distance_from_mask(mask);
surf(phi);

%% ------------------------- parameters setting ---------------------------
%%
eta = 1;
epsilon = 1;
lambda = 0.001;
%% ----------------------------- Algorithm --------------------------------
%% 
h = Heavyside_eta(phi , eta);
h_old = h;
n = 0;
while(1)
    
    c1=sum(sum(I.*h)/sum(h(:)));
    c2=sum(sum(I.*(ones(size(h))-h)))/sum(1-h(:));
    
   norm_epsilon=gradx(phi).^2+grady(phi).^2.+epsilon^2; %没开根号 epsilon也要平方
   norm_epsilon=sqrt(norm_epsilon); %不是数 而是矩阵
   
   div_phi=div(gradx(phi)./norm_epsilon , grady(phi)./norm_epsilon);
   increment=div_phi-lambda*(I-c1).^2+lambda*(I-c2).^2;%第二个是加号
   increment=increment.*delta_eta(phi, eta);
   
   tao=1./(2*max(abs(increment(:))));%绝对值
   phi=phi+tao*increment;
   h = Heavyside_eta(phi , eta);
   
   threshold=norm(h(:)-h_old(:),2);
   if threshold < 0.3
       break;
   end
   
   h_old=h;
   
   n=n+1
   if mod(n,10) ==0 %这里没写== %两次卡在这个地方了马马碧
        phi=signed_distance_from_mask(phi>0);
   u=phi>0;
   imagesc(I);
   colormap gray
   hold on
   contour(u,'r','Linewidth',3);
   drawnow; %要写才会in real time画出来
   end
   
   
end






