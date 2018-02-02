function [u v]=Prox(u_tilde,v_tilde,tao,lambda,gradx1,grady1,dt1)
    
    [m,n,~]=size(u_tilde);
    
    increment_prox_x = zeros(m,n);
    increment_prox_y = zeros(m,n);
    
    rho = dt1+gradx1.*u_tilde+grady1.*v_tilde;
    normi = gradx1.^2+grady1.^2;
    
    index1 = rho<=-tao*lambda*normi;
      increment_prox_x(index1) = tao*lambda*gradx1(index1);
      increment_prox_y(index1) = tao*lambda*grady1(index1);   
       
    index1 = rho>= tao*lambda*normi;
      increment_prox_x(index1) = -tao*lambda*gradx1(index1);
      increment_prox_y(index1) = -tao*lambda*grady1(index1);  
       
    index1 = abs(rho) < tao*lambda*normi;
      increment_prox_x(index1) = -gradx1(index1).*rho(index1)./normi(index1);
      increment_prox_y(index1) = -grady1(index1).*rho(index1)./normi(index1);
     
    u=u_tilde+increment_prox_x;
    v=v_tilde+increment_prox_y; 
    
end