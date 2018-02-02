function contour = marr_hildreth(u , epsilon)

index1=sqrt(gradx(u).^2+grady(u).^2)>epsilon;
index2=change_sign(div(gradx(u),grady(u)));

contour=index1&index2;

end