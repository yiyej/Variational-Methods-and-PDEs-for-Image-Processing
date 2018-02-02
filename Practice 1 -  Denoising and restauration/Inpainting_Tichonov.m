function u=Inpainting_Tichonov(f,M,tao,lambda)

    u=zeros(size(f));
    u_old=u;
    while(1)
        gradxu=gradx(u);
        gradyu=grady(u);
        
        increment=lambda*(f-u).*M+div(gradxu,gradyu);
        u=u+tao*increment;
        
        threshold=norm(u_old(:)-u(:),2)/(norm(u_old(:))+1e-14)
        if threshold<0.001,break;end
        
        u_old=u;
    
    end
    
end