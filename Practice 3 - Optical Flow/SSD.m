function ssd=SSD(a,b)

    a = double(a);
    b = double(b);
    
    for i=1:3
        ta = a(:,:,i);
        tb = b(:,:,i);
        t(:,i) = norm(ta(:) - tb(:));
    end
          
    ssd = sum(t)/3; 

end