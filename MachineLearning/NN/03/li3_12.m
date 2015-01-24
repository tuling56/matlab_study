clear all;
P=[1 -1.2];
T=[0.5 1];
[R,Q]=size(P);
[W,B]=size(T);
%绘制误差曲面图
wrange=-2:0.2:2;            %限定W值的坐标范围
brange=-2:0.2:2;            %限定B值的坐标范围
ES=errsurf(P,T,wrange,brange,'purelin');    %求神经元的误差平面
mesh(ES,[60,30]);           %求神经元的误差平面，效果如图3-31所示
set(gcf,'color','w');           %将曲面图背景设为白色
%设计网络权值并绘制投影图
figure;
net=newlind(P,T);            %求理想的权值和偏差
dw=net.iw{1,1};              %赋理想的权值和偏差
db=net.b{1};                 %赋理想的偏差
%作等高线图，ES为高，返回等高线矩阵C，列向量h是线或对象的句柄
[C,h]=contour(wrange,brange,ES);
clabel(C,h);                 %一条线一个句柄，被作输入
colormap cool;               %桌面的颜色cool（青和洋色）
axis('equal');
hold on;
plot(dw,db,'rp','LineWidth',2.5);
xlabel('W'); ylabel('B');
lr=menu('选择学习速率：',...
    '1.2*maxlinr',...
    '2.8*maxlinr');
disp('')
%训练权值
disp_freq=1;
max_epoch=28;
err_goal=0.001;
if lr==1
    lp.lr=1.2*maxlinlr(P,'bias');
else
    lp.lr=2.8*maxlinlr(P,'bias');
end
a=W+P+B;
A=purelin(a);
E=T-A;                 %求误差
sse=sumsqr(E);         %求误差矩阵元素的平方和
errors=[sse];
for epoch=1:max_epoch     %训练权值
    if sse<err_goal
        epoch=epoch-1;
        break;
    end
    lw=W;     lb=B;
    dw=learnwh([],P,[],[],[],[],E,[],[],[],lp,[]);
    db=learnwh(B,ones(1,Q),[],[],[],[],E,[],[],[],lp,[]);
    W=W+dw;
    B=B+db;
    a=W*P+B;
    A=purelin(a);
    E=T-A;
    sse=sumsqr(E);
    errors=[errors sse];       %把误差变为一个行向量
    if rem(epoch,disp_freq)==0
        plot([lw,W],[lb,B],'g-');   %显示权值与偏差向量训练图，效果如图3-34所示
        drawnow
    end
end
hold off;
>> figure;
m=W*P+B;
a=purelin(m);
plot(a);                 %作每次训练的误差图，效果如图3-35所示
