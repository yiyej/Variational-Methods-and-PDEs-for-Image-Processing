function out=add_gaussian_noise(I,s)
    
    [m n]=size(I);
    out=I+s*randn(m,n);


end