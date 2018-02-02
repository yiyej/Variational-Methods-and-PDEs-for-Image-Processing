function u=heat_equation(f,delta,k)

    u=f;
    for i=1:k
        u=u+delta*div(gradx(u),grady(u));
    end


end