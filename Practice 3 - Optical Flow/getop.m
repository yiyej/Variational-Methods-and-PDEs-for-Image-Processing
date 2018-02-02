function [u,v]=getop(im1,im2,tao,lambda,epsilon,u_up,v_up)
%% check if this function is usded in Horn-Schunck model or Multi-resolution pyramid
if nargin == 5
    %in Horn-Schunck model context
   flag_used_HS = 1;
elseif nargin == 7
    %in Multi-resolution pyramidl context
   flag_used_HS = 0;
else
    error('Misuse of this function!');
end
%% precompute-gradient,divergency,temporal derivative on frame1
im1=double(im1);
im2=double(im2);
[m,n,channel]=size(im1);
  
  % -> Be careful that these derivatives are computed on EACH color channel
    gradx1=zeros(m,n,channel);
    grady1=gradx1;
    div1=gradx1;
    dt1=gradx1;
    
  for i=1:channel
       gradx1(:,:,i)=gradx(im1(:,:,i));
       grady1(:,:,i)=grady(im1(:,:,i));
       div1(:,:,i)=div(gradx1(:,:,i),grady1(:,:,i)); 
       
       if flag_used_HS == 1
            dt1(:,:,i)=im2(:,:,i)-im1(:,:,i);
       else
            dt1(:,:,i)=im1(:,:,i)-im2(:,:,i);
       end
       
  end

%% Implement algorithm (2.2) 
u = zeros(m,n); %initialize as 0
v = u;
u_old = u;
v_old = v;
while(1)

    %optical flow constranit quantity
    for i=1:channel
        op_quan(:,:,i)=dt1(:,:,i)+gradx1(:,:,i).*u+grady1(:,:,i).*v;
    end
    
    if flag_used_HS == 1
        u_total = u;
        v_total = v;
    else
        u_total = u+u_up;
        v_total = v+v_up;
    end
       
    %update horizontal motion u
    u=u+tao*(div(gradx(u_total),grady(u_total)) - lambda*sum(op_quan.*gradx1,3));
    
    %update vertical motion v
    v=v+tao*(div(gradx(v_total),grady(v_total)) - lambda*sum(op_quan.*grady1,3));
    
    %stopping threshold
      % -> we initialize u_old as 0 so, to avoid be divided by 0,we add 1e-14
      % -> dont use sum,because u_old-u的元素有正有负，sum起来没意义，所以要用绝对值加起来 
    threshold=norm(u_old(:)-u(:))/(norm(u_old(:))+1e-14) + norm(v_old(:)-v(:))/(norm(v_old(:))+1e-14)
    
    if threshold < epsilon
        break;
    end
    
    u_old = u;
    v_old = v;

end




end