function u = compute_energy_smooth(u,a1,a2,lambda,epsilon)

    u_old = u;
    tao = 0.1;
    
    while(1)
    
        gradxu = gradx(u);
        gradyu = grady(u);
    
        norm_epsilon = sqrt(gradxu.^2 + gradyu.^2 + epsilon^2);
  
        px = gradxu./norm_epsilon;
        py = gradyu./norm_epsilon;
       
        u = min(max(u + tao*(div(px,py)-lambda*a1+lambda*a2),0),1);
    
        if norm(u_old(:)-u(:),2) < epsilon
            break;
        end
        
        u_old = u;
    end

end