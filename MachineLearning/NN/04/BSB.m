function C=BSB(X,beta)
% 这个M文件为盒中脑模型示例
% X 为负输入矩阵
% beta 为负反馈系数
%C   为返回负反馈收敛迭代
% 于Hugh Pasika 1997年开发
hold on
flag=0;
x=x(:);
c=2;  %C is a general purpose counter
W=[.035 -.005;-.005 .035];
% set axes
set(gca,'XLim',[-1 1]);
set(gca,'XLim',[-1 1]);
%plot first point
plot(x(1),x(2),'ob');
Og=x';
% plot center lines
plot([0,0],[1,-1],'+');
plot([1,-1],[0,0],'+');
% label plot
set(gca,'YTick',[-1 1]);
set(gca,'XTick',[-1 1]);
while flag<1
    y=x+beta*W*x;
    x=(y(:,:)<-1)*(-1)+(y(:,:)>1)+(y(:,:)>-1 & y(:,:)<1).*y;
    u(c,:)=x';
    c=c+1;
    if u(c-1,:)==u(c-2,:),
        flag=10;
        c=c-3;
    end
end
u=u(2:c+1,:);
Og
plot([Og(1,1) u(1,1)],[Og(1,2) u(1,2)],'-b')
plot(u(:,1),u(:,2),'ob')
plot(u(:,1),u(:,2),'-b')
drawnow
disp(c);
set(gca,'Box','on')
hold off
