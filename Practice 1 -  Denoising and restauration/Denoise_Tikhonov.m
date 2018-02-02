function u = Denoise_Tikhonov(f,k,tao,lambda)
    
    u=zeros(size(f));
    for i=1:k
        increment=lambda*(u-f)-div(gradx(u),grady(u));
        u=u-tao*increment;
    end

end

