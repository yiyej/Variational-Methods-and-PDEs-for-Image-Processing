function [A B]=ProjB(A,B)

    norm2=sqrt(A.^2+B.^2);
    index=norm2>1;
    
    A(index)=A(index)./norm2(index);
    B(index)=B(index)./norm2(index);
    
end