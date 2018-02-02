function upu=expand_height(u)

[m,n]=size(u);

%expand height
    upu=upsample(u,2);

%interpolate
    [y,x]=meshgrid(1:n,1.5:1:(m+1));
    u_interp=interp2(u,y,x,'linear');
       
    for i=1:m
        upu(2*i,:)=u_interp(i,:);
    end
    
    upu(2*m,:)=upu(2*m-1,:); %simple solution to deal with NaNs in the last row of u_interp 

end