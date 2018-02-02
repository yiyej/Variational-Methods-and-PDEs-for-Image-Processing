function drawMotion(u,v,I2)
delta=10;
c=size(I2,3);
figure;
[y x]=meshgrid(1:delta:size(u,2), 1:delta:size(u,1));
imagesc(I2/255);
if c==1
    colormap gray
end
axis off
set(gca,'Position',[0 0 1 1])
hold on
quiver(y,x,v(1:delta:size(u,1), 1:delta:size(u,2)),u(1:delta:size(u,1), 1:delta:size(u,2)),'r','LineWidth',1.);

