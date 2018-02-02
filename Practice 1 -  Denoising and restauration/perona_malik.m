function u = perona_malik(f,delta,k,alpha)

    u=f;
    for i=1:k
        
        gx=gradx(u);
        gy=grady(u);
        norm2=gx.^2+gy.^2;
        c=1./(norm2/(alpha.^2)+1);
        u=u+delta*div(c.*gradx(u),c.*grady(u));
        
    end

end
