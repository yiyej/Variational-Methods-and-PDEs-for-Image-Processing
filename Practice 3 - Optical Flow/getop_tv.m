function [u,v]=getop_tv(im1,im2,tao,lambda,epsilon,u_up,v_up)
 
[m,n]=size(u_up);  
%% precompute-gradient,divergency,temporal derivative on frame1
    gradx1=gradx(im1);
    grady1=grady(im1);
    dt1=im1-im2;
    
    %compute time step: sigma
    gradx_u=gradx(u_up);
    grady_u=grady(u_up);
    
    max_u=max(gradx_u(:).^2+grady_u(:).^2);
    
    gradx_v=gradx(v_up);
    grady_v=grady(v_up);
    
    max_v=max(gradx_v(:).^2+grady_v(:).^2);
    
    norm_max=max(max_u,max_v);
    norm_max=sqrt(norm_max);
    
    sigma=1/(2+norm_max);
    
%% Implement algorithm (4.4) 
u = zeros(m,n); %initialize as 0
v = u;

z_u_x = u;
z_u_y = u;
z_v_x = u;
z_v_y = u;

u_old = u;
v_old = v;

while(1)

    [z_u_x,z_u_y]=ProjB(z_u_x + sigma*gradx(u+u_up),z_u_y + sigma*grady(u+u_up));
    [z_v_x,z_v_y]=ProjB(z_v_x + sigma*gradx(v+v_up),z_v_y + sigma*grady(v+v_up));
    
    [u,v]=Prox(u+tao*div(z_u_x,z_u_y),v+tao*div(z_v_x,z_v_y),tao,lambda,gradx1,grady1,dt1);
    
    %stopping threshold
    
    %threshold=norm(u_old(:)-u(:),'inf')+ norm(v_old(:)-v(:),'inf');
    threshold=norm(u_old(:)-u(:))/(norm(u_old(:))+1e-14) + norm(v_old(:)-v(:))/(norm(v_old(:))+1e-14)
    
    if threshold < epsilon
        break;
    end
    
    u_old = u;
    v_old = v;

end
end