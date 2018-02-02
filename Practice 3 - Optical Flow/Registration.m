function im_reg=Registration(u,v,im)

[m,n,channel]=size(im);

[y,x]=meshgrid(1:n,1:m);

x=x+u;
y=y+v;

    %check and handle out-of-bound problem
    x=max(min(x,m),1);
    y=max(min(y,n),1);

for i=1:channel
    im_reg(:,:,i)=interp2(im(:,:,i),y,x,'linear');
end

%any(isnan(im_reg))

end