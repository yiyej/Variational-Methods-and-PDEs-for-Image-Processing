function [u,v]=getop_fb(im1,im2,tao,lambda,epsilon,u_up,v_up)
 
[m,n]=size(u_up);  
%% precompute-gradient,divergency,temporal derivative on frame1
    gradx1=gradx(im1);
    grady1=grady(im1);
    dt1=im1-im2;
%% Implement algorithm (4.4) 
u = zeros(m,n); %initialize as 0
v = u;
u_old = u;
v_old = v;

while(1)

    %Forward: gradient descent
    u_tilde = u+tao*div(gradx(u+u_up),grady(u+u_up));
    v_tilde = v+tao*div(gradx(v+v_up),grady(v+v_up));
    
    %Backward: proximity operator
    [u,v]=Prox(u_tilde,v_tilde,tao,lambda,gradx1,grady1,dt1);

    %stopping threshold
    threshold=norm(u_old(:)-u(:))/(norm(u_old(:))+1e-14) + norm(v_old(:)-v(:))/(norm(v_old(:))+1e-14)
    
    if threshold < epsilon
        break;
    end
    
    u_old = u;
    v_old = v;

end

end