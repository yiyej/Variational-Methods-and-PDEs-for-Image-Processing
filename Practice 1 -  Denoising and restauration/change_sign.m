function Map=change_sign(J)

%detects locations where J changes its sign
%valeur du niveau de gris du contour: s (noir=0)
%Use: Map=change_sign(J);

[m,n]=size(J);



Map=zeros(m,n); 

%start with columns
for i=1:m
    for j=1:n-1        
        if (J(i,j)*J(i,j+1)<=0)
            if (abs(J(i,j))<=abs(J(i,j+1)))
                Map(i,j)=1;
            else
                Map(i,j+1)=1;
            end
        end
    end
end

%the with lines
for j=1:n
    for i=1:m-1        
        if (J(i,j)*J(i+1,j)<=0)
            if (abs(J(i,j))<=abs(J(i+1,j)))
            Map(i,j)=1;
            else
                Map(i+1,j)=1;
            end
        end
    end
end


%Remark: there are a lot of for loops, if anyone want to reimplemnt it in
%vectorial form, I would greatly appreciate :)