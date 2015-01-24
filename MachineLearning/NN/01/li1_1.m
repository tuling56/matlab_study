 clear all;     %用于清除命令窗口中的变量
 %绘制三维图形
[X,Y]=meshgrid(-8:0.1:8);
 Z=sinc(X);
 mesh(X,Y,Z);               %效果如图1-3所示
 set(gcf,'color','w');   %设置图形窗口背景为白色
 
 [X,Y]=meshgrid(-10:0.3:10);
 R=sqrt(X.^2+Y.^2)+eps;
 Z=sin(R)./R;
 mesh(X,Y,Z);    

 surf(X,Y,Z,'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
 daspect([5 5 1]);
 axis tight;
 view(-45,35);
 camlight left

